import 'package:flutter/material.dart';
import 'package:pn2_package/pn2_package.dart';

Future<String?> showEnterCodePinAndConfirmItDialog(BuildContext context) {
  return showDialog<String>(
    context: context,
    builder: (_) => const EnterCodePinAndConfirmItComponent()
  );
}

class EnterCodePinAndConfirmItComponent extends StatefulWidget {
  const EnterCodePinAndConfirmItComponent({ Key? key }) : super(key: key);

  @override
  State<EnterCodePinAndConfirmItComponent> createState() => _EnterCodePinAndConfirmItComponentState();
}

class _EnterCodePinAndConfirmItComponentState extends State<EnterCodePinAndConfirmItComponent> {

  String _password = '';

  final PageController _pageController = PageController();

  // Lorsqu'on rentre le premiers mot de passe
  void _onEnterNewPassword(String code) {
    setState(() {
      _password = code;
    });

    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut
    );
  }

  void _onEnterConfirmPassword(String code) {

    if (code != _password) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Les deux codes PIN ne correspondent pas')
      ));
    } else {
      Navigator.of(context).pop(code);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff003e85),
        title: const Text("Nouveau mot de passe"),
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [

          PinCodeEnterPage(
            title: 'Entrer votre nouveau mot de passe',
            description: '',
            onCompleted: _onEnterNewPassword,
            buttonLabel: 'Continuer'
          ),

          PinCodeEnterPage(
            title: 'Confirmer votre mot de passe',
            description: '',
            onCompleted: _onEnterConfirmPassword,
            buttonLabel: 'Confirmer'
          ),

        ],
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

}