/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Validator
  File Name: account.dart
  Description: This is the account model that we use to collect specific information about the admin logged 
               into the application - in particular the ID of the driver.
*/


class AccountModel {
  AccountModel({
    required this.uid,
  });

  final String uid;
}

// class Driver {
//   Driver({
//     required this.driverID,
//     required this.emailAddress,
//     required this.firstName,
//     required this.lastName,
//     required this.operatorName,
//   });

//   final String driverID;
//   final String emailAddress;
//   final String firstName;
//   final String lastName;
//   final String operatorName;

//   Driver.fromSnapshot(snapshot)
//       : driverID = snapshot.id,
//         emailAddress = snapshot.data()['email'],
//         firstName = snapshot.data()['first_name'],
//         lastName = snapshot.data()['last_name'],
//         operatorName = snapshot.data()['operator'];
// }
