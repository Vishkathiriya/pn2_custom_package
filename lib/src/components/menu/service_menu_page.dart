import 'package:flutter/material.dart';
import 'package:pn2_package/pn2_package.dart';
import 'package:pn2_package/src/constants/pn2_theme.dart';

const String CONSULTATION_FORM = 'consultation_form';
const String EVALUATION_FORM = 'evaluation_form';
const String PAYMENT_FORM = 'payment_form';

class ServiceMenuPage extends StatelessWidget {

  final MenuType type;
  final SubCategoryModel subCategory;

  const ServiceMenuPage({
    Key? key,
    required this.type,
    required this.subCategory
  }): super(key: key);

  void _onTap(BuildContext context, ServiceModel service) {

    String? route;

    switch(type) {
      case MenuType.consultation:
        route = CONSULTATION_FORM;
        break;
      case MenuType.evaluation:
        route = EVALUATION_FORM;
        break;
      case MenuType.payment:
        route = PAYMENT_FORM;
        break;
    }

    Navigator.of(context).pushNamed(route, arguments: service);
  }

  @override
  Widget build(BuildContext context) {

    final services = subCategory.services;
    final length = services.length;
    final isFrench = Localizations.localeOf(context).languageCode == 'fr';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pn2Theme.PRIMARY_COLOR,
        title: Text(isFrench ? subCategory.labels.first : subCategory.labels.last),
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
              final service = services[realIndex];
              return MenuItemWidget.service(
                service: service,
                isFrench: isFrench,
                onTap: () => _onTap(context, service)
              );
            },
          ),
        ),
      ),
    );
  }
}
