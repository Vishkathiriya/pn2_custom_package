import 'package:flutter/material.dart';

class Pn2Button extends ElevatedButton {

  Pn2Button({
    Key? key,
    required VoidCallback? onPressed,
    required Widget child,
    Color? color = const Color(0xff003e85),
    double elevation = 0
  }): super(
        key: key,
        onPressed: onPressed,
        child: child,
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(double.infinity, 56.0)),
          shape: MaterialStateProperty.all(const StadiumBorder()),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            return states.contains(MaterialState.disabled) ? Colors.black12 : color;
          }),
          elevation: MaterialStateProperty.all(elevation)
        )
    );

}
