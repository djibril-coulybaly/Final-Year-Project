/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Validator
  File Name: firebase_auth.dart
  File Description: Functions used to provide authentication with Firebase
*/

// Imports utilised in this file
import 'package:firebase_auth/firebase_auth.dart';
import 'package:validator/models/account.dart';
import 'package:validator/services/firebase_database.dart';
import 'package:http/http.dart' as http;

class FAS {
  // Instance of the Firebase Authentication SDK
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /* Creating a user object from the Firebase user */
  AccountModel? _driverModel(User? user) {
    return user != null ? AccountModel(uid: user.uid) : null;
  }

  /* Detecting authentication changes in the user */
  Stream<AccountModel?> get user {
    return _auth.authStateChanges().map((User? user) => _driverModel(user!));
  }

  /* Sign in using email and password */
  Future signInUser(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  /* Sign up using the following fields:
    -  email, 
    -  password, 
    -  first name, 
    -  last name, 
    -  address line 1, 
    -  address line 2, 
    -  city, 
    -  county, 
    -  postcode,
    -  phone number 
  */
  Future signUpDriver(
    String email,
    String password,
    String firstName,
    String lastName,
    String operatorName,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      /* Creating a new document for the user using the uid that 
      will store the addtional information that we obtained 
      in the sign up page  */
      await FDB()
          .initDriverData(firstName, lastName, operatorName, user!.uid, email);

      /* 
        Assigning the account driver privilages that will ensure it can only log into Anseo Validator and not Anseo Admin or Anseo Transit.
        This is done by making a call to a Firebase Cloud Function named 'setDriverAccountPrivilages', which uses Firebase Auth to set the
        token of 'driver' as true for this account.
      */
      final response = await http.post(
          Uri.parse(
              'https://us-central1-journey-planner-79eb0.cloudfunctions.net/setDriverAccountPrivilages'),
          body: {'uid': user.uid});

      /*
        If the privilages have been assigned successfully we will return the user information and proceed with logging in.
        Otherwise an error messgae will be returned 
      */
      if (response.statusCode != 200) {
        print("error");
      } else {
        return _driverModel(user);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  /* Sign out of the application */
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  // Returning a list of tokens or privilages that has been assigned to the account that is trying to sign in to the application
  // Code source = https://stackoverflow.com/questions/58373885/how-do-i-access-custom-claims
  Future<Map<String, dynamic>?> get currentUserClaims async {
    final user = FirebaseAuth.instance.currentUser;

    // If refresh is set to true, a refresh of the id token is forced.
    final idTokenResult = await user!.getIdTokenResult(true);

    return idTokenResult.claims;
  }
}
