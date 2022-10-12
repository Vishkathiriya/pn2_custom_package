
import 'service_model.dart';

class SubCategoryModel {

  final int id;
  final int categoryId;
  final List<String> labels;
  final String iconName;
  final List<ServiceModel> services;

  SubCategoryModel({
    required this.id,
    required this.categoryId,
    required this.labels,
    required this.iconName,
    required this.services
  });

  static SubCategoryModel? fromJson(Map<String, dynamic> data) {

    final services = data['services'];

    final int len = services.length;

    if (len == 0)
      return null;

    return SubCategoryModel(
      id: data['id'],
      categoryId: data['categoryId'],
      labels: data['labels'].cast<String>(),
      iconName: data['iconName'],
      services: List.generate(len, (index) => ServiceModel.fromJson(services[index]))
    );
  }

}
