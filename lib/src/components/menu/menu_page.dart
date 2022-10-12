import 'package:flutter/material.dart';
import 'package:pn2_package/pn2_package.dart';
import 'package:pn2_package/src/constants/pn2_theme.dart';
import 'package:pn2_package/src/models/menu_node.dart';

const String VERIFY_PIN_CODE = 'verify_pin_code';
const String MENU = 'menu';

class MenuPage extends StatelessWidget {

  final MenuNode data;
  const MenuPage({ Key? key, required this.data }): super(key: key);

  void _onTap(BuildContext context, MenuNode node) {
    if (node.isLeaf) {
      final routes = node.routeName!.split(";");
      final newRoute = routes.first;
      final isSingleRoute = routes.length == 1;
      Navigator.of(context).pushNamed(
        newRoute,
        arguments: isSingleRoute
          ? null
          : routes.first == VERIFY_PIN_CODE
              ? _removeFirstElement(routes)
              : routes.last
      );
    } else {
      Navigator.of(context).pushNamed(MENU, arguments: node);
    }
  }

  List<String> _removeFirstElement(List<String> l) {
    final newList = List<String>.from(l);
    newList.removeAt(0);
    return newList;
  }

  @override
  Widget build(BuildContext context) {

    final children = data.children!;
    final length = children.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pn2Theme.PRIMARY_COLOR,
        title: Text(data.label!),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView.separated( // ajouter un sapce supplemetaire
            itemCount: length + 2, // On Fait +2 pour pour ajouter deux elements a la liste (espace vide au debut et a la fin)
            separatorBuilder: (_, __) => const SizedBox(height: 10.0),
            itemBuilder: (_, index) {

              if (index == 0 || index - 1 == length)
                return const SizedBox(height: 25.0);

              /// On faire `-1` a l'indice pour compenser le faite qu'on ait ajoute un element au debut de la liste
              final realIndex = index - 1;
              final node = children[realIndex];
              return MenuItemWidget.node(
                node: node,
                onTap: () => _onTap(context, node)
              );
            },
          ),
        ),
      ),
    );
  }
}
