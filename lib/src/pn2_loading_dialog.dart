import 'package:flutter/material.dart';

class Pn2LoadingDialogController<T> {
  void Function([T?])? close;
}

Future<T?> showLoadingDialog<T>(BuildContext context, {
  required Pn2LoadingDialogController<T?> controller
}) {
  return showDialog(
    context: context,
    builder: (_) => LoadingDialog(controller: controller)
  );
}

class LoadingDialog<T> extends StatefulWidget {

  final Pn2LoadingDialogController<T> controller;
  const LoadingDialog({ Key? key, required this.controller }) : super(key: key);

  @override
  _LoadingDialogState createState() => _LoadingDialogState();
}

class _LoadingDialogState<T> extends State<LoadingDialog<T>> {

  @override
  void initState() {
    super.initState();
    widget.controller.close = _close;
  }

  void _close([T? value]) {
    if (mounted)
      Navigator.of(context).pop(value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.black26,
      child: const Center(
        child: SizedBox(
          width: 70.0,
          height: 70.0,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Color(0xff98c73a)),
            strokeWidth: 6.0,
          ),
        ),
      ),
    );
  }
}
