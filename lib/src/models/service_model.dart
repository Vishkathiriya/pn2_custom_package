
import 'service_field.dart';

class ServiceModel {

  final int id;
  final int subCategoryId;
  final List<String> labels;
  final int amount;
  final String? calculationMethod;
  final String iconName;
  final List<ServiceField> fields;

  ServiceModel({
    required this.id,
    required this.subCategoryId,
    required this.labels,
    required this.amount,
    required this.calculationMethod,
    required this.iconName,
    required this.fields
  });

  factory ServiceModel.fromJson(Map<String, dynamic> data) {

    final fields = data['fields'];

    return ServiceModel(
      id: data['id'],
      subCategoryId: data['subCategoryId'],
      labels: data['labels'].cast<String>(),
      amount: data['amount'],
      calculationMethod: data['calculationMethod'],
      iconName: data['iconName'],
      fields: List.generate(fields.length, (index) => ServiceField.fromJson(fields[index]))
    );
  }

}
