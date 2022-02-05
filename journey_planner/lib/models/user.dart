/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  File Description: THis is the user model - firebase

*/

class UserModel {
  UserModel({
    required this.uid,
  });

  final String uid;
}

class UserInformation {
  UserInformation({
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
