import 'package:flutter/material.dart';
import 'package:pn2_package/src/components/pin_code_keyboard/pin_code_enter_page.dart';

Future<String?> showPinCodeEnterDialog({
  required BuildContext context,
  String title = "Saisissez votre code PIN",
  String description = "",
  String buttonLabel = 'Valider',
  String pageTitle = 'Vérification de code PIN'
}) {
  return showDialog(
    context: context,
    builder: (_) => VerifyPinCodeDialog(
      pageTitle: pageTitle,
      title: title,
      description: description,
      buttonLabel: buttonLabel,
    )
  );
}

class VerifyPinCodeDialog extends StatelessWidget {

  final String pageTitle;
  final String title;
  final String description;
  final String buttonLabel;

  const VerifyPinCodeDialog({
    Key? key,
    required this.pageTitle,
    required this.title,
    required this.description,
    required this.buttonLabel
  }): super(key: key);

  void _onSubmit(BuildContext context, String code) {
    Navigator.of(context).pop(code);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff003e85),
        title: Text(pageTitle),
      ),
      body: PinCodeEnterPage(
        title: title,
        description: description,
        buttonLabel: buttonLabel,
        onCompleted: (code) => _onSubmit(context, code),
      ),
    );
  }
}
