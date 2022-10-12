
class ServiceField {

  final String key;
  final String type;
  final List<String> labels;

  ServiceField({
    required this.key,
    required this.type,
    required this.labels
  });

  factory ServiceField.fromJson(Map<String, dynamic> data) {
    return ServiceField(
      key: data['key'],
      type: data['type'],
      labels: data['labels'].cast<String>()
    );
  }

}
