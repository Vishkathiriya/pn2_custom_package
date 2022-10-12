import 'package:flutter/material.dart';

class Pn2ListTile extends StatelessWidget {

  final String title;
  final String subtitle;
  final Color? subtitleColor;
  final EdgeInsetsGeometry margin;

  const Pn2ListTile({
    Key? key,
    required this.title,
    required this.subtitle,
    this.subtitleColor,
    this.margin = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0)
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          // FIXME EVITER LES OVERFLOW
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.black54
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    subtitle,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: subtitleColor
                    ),
                  ),
                ),
              )

            ],
          )

        ],
      ),
    );
  }
}
