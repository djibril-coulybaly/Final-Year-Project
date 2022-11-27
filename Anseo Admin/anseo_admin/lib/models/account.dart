/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: account.dart
  Description: This is the account model that we use to collect specific information about the admin logged 
               into the application - in particular the ID and email of the admin.
*/

class AccountModel {
  AccountModel({
    required this.uid,
    required this.email,
  });

  final String uid;
  final String? email;
}
