import 'package:flutter/material.dart';
import 'package:pn2_package/pn2_package.dart';
import 'package:pn2_package/src/constants/pn2_theme.dart';

const String SERVICE = 'service';

class SubCategoryMenuPage extends StatelessWidget {

  final MenuType type;
  final CategoryServiceModel category;

  const SubCategoryMenuPage({
    Key? key,
    required this.type,
    required this.category
  }): super(key: key);

  void _onTap(BuildContext context, SubCategoryModel subCategory) {
    Navigator.of(context).pushNamed(SERVICE, arguments: TwoValueArgs<MenuType, SubCategoryModel>(
      first: type,
      second: subCategory
    ));
  }

  @override
  Widget build(BuildContext context) {

    final subCategories = category.subCategories;
    final length = subCategories.length;
    final isFrench = Localizations.localeOf(context).languageCode == 'fr';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pn2Theme.PRIMARY_COLOR,
        title: Text(isFrench ? category.labels.first : category.labels.last),
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
              final subCategory = subCategories[realIndex];
              return MenuItemWidget.subCategory(
                subCategory: subCategory,
                isFrench: isFrench,
                onTap: () => _onTap(context, subCategory)
              );
            },
          ),
        ),
      ),
    );
  }
}
