/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: admin.dart
  Description: This is the account model that we use to structure specific information about the admin account. 
               It has the same structure that is implented in the firebase database. Each admin account will
               hold the follwing:
               - ID
               - Email 
               - First Name
               - Last Name
*/
class Admin {
  Admin({
    required this.adminID,
    required this.emailAddress,
    required this.firstName,
    required this.lastName,
  });

  final String adminID;
  final String emailAddress;
  final String firstName;
  final String lastName;
}
