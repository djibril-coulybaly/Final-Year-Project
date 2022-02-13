import 'package:encrypt/encrypt.dart' as encrypt;

class AESEncryption {
  // Random key that I generated
  static final key = encrypt.Key.fromUtf8("7878c27e747ecb6519b60534019977d4");
  static final iv = encrypt.IV.fromLength(16);
  static final encrypter = encrypt.Encrypter(encrypt.AES(key));

  encryptDocID(String text) => encrypter.encrypt(text, iv: iv);
  decryptDocID(encrypt.Encrypted text) => encrypter.decrypt(text, iv: iv);
  getCode(String encoded) => encrypt.Encrypted.fromBase16(encoded);
}
