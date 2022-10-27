/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Validator
  File Name: extensions.dart
  Description: This file converts the ID of the scanned NFC card to a hexidecimal number format

               This was taken from the 'nfc_manager' package available from https://github.com/okadan/nfc-manager
*/
// Imports utilised in this file
import 'dart:typed_data';

extension IntExtension on int {
  String toHexString() {
    return toRadixString(16).padLeft(2, '0').toUpperCase();
  }
}

extension Uint8ListExtension on Uint8List {
  String toHexString({String empty = '-', String separator = ''}) {
    return isEmpty ? empty : map((e) => e.toHexString()).join(separator);
  }
}
