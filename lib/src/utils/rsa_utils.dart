import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

class RSAUtils {

  static String encrypt(String input, RSAPublicKey key) {
    final encrypter = Encrypter(RSA(publicKey: key));
    return encrypter.encrypt(input).base64;
  }

}
