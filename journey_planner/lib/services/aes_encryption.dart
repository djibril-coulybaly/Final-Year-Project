/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: aes_encryption.dart
  Description: This file allows for the encryption of a string of data using a custom key and AES Encryption. 
               We want to encrypt the pesronal information pertaining to the user and their travel card/ticket.
               Without the key, no one would be capable in decoding the encrypted string.

               I learned how to create this by using the following YouTube tutorial as reference: 
               https://www.youtube.com/watch?v=CpqbPuoQ36g
*/

// Imports utilised in this file
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
