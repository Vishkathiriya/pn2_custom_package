import 'package:flutter/material.dart';
import 'package:pn2_package/pn2_package.dart';

class ServiceTextField extends Pn2TextField {

  ServiceTextField({
    Key? key,
    required ServiceField fieldData,
    String? errorText,
    required bool isFrench,
    required void Function(String, dynamic) onChanged
  }): super(
    key: key,
    labelText: isFrench ? fieldData.labels.first : fieldData.labels.last,
    onChanged: (value) => onChanged(fieldData.key, value),
    errorText: errorText
  );

}
