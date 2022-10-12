
import 'sub_category_model.dart';

class CategoryServiceModel {

  final int id;
  final String regieId;
  final List<String> labels;
  final String iconName;
  final List<SubCategoryModel> subCategories;

  CategoryServiceModel({
    required this.id,
    required this.regieId,
    required this.labels,
    required this.iconName,
    required this.subCategories
  });

  static CategoryServiceModel? fromJson(Map<String, dynamic> data) {

    final rawSubCategories = data['subCategories'];

    final int len = rawSubCategories.length;

    if (len == 0)
      return null;

    List<SubCategoryModel> subCategories = [];

    for (int i=0; i<len; ++i) {
      final value = SubCategoryModel.fromJson(rawSubCategories[i]);
      if (value != null)
        subCategories.add(value);
    }

    return CategoryServiceModel(
      id: data['id'],
      regieId: data['regieId'],
      labels: data['labels'].cast<String>(),
      iconName: data['iconName'],
      subCategories: subCategories
    );
  }

  @override
  String toString() {
    return "CategoryServiceModel(labels: $labels, iconName: $iconName, subCategorie[$subCategories])";
  }

}
