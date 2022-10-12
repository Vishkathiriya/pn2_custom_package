import 'package:flutter/material.dart';

/// Un widget generique permettant de simuler un clavier
/// [onChanged]
class PinCodeKeyboard extends StatelessWidget {

  final List<List<String>> grid;

  final ValueChanged<String?>? onChanged;
  final bool disabled;

  const PinCodeKeyboard({
    Key? key,
    required this.grid,
    required this.onChanged,
    this.disabled = false,
  }): super(key: key);

  void _onChanged([String? number]) {
    if (!disabled)
      onChanged?.call(number);
    else if (disabled && number == null)
      onChanged?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xff003e85),
        border: Border.all(
          color: Colors.black
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8.0))
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {

          final double cellSize = (constraints.maxWidth / grid.length) - (grid.length + 1);

          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

              //  _buildRow(['1', '2', '3']),
              //  _buildRow(['4', '5', '6']),
              //  _buildRow(['7', '8', '9']),

              ...List.generate(
                grid.length,
                (index) => _buildRow(grid[index], cellSize, index == 0)
              ),

              // Divider()
              _buildRow(['', '', '', '' /*'0'*/, null], cellSize, false)

            ]
          );
        }
      ),
    );
  }

  Widget _buildRow(List<String?> elements, double size, bool isFirstRow) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(elements.length, (index) {

        final e = elements[index];
        // Le premier caractere de la derniere ligne est vide donc pas besoin de lui affecter une fonction
        // on evite ainsi l'effet 'splash' sur une case vide
        return Expanded(
          child: Container(
            height: size, //76.0,
            decoration: BoxDecoration(
              border: Border(
                left: index == 0
                  ? const BorderSide(color: Colors.transparent)
                  : const BorderSide(color: Colors.white24),
                top: isFirstRow
                  ? const BorderSide(color: Colors.transparent)
                  : const BorderSide(color: Colors.white24)
              )
            ),
            child: IconButton(
              onPressed: e == ''
                ? null
                : () => _onChanged(e),
              icon: e == null
              ? const Icon(Icons.backspace, color: Colors.white70)
              : Text(
                  e,
                  style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w700,
                    color: disabled ? Colors.white24 : Colors.white
                  ),
              )
            ),
          ),
        );
      },),
    );
  }

}
