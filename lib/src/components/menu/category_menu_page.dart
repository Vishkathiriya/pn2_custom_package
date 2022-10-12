import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pn2_package/pn2_package.dart';
import 'package:pn2_package/src/constants/pn2_theme.dart';

const String SUB_CATEGORY_MENU = 'sub_category_menu';

class CategoryMenuPage extends StatelessWidget {

  final MenuType type;
  final List<String> labels;
  final List<CategoryServiceModel> categories;

  const CategoryMenuPage({
    Key? key,
    required this.labels,
    required this.type,
    required this.categories
  }): super(key: key);

  void _onTap(BuildContext context, CategoryServiceModel category) {
    log(category.labels.toString(), name: 'category');
    Navigator.of(context).pushNamed(SUB_CATEGORY_MENU, arguments: TwoValueArgs<MenuType, CategoryServiceModel>(
      first: type,
      second: category
    ));
  }

  @override
  Widget build(BuildContext context) {

    final length = categories.length;
    final isFrench = Localizations.localeOf(context).languageCode == 'fr';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pn2Theme.PRIMARY_COLOR,
        title: Text(isFrench ? labels.first : labels.last),
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
              final category = categories[realIndex];
              return MenuItemWidget.category(
                category: category,
                isFrench: isFrench,
                onTap: () => _onTap(context, category)
              );
            },
          ),
        ),
      ),
    );
  }
}
