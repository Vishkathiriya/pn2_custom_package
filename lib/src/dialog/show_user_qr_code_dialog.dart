
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pn2_package/src/models/qr_code_data.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

Future<void> showUserQrCodeDialog({
  required BuildContext context,
  required QrCodeData data
}) {
  return showDialog(
    context: context,
    builder: (_) => UserQrCodeDialog(data: data)
  );
}

class UserQrCodeDialog extends StatefulWidget {

  final QrCodeData data;
  const UserQrCodeDialog({ Key? key, required this.data }) : super(key: key);

  @override
  _UserQrCodeDialogState createState() => _UserQrCodeDialogState();
}

class _UserQrCodeDialogState extends State<UserQrCodeDialog> {

  late final String data;

  @override
  void initState() {
    super.initState();

    data = json.encode(widget.data.toMap());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [

        Center(
          child: Container(
            width: 260.0,
            height: 260.0,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              // color: MyTheme.SECONDARY_COLOR,
              borderRadius: BorderRadius.circular(8.0)
            ),
            child: PrettyQr(
              image: const AssetImage('assets/images/logo.png'),
              // typeNumber: 4,
              size: 200.0,
              data: data,
              errorCorrectLevel: QrErrorCorrectLevel.M,
              // roundEdges: true,
              // elementColor: MyTheme.PRIMARY_COLOR,
            ),
          ),
        ),

        Align(
          alignment: const Alignment(0.0, 0.7),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 80.0,
              height: 80.0,
              decoration: const ShapeDecoration(
                shape: StadiumBorder(),
                color: Colors.white54
              ),
              child: const Icon(Icons.close_rounded, size: 36.0,)
            ),
          ),
        )

      ],
    );
  }
}
