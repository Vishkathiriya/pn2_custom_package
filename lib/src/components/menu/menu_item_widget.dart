import 'package:flutter/material.dart';
import 'package:pn2_package/src/constants/pn2_theme.dart';
import 'package:pn2_package/src/models/category_service_model.dart';
import 'package:pn2_package/src/models/menu_node.dart';
import 'package:pn2_package/src/models/service_model.dart';
import 'package:pn2_package/src/models/sub_category_model.dart';
import 'package:pn2_package/src/utils/icons_map.dart';

Widget? _getRightIconFromNode(MenuNode node) {

  if (node.icon != null)
    return Icon(node.icon, size: 27.0, color: Pn2Theme.MENU_ICON_COLOR);

  if (node.assetPath != null)
    return Image.asset(node.assetPath!);

  return null;
}

Widget _getIcon(String iconName) {
  final iconData = IconsMap.get(iconName);
  return Icon(iconData ?? Icons.rocket, size: 27.0, color: Pn2Theme.MENU_ICON_COLOR);
}

class MenuItemWidget extends StatelessWidget {

  final String label;
  final Widget? icon;
  final VoidCallback? onTap;
  final Color? labelColor;

  const MenuItemWidget({
    Key? key,
    required this.label,
    this.icon,
    this.onTap,
    this.labelColor = const Color(0xff181725)
  }): super(key: key);

  factory MenuItemWidget.node({
    Key? key,
    required MenuNode node,
    VoidCallback? onTap
  }) {
    return MenuItemWidget(
      key: key,
      label: node.label!,
      icon: _getRightIconFromNode(node),
      onTap: onTap,
    );
  }

  factory MenuItemWidget.category({
    Key? key,
    required CategoryServiceModel category,
    required bool isFrench,
    VoidCallback? onTap
  }) {
    return MenuItemWidget(
      key: key,
      label: isFrench ? category.labels.first : category.labels.last,
      icon: _getIcon(category.iconName),
      onTap: onTap,
    );
  }

  factory MenuItemWidget.subCategory({
    Key? key,
    required SubCategoryModel subCategory,
    required bool isFrench,
    VoidCallback? onTap
  }) {
    return MenuItemWidget(
      key: key,
      label: isFrench ? subCategory.labels.first : subCategory.labels.last,
      icon: _getIcon(subCategory.iconName),
      onTap: onTap,
    );
  }

  factory MenuItemWidget.service({
    Key? key,
    required ServiceModel service,
    required bool isFrench,
    VoidCallback? onTap
  }) {
    return MenuItemWidget(
      key: key,
      label: isFrench ? service.labels.first : service.labels.last,
      icon: _getIcon(service.iconName),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const StadiumBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const StadiumBorder(),
        child: Container(
          height: 52.0,
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          decoration: BoxDecoration(
            // color: Colors.white,
            // shape: const StadiumBorder(),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(5),
                offset: const Offset(0.0, 20.0),
                blurRadius: 90
              )
            ]
          ),
          child: Row(
            children: [

              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: icon,
                ),

              Text(
                label,
                style: TextStyle(
                  color: labelColor,
                  fontWeight: FontWeight.w600
                ),
              ),

              const Expanded(child: SizedBox()),

              // Image.asset('assets/images/left_arrow.png')
              const Icon(Icons.arrow_forward_ios_rounded, color: Pn2Theme.PRIMARY_COLOR)

            ],
          ),
        ),
      ),
    );
  }
}
