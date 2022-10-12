import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pn2_package/pn2_package.dart';

void main() {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: PinCodeEnterPage(
          title: 'Enter your PIN',
          description: '',
          buttonLabel: 'To Login',
          onCompleted: (code) {
            // if (type == 'login') {
            //   BlocProvider.of<PasswordBloc>(contextss)
            //       .add(PasswordRequested(phone, code));
            // } else {
            //   BlocProvider.of<PasswordBloc>(contextss)
            //       .add(RegisterOtpRequested(phone, code));
            // }
          }),
    ));
  }
}
