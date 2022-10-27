/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: user.dart
  Description: This is the user model that we use to collect specific information about the user logged 
               into the application - in particular the ID of the user. The class UserInformation will 
               potentially be user to get more information about the user when the account page is implemented
*/

class UserModel {
  UserModel({
    required this.uid,
  });

  final String uid;
}

// class UserInformation {
//   UserInformation({
//     required this.emailAddress,
//     required this.firstName,
//     required this.lastName,
//     required this.addressline1,
//     required this.addressline2,
//     required this.city,
//     required this.county,
//     required this.postcode,
//     required this.phoneNumber,
//   });

//   final String emailAddress;
//   final String firstName;
//   final String lastName;
//   final String addressline1;
//   final String addressline2;
//   final String city;
//   final String county;
//   final String postcode;
//   final String phoneNumber;
// }
