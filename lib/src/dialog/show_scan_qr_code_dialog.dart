
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:pn2_package/pn2_package.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';


Future<QrCodeData?> showScanQrCodeDialog({
  required BuildContext context,
  String? userType
}) {
  return showDialog<QrCodeData>(
    context: context,
    builder: (_) => ScanQrCodeDialog(userType: userType)
  );
}

class ScanQrCodeDialog extends StatefulWidget {

  final String? userType;
  const ScanQrCodeDialog({
    Key? key,
    required this.userType
  }): super(key: key);

  @override
  State<StatefulWidget> createState() => _ScanQrCodeDialogState();
}

class _ScanQrCodeDialogState extends State<ScanQrCodeDialog> {

  final GlobalKey qrKey = GlobalKey();
  QRViewController? controller;

  bool isDisposed = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  void _onData(Barcode barcode) {

    if (isDisposed)
      return;

    String? code = barcode.code;

    if (code == null)
      return;

    try {

      final data = json.decode(code);

      if (QrCodeData.isValidData(data)) {

        final d = QrCodeData.fromJson(data);

        if (widget.userType == 'point service' && d.codeGuichet == null)
          return;

        isDisposed = true;
        Navigator.of(context).pop(d);
      }

    } catch (e) {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {

    var scanArea = (MediaQuery.of(context).size.width < 400 ||
      MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: const Color(0xff003e85),
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen(_onData);
  }

  void _onPermissionSet(BuildContext context, QRViewController _, bool p) {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pas de permissions')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
