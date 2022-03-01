/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  File Description: Authentication with Firebase
*/

import 'package:firebase_auth/firebase_auth.dart';
import 'package:journey_planner/models/user.dart';
import 'package:journey_planner/services/firebase_database.dart';

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

      /* Creating a new document for the user using the uid that 
      will store the addtional information that we obtained 
      in the sign up page  */
      await FDB(uid: user!.uid).initUpdateUserData(firstName, lastName,
          addressline1, addressline2, city, county, postcode, phoneNumber);

      /* Creating a new document for the user using the uid that 
      will store the tickets  */
      // await FDB(uid: user.uid).initUpdateUserTicket(
      //     true,
      //     2.5,
      //     DateTime.now(),
      //     "Dublin Bus",
      //     2.5,
      //     "39A",
      //     "hn8irhv87hrburubbr983hr984fb838bf",
      //     "Student");

      /* Creating a new document for the user using the uid that 
      will store the travel card  */
      // await FDB(uid: user.uid)
      //     .initUpdateUserTravelCard(20.00, 20.00, 30.00, 0.00, 0.00, "Student");

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
