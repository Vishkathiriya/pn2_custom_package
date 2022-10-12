import 'package:encrypt/encrypt.dart';

/// Inutile
class AESUtils {

  static String encrypt(String body, {
    required String key,
    required String iv
  }) {
    final encryter = Encrypter(AES(Key.fromBase64(key), mode: AESMode.cbc));
    return body = encryter.encrypt(body, iv: IV.fromBase64(iv)).base64;
  }

}
