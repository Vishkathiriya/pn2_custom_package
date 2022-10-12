import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Pn2TextField extends StatelessWidget {

  final TextEditingController? controller;
  final String? initialValue;
  final String? title;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final TextInputType? keyboardType;
  final String? errorText;
  final List<TextInputFormatter> inputFormatters;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? sufixIcon;
  final BorderRadius borderRadius;

  const Pn2TextField({
    Key? key,
    this.controller,
    this.initialValue,
    this.title,
    this.hintText,
    this.labelText,
    this.errorText,
    this.helperText,
    this.inputFormatters = const [],
    this.onChanged,
    this.obscureText = false,
    this.prefixIcon,
    this.sufixIcon, 
    this.keyboardType,
    this.borderRadius = const BorderRadius.all(Radius.circular(30.0))
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

      if (title != null)
        Text(
          title!,
          style: const TextStyle(
            color: Color(0xFF02132D),
            fontSize: 17.0,
            fontWeight: FontWeight.w600),
        ),
      
      if (title != null)
        const SizedBox(height: 5.0),

      TextFormField(
        initialValue: initialValue,
        onChanged: onChanged,
        controller: controller,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        obscureText: obscureText,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          labelText: labelText,
          hintText: hintText,
          errorText: errorText,
          helperText: helperText,
          floatingLabelStyle: const TextStyle(
            color: Color(0xff182983)
          ),
          hintStyle: const TextStyle(color: Color(0xFF85ADA4)),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF85ADA4)),
            borderRadius: borderRadius
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF85ADA4)),
            borderRadius: borderRadius
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF85ADA4)),
            borderRadius: borderRadius
          ),
          suffixIcon: sufixIcon,
        ),
      ),
    ]);
  }
}
