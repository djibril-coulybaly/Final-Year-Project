/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: firebase_database.dart
  File Description: Functions used to provide transactional queries with Firebase
*/

// Imports utilised in this file
import 'package:cloud_firestore/cloud_firestore.dart';

class FDB {
  /* Reference to the users collection in the firestore cloud database */
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  /* Reference to the drivers collection in the firestore cloud database */
  final CollectionReference driversCollection =
      FirebaseFirestore.instance.collection('drivers');

  /* Reference to the admins collection in the firestore cloud database */
  final CollectionReference adminsCollection =
      FirebaseFirestore.instance.collection('admins');

  /* Function to add the additional information that we collected from the user and enter it into our firebase database */
  Future initUpdateUserData(
    String firstName,
    String lastName,
    String addressline1,
    String addressline2,
    String city,
    String county,
    String postcode,
    String phoneNumber,
    String uid,
    String email,
  ) async {
    /* Finding the document with the users id in the users collection. If its not found, firebase will create a document with the user id*/
    return await usersCollection.doc(uid).set({
      'first_name': firstName,
      'last_name': lastName,
      'address_line_1': addressline1,
      'address_line_2': addressline2,
      'city': city,
      'county': county,
      'postcode': postcode,
      'phone_number': phoneNumber,
      'email': email,
    });
  }

  /* Function to add the additional information that we collected from the user and enter it into our firebase database */
  Future initUpdateDriverData(
    String firstName,
    String lastName,
    String operatorName,
    String uid,
    String email,
  ) async {
    /* Finding the document with the users id in the users collection. If its not found, firebase will create a document with the user id*/
    return await driversCollection.doc(uid).set({
      'first_name': firstName,
      'last_name': lastName,
      'operator': operatorName,
      'email': email,
    });
  }

  /* Function to add the additional information that we collected from the user and enter it into our firebase database */
  Future initUpdateAdminData(
    String firstName,
    String lastName,
    String uid,
    String email,
  ) async {
    /* Finding the document with the users id in the users collection. If its not found, firebase will create a document with the user id*/
    return await adminsCollection.doc(uid).set({
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
    });
  }

  /* Function to get a list of all the users that is stored on the firebase database */
  Future getUserList() async {
    return await usersCollection.get();
  }

  /* Function to get a list of all the drivers that is stored on the firebase database */
  Future getDriverList() async {
    return await driversCollection.get();
  }

  /* Function to get a list of all the admins that is stored on the firebase database */
  Future getAdminList() async {
    return await adminsCollection.get();
  }

  /* Function to update the email of a user account in the firebase database */
  Future updateUserEmailAddress(String? uid, String? email) async {
    try {
      await usersCollection.doc(uid).update({
        'email': email,
      });
      return true;
    } catch (e) {
      // return e;
      print(e.toString());
    }
  }

  /* Function to update the email of a driver account in the firebase database */
  Future updateDriverEmailAddress(String? uid, String? email) async {
    try {
      await driversCollection.doc(uid).update({
        'email': email,
      });
      return true;
    } catch (e) {
      return e;
      // print(e.toString());
    }
  }

  /* Function to update the email of a admin account in the firebase database */
  Future updateAdminEmailAddress(String? uid, String? email) async {
    try {
      await adminsCollection.doc(uid).update({
        'email': email,
      });
      return true;
    } catch (e) {
      // return e;
      print(e.toString());
    }
  }

  /* Function to update the personal information of a user account in the firebase database */
  Future updateUserPersonalInformation(
    String? uid,
    String firstName,
    String lastName,
    String addressline1,
    String addressline2,
    String city,
    String county,
    String postcode,
    String phoneNumber,
  ) async {
    try {
      await usersCollection.doc(uid).update({
        'first_name': firstName,
        'last_name': lastName,
        'address_line_1': addressline1,
        'address_line_2': addressline2,
        'city': city,
        'county': county,
        'postcode': postcode,
        'phone_number': phoneNumber,
      });
    } catch (e) {
      // return e;
      print(e.toString());
    }
  }

  /* Function to update the personal information of a driver account in the firebase database */
  Future updateDriverPersonalInformation(
    String? uid,
    String firstName,
    String lastName,
    String operatorName,
  ) async {
    try {
      await driversCollection.doc(uid).update({
        'first_name': firstName,
        'last_name': lastName,
        'operator': operatorName
      });
      // return true;
    } catch (e) {
      // return e;
      print(e.toString());
    }
  }

  /* Function to update the personal information of a admin account in the firebase database */
  Future updateAdminPersonalInformation(
    String? uid,
    String firstName,
    String lastName,
  ) async {
    try {
      await adminsCollection.doc(uid).update({
        'first_name': firstName,
        'last_name': lastName,
      });
    } catch (e) {
      // return e;
      print(e.toString());
    }
  }

  /* Function to update the email of a user account in the firebase database */
  Future deleteUserAccount(
    String? uid,
  ) async {
    try {
      await usersCollection.doc(uid).delete();
      // return true;
    } catch (e) {
      // return e;
      print(e.toString());
    }
  }

  /* Function to update the email of a driver account in the firebase database */
  Future deleteDriverAccount(
    String? uid,
  ) async {
    try {
      await driversCollection.doc(uid).delete();
      // return true;
    } catch (e) {
      // return e;
      print(e.toString());
    }
  }

  /* Function to update the email of a admin account in the firebase database */
  Future deleteAdminAccount(
    String? uid,
  ) async {
    try {
      await adminsCollection.doc(uid).delete();
      // return true;
    } catch (e) {
      // return e;
      print(e.toString());
    }
  }
}
