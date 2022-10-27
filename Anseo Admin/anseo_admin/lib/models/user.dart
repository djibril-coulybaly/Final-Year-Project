/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: user.dart
  Description: This is the user model that we use to structure specific information about the user account. 
               It has the same structure that is implented in the firebase database. Each user account will
               hold the follwing:
               - ID
               - Email 
               - First Name
               - Last Name
               - Address Line 1
               - Address Line 2
               - City
               - County
               - Postcode
               - Phone Number
*/
class UserAccount {
  UserAccount({
    required this.userID,
    required this.emailAddress,
    required this.firstName,
    required this.lastName,
    required this.addressline1,
    required this.addressline2,
    required this.city,
    required this.county,
    required this.postcode,
    required this.phoneNumber,
  });

  final String userID;
  final String emailAddress;
  final String firstName;
  final String lastName;
  final String addressline1;
  final String addressline2;
  final String city;
  final String county;
  final String postcode;
  final String phoneNumber;
}
