import 'package:flutter/material.dart';

class Pn2DropdownButton extends StatelessWidget {

  final List<String> items;
  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final String? title;
  final ValueChanged<String?>? onChanged;

  const Pn2DropdownButton({
    Key? key,
    required this.items,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.title,
    this.onChanged,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null)
          Text(
            title!,
            style: const TextStyle(
              color: Color(0xFF02132D),
              fontSize: 17.0,
              fontWeight: FontWeight.w500
            ),
          ),
        
        if (title != null)
          const SizedBox(height: 5.0),

        DropdownButtonFormField<String>(
          value: initialValue,
          elevation: 16,
          isExpanded: true,
          style: const TextStyle(color: Colors.deepPurple),
          onChanged: onChanged,
          decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            hintStyle: const TextStyle(color: Color(0xFF85ADA4)),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))
            ),
          ),
          items: List.generate(items.length, (index) {
            String value = items[index];
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: const TextStyle(color: Colors.black, fontSize: 17.0),
              ),
            );
          })
        ),
      ],
    );
  }
}
