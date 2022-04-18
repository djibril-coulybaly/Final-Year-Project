/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: firebase_auth.dart
  File Description: Functions used to provide authentication with Firebase
*/

// Imports utilised in this file
import 'package:firebase_auth/firebase_auth.dart';
import 'package:journey_planner/models/user.dart';
import 'package:journey_planner/services/firebase_database.dart';
import 'package:http/http.dart' as http;

class FAS {
  // Instance of the Firebase Authentication SDK
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /* Creating a user object from the Firebase user */
  UserModel? _userModel(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  /* Detecting authentication changes in the user */
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map((User? user) => _userModel(user!));
  }

  /* Sign in to the application using email and password. This function will return the user account. */
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
  Future signUpUser(
    String email,
    String password,
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
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      /* 
        Creating a new document for the user using the uid that will store the addtional 
        information that we obtained in the sign up page
      */
      await FDB(uid: user!.uid).initUpdateUserData(
          firstName,
          lastName,
          addressline1,
          addressline2,
          city,
          county,
          postcode,
          phoneNumber,
          email);

      /* 
        Assigning the account user privilages that will ensure it can only log into Anseo Transit and not Anseo Validator or Anseo Admin.
        This is done by making a call to a Firebase Cloud Function named 'setUserAccountPrivilages', which uses Firebase Auth to set the
        token of 'user' as true for this account.
      */
      final response = await http.post(
          Uri.parse(
              'https://us-central1-journey-planner-79eb0.cloudfunctions.net/setUserAccountPrivilages'),
          body: {'uid': user.uid});

      /*
        If the privilages have been assigned successfully we will return the user information and proceed with logging in.
        Otherwise an error messgae will be returned 
      */
      if (response.statusCode != 200) {
        print("error");
      } else {
        return _userModel(user);
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

  // Returning a list of tokens or privilages that has been assigned to the user who is trying to sign in to the application
  // Code source = https://stackoverflow.com/questions/58373885/how-do-i-access-custom-claims
  Future<Map<String, dynamic>?> get currentUserClaims async {
    final user = FirebaseAuth.instance.currentUser;

    // If refresh is set to true, a refresh of the id token is forced.
    final idTokenResult = await user!.getIdTokenResult(true);

    return idTokenResult.claims;
  }
}
