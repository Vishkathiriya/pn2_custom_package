
class QrCodeData {

  String accountType;
  String? phoneNumber;
  String? codeGuichet;
  int? amount;

  QrCodeData({
    required this.accountType,
    this.phoneNumber,
    this.codeGuichet,
    this.amount
  });

  factory QrCodeData.fromJson(Map<String, dynamic> data) {
    return QrCodeData(
      accountType: data['accountType'],
      phoneNumber: data['phoneNumber'],
      codeGuichet: data['codeGuichet'],
      amount: data['amount']
    );
  }

  Map<String, dynamic> toMap() {

    Map<String, dynamic> map = {};

    map['accountType'] = accountType;

    if (phoneNumber != null) {
      map['phoneNumber'] = phoneNumber;
    }

    if (codeGuichet != null) {
      map['codeGuichet'] = codeGuichet;
    }

    if (amount != null) {
      map['amount'] = amount;
    }

    return map;
  }

  bool isValid() {
    return (phoneNumber != null || codeGuichet != null);
  }

  static bool isValidData(Map<String, dynamic> data) {
    String type = data['accountType'];
    if (type != 'utilisateur' && type != 'point service')
      return false;
    return data['phoneNumber'] != null || data['codeGuichet'] != null;
  }

  @override
  String toString() {
    return 'QrCodeData(accountType: $accountType, codeGuichet: $codeGuichet, phoneNumber: $phoneNumber, amount: $amount)';
  }

}
