/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  File Description: Authentication with Firebase
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:journey_planner/models/user.dart';

class FAS {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /* Creating a user object from the Firebase user */
  UserModel? _userModel(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  /* Detecting authentication changes in the user */
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map((User? user) => _userModel(user!));
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
      print(user);
      return _userModel(user);
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
}
