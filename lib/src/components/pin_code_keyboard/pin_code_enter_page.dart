import 'dart:math' show Random;

import 'package:flutter/material.dart';
import 'package:pn2_package/pn2_package.dart';
import 'package:pn2_package/src/constants/pin_code_length.dart';

class PinCodeEnterPageController {
  void Function()? clear;
}


class PinCodeEnterPage extends StatefulWidget {

  // FIXME Ajouter une fonction onChanged

  final String title;
  final String description;
  final ValueChanged<String> onCompleted;
  final PinCodeEnterPageController? controller;
  final String buttonLabel;

  const PinCodeEnterPage({
    Key? key,
    required this.title,
    required this.description,
    required this.onCompleted,
    this.controller,
    required this.buttonLabel,
  }) : super(key: key);

  @override
  _PinCodeEnterPageState createState() => _PinCodeEnterPageState();
}

class _PinCodeEnterPageState extends State<PinCodeEnterPage> {

  static const int GRID_SIZE = 5;
  late final List<List<String>> _grid;
  String value = "";

  @override
  void initState() {
    super.initState();
    
    if (widget.controller != null)
      widget.controller!.clear = clear;

    _grid = _getRandomNumbers();
  }

  void _onChanged([String? number]) {

    if (number == null && value.isNotEmpty) {
      value = value.substring(0, value.length - 1);
    } else if (number != null) {
      value =  value + number;
    } else {
      // Il y a eu aucun changement on evite d'appeler la fonction 'widget.onChanged(String)'
      return;
    }

    setState(() {});
  }

  void _onNext() {
    widget.onCompleted(value);
  }

  void clear() {
    value = '';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {

    final int currentPinCodeLength = value.length;
    bool isCompleted = currentPinCodeLength == PIN_CODE_LENGTH;

    return Column(
      children: [

        const SizedBox(height: 30.0,),

        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600
          ),
        ),

        const SizedBox(height: 15.0,),

        Text(
          widget.description
        ),

        const SizedBox(height: 40.0,),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(PIN_CODE_LENGTH, (index) => Container(
            width: 15.0,
            height: 15.0,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: BoxDecoration(
              color: currentPinCodeLength > index ? const Color(0xff003e85) : null,
              border: Border.all(width: 1.0, color: const Color(0xff003e85)),
              borderRadius: BorderRadius.circular(10.0)
            ),
          )),
        ),

        const SizedBox(height: 40.0,),

        Expanded(
          child: PinCodeKeyboard(
            onChanged: _onChanged,
            grid: _grid,
            disabled: isCompleted,
          )
        ),

        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 30.0),
          child: Pn2Button(
            color: const Color(0xff003e85),
            onPressed: isCompleted ? _onNext : null,
            child: Text(widget.buttonLabel)
          ),
        )

      ],
    );
  }

  static List<List<String>> _getRandomNumbers() {

    Random random = Random();

    List<int> positions = List.generate(GRID_SIZE * GRID_SIZE, (index) => index);

    List<List<String>> grid = List.generate(
      GRID_SIZE, 
      (index) => List.generate(
        GRID_SIZE,
        (index2) => '',
        growable: false
      ),
      growable: false
    );

    for (int i=0; i<10; ++i) {
      int j = random.nextInt(positions.length);
      int selectedNumber = positions.removeAt(j);
      grid[selectedNumber ~/ GRID_SIZE][selectedNumber % GRID_SIZE] = i.toString();
    }

    return grid;
  }

}