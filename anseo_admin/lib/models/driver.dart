/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: driver.dart
  Description: This is the driver model that we use to structure specific information about the driver account. 
               It has the same structure that is implented in the firebase database. Each driver account will
               hold the follwing:
               - ID
               - Email 
               - First Name
               - Last Name
               - Operator Name
*/
class Driver {
  Driver({
    required this.driverID,
    required this.emailAddress,
    required this.firstName,
    required this.lastName,
    required this.operatorName,
  });

  final String driverID;
  final String emailAddress;
  final String firstName;
  final String lastName;
  final String operatorName;
}
