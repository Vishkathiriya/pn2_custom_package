import 'package:pn2_package/pn2_package.dart';

class ServiceFormBloc {

  /// String, Object(String, List<String>)
  final Map<String, dynamic> _data = {};

  ServiceFormBloc(ServiceModel service) {
    for (final field in service.fields) {

      if (field.type == 'textfield') {
        _data[field.key] = '';
      }

      // checkbox valeur par default un tableau
    }
  }

  Map<String, dynamic> get data => _data;

  void set(String key, dynamic value) {
    _data[key] = value;
  }

  bool isValid() {

    // for (final value in _data.values) {

    //   if (value is! String && value is! List) {
    //     return false;
    //   }

    //   if (value is String && value.trim() == '')
    //     return false;

    //   if (value is List && value.isEmpty)
    //     return false;

    // }

    // return true;

    throw UnimplementedError();
  }

}
