
import 'package:flutter/widgets.dart';
import 'package:pn2_package/src/utils/icons_map.dart';

class MenuNode {

  /// Tous les nœuds ont un nom sauf la racine
  final String? label;

  final IconData? icon;

  final String? assetPath;

  /// Seules les feuilles amenent a des actions
  final String? routeName;

  /// Les feuilles ont pas d'enfants
  final List<MenuNode>? children;

  MenuNode({
    this.label,
    this.icon,
    this.assetPath,
    this.routeName,
    this.children
  });

  bool get isLeaf => routeName != null;

  factory MenuNode.fromJson(List<dynamic> data) {
    return MenuNode(
      children: List.generate(data.length, (index) => parse(data[index]))
    );
  }

  static MenuNode parse(Map<String, dynamic> data) {

    dynamic children = data['children'];

    return MenuNode(
      label: data['label'],
      icon: IconsMap.get(data['icon']),
      assetPath: data['assetPath'],
      routeName: data['routeName'],
      children: children is List
        ? List.generate(children.length, (index) => parse(children[index]))
        : null
    );
  }

  MenuNode? find(String routeName) {
    return _findHelper(this, routeName);
  }

  MenuNode? _findHelper(MenuNode node, String routeName) {

    if (node.routeName != null) {
      if (node.routeName == routeName)
        return node;
      return null;
    }

    if (node.children == null)
      return null;

    for (int i=0, len=node.children!.length; i<len; ++i) {
      MenuNode? result = _findHelper(node.children![i], routeName);
      if (result != null)
        return result;
    }

    return null;
  }

  @override
  String toString() {
    return 'label: $label, icon: $icon, assetPath: $assetPath, routeName: $routeName, children: $children';
  }

}
