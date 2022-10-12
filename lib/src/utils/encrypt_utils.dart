import 'package:encrypt/encrypt.dart';
import 'package:pn2_package/src/utils/rsa_utils.dart';
import 'package:pointycastle/asymmetric/api.dart';

class EncrytData {

  final String? data;
  final String headerKey;

  /// Use for decrypt
  final Key key;

  // use for decrypt
  final IV iv;

  EncrytData({
    required this.data,
    required this.headerKey,
    required this.key,
    required this.iv
  });

}

class EncryptUtils {

  static String keyStr = '''-----BEGIN PUBLIC KEY-----
MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAytO5mmrl4Wibwn4oHgV+qyYRLXBOvCucmv7Xl5cc9L4XmqoA2MHd/Mr24HiCpEOuMid0ECIdCtXzs6A/wQUij8amffQT5MhgPhd7f3Vmdjka2D/OvkAuXUB3xsCTsjvLTVIrlJSt36mWayiAUdK5IaF2tkXj8spMBHXNrnVKP3XWoe3AiiyK6T+Rw4qZrec620oIHOBLtM7TCO2GqaiMhYYXOU36j6lh2PhEZwt8u1Qb8vDoXc3FO5D/fu0wU3wO6et6svSWpo3kCFcQwFfCqZf6C+uSC0PWzQT6WSJlrQHBr+7Ezdw0KdkwGJ23cmx4yFkSlZB7Z6NM/G0h7Ppr+QIDAQAB
-----END PUBLIC KEY-----''';

  static final parse = RSAKeyParser();
  static final rsaKey = parse.parse(keyStr) as RSAPublicKey;

  ///
  ///return <String>[AES encrypt data, AES key and iv encrypt with RSA]
  static EncrytData encrypt(String? input) {

    final key = Key.fromSecureRandom(32);
    final iv = IV.fromSecureRandom(16);
 
    final encryter = Encrypter(AES(key, mode: AESMode.cbc));

    String? encrypted;

    if (input != null)
      encrypted = encryter.encrypt(input, iv: iv).base64;

    final String signKey = '${key.base64}:${iv.base64}';

    return EncrytData(
      data: encrypted,
      headerKey: RSAUtils.encrypt(signKey, rsaKey),
      key: key,
      iv: iv
    );
  }

  static String decrypt(String input, Key key, IV iv) {
    final encryter = Encrypter(AES(key, mode: AESMode.cbc));
    return encryter.decrypt64(input, iv: iv);
  }

}

// void main(List<String> args) async {

//   // List<String> result =  EncryptUtils.encrypt('{"message":"hello world ! hééé Nouveau"}', key);
//   // String body = '{"libelleMoyen":"hello world ! hééé Nouveau"}';
//   // String body = '{"refTransaction":"FA2022.08.08.10011", "numTelClient": "01020304", "idMoyen": 1, "idLiq": 1, "idServ": 2, "idSession": 1, "typeTransaction": "TOPUP", "dateTransaction": "2022-02-18", "montantTransaction": 2920, "etatTransaction": "SUCCESS"}';
//   String body = '{"ifu": "00000050U", "rumap": "211634120"}';
//   List<String> result =  EncryptUtils.encrypt(body, EncryptUtils.key);

//   print(result[0]);
//   print('\n\n');
//   print(result[1]);

//   print(await Pn2Request.post(Uri.parse('http://127.0.0.1:3000/api/v1/global-service-api/data/1'), body: '{"ifu": "00000050U", "rumap": "211634120"}'));

// }
