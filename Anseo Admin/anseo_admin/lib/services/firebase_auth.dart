/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: firebase_auth.dart
  File Description: Functions used to provide authentication with Firebase
*/

// Imports utilised in this file
import 'package:firebase_auth/firebase_auth.dart';
import 'package:anseo_admin/models/account.dart';
import 'package:anseo_admin/services/firebase_database.dart';
import 'package:http/http.dart' as http;

class FAS {
  // Instance of the Firebase Authentication SDK
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /* Creating an account object from the Firebase admin */
  AccountModel? _accountModel(User? admin) {
    return admin != null
        ? AccountModel(
            uid: admin.uid,
            email: admin.email,
          )
        : null;
  }

  /* Detecting authentication changes in the admin */
  Stream<AccountModel?> get admin {
    return _auth.authStateChanges().map((User? admin) => _accountModel(admin!));
  }

  /* Sign in using email and password */
  Future signInAdmin(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? admin = result.user;
      return admin;
    } catch (error) {
      // print(error.toString());
      return error;
    }
  }

  /* Sign up a user account using the following fields:
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
      // UserCredential result = await _auth.createUserWithEmailAndPassword(
      //     email: email, password: password);
      // User? user = result.user;

      /* 
        Creating a user account by making a call to a Firebase Cloud Function named 'createUserAccount', 
        which uses Firebase Auth to create the account on the server side. The reason why the account is 
        made on the server as opposed to in application is that if an account was to be created traditionally 
        using createUserWithEmailAndPassword(), it will log the current admin out and sign the newly created
        account instead, which in turn wont pass the validation checks that we've set in the beginning of the
        application. By creating the account on the server, we can prevent this from happening and also maintain
        security of the creation and handing of personal information of the account holder.
      */
      final response = await http.post(
          Uri.parse(
              'https://us-central1-journey-planner-79eb0.cloudfunctions.net/createUserAccount'),
          body: {'email': email, 'password': password});

      /*
        If the account has been created successfully we will proceed to assign privilages to the account.
        Otherwise an error messgae will be returned 
      */
      if (response.statusCode != 200) {
        print("error");
        return false;
      } else {
        // return _AccountModel(user);

        /* 
          Assigning the account user privilages that will ensure it can only log into Anseo Transit and not Anseo Validator or Anseo Admin.
          This is done by making a call to a Firebase Cloud Function named 'setUserAccountPrivilages', which uses Firebase Auth to set the
          token of 'user' as true for this account.
        */
        final response2 = await http.post(
            Uri.parse(
                'https://us-central1-journey-planner-79eb0.cloudfunctions.net/setUserAccountPrivilages'),
            body: {'uid': response.body});

        /*
          If the privilages have been assigned successfully we will create a firebase document to store the personal information relating to this 
          account and return the ID of the newly created account. Otherwise an error messgae will be returned 
        */
        if (response2.statusCode != 200) {
          print("error");
          return false;
        } else {
          /* Creating a new document for the user using the uid that 
        will store the addtional information that we obtained 
        in the sign up page  */
          await FDB().initUpdateUserData(
              firstName,
              lastName,
              addressline1,
              addressline2,
              city,
              county,
              postcode,
              phoneNumber,
              response.body,
              email);

          return response.body;
        }
      }

      // return _AccountModel(user);
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
    -  operator name,
  */
  Future signUpDriver(
    String email,
    String password,
    String firstName,
    String lastName,
    String operatorName,
  ) async {
    try {
      /* 
        Creating a driver account by making a call to a Firebase Cloud Function named 'createUserAccount', 
        which uses Firebase Auth to create the account on the server side. The reason why the account is 
        made on the server as opposed to in application is that if an account was to be created traditionally 
        using createUserWithEmailAndPassword(), it will log the current admin out and sign the newly created
        account instead, which in turn wont pass the validation checks that we've set in the beginning of the
        application. By creating the account on the server, we can prevent this from happening and also maintain
        security of the creation and handing of personal information of the account holder.
      */
      final response = await http.post(
        Uri.parse(
            'https://us-central1-journey-planner-79eb0.cloudfunctions.net/createUserAccount'),
        body: {'email': email, 'password': password},
      );

      /*
        If the account has been created successfully we will proceed to assign privilages to the account.
        Otherwise an error messgae will be returned 
      */
      if (response.statusCode != 200) {
        print("error");
        return false;
      } else {
        /* 
          Assigning the account driver privilages that will ensure it can only log into Anseo Validator and not Anseo Transit or Anseo Admin.
          This is done by making a call to a Firebase Cloud Function named 'setDriverAccountPrivilages', which uses Firebase Auth to set the
          token of 'driver' as true for this account.
        */
        final response2 = await http.post(
          Uri.parse(
              'https://us-central1-journey-planner-79eb0.cloudfunctions.net/setDriverAccountPrivilages'),
          body: {'uid': response.body},
        );

        /*
          If the privilages have been assigned successfully we will create a firebase document to store the personal information relating to this 
          account and return the ID of the newly created account. Otherwise an error messgae will be returned 
        */
        if (response.statusCode != 200) {
          print("error");
          return false;
        } else {
          /* Creating a new document for the user using the uid that 
      will store the addtional information that we obtained 
      in the sign up page  */
          await FDB().initUpdateDriverData(
              firstName, lastName, operatorName, response.body, email);
          return response.body;
        }
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  /* Sign up using the following fields:
    -  email, 
    -  password, 
    -  first name, 
    -  last name
  */
  Future signUpCurrentAdmin(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;

      /* Creating a new document for the user using the uid that 
      will store the addtional information that we obtained 
      in the sign up page  */
      await FDB().initUpdateAdminData(firstName, lastName, user!.uid, email);

      /* 
        Assigning the account admin privilages that will ensure it can only log into Anseo Admin and not Anseo Validator or Anseo Transit.
        This is done by making a call to a Firebase Cloud Function named 'setAdminAccountPrivilages', which uses Firebase Auth to set the
        token of 'admin' as true for this account.
      */
      final response = await http.post(
          Uri.parse(
              'https://us-central1-journey-planner-79eb0.cloudfunctions.net/setAdminAccountPrivilages'),
          body: {'uid': user.uid});

      /*
        If the privilages have been assigned successfully we will return the user information and proceed with logging in.
        Otherwise an error messgae will be returned 
      */
      if (response.statusCode != 200) {
        print("error");
      } else {
        return _accountModel(user);
      }
    } catch (error) {
      print(error.toString());
      return null;
    }
  }

  /* Sign up for a admin account (not to currently use) using the following fields:
    -  email, 
    -  password, 
    -  first name, 
    -  last name
  */
  Future signUpAdmin(
    String email,
    String password,
    String firstName,
    String lastName,
  ) async {
    try {
      /* 
        Creating a admin account by making a call to a Firebase Cloud Function named 'createUserAccount', 
        which uses Firebase Auth to create the account on the server side. The reason why the account is 
        made on the server as opposed to in application is that if an account was to be created traditionally 
        using createUserWithEmailAndPassword(), it will log the current admin out and sign the newly created
        account instead, which in turn wont pass the validation checks that we've set in the beginning of the
        application. By creating the account on the server, we can prevent this from happening and also maintain
        security of the creation and handing of personal information of the account holder.
      */
      final response = await http.post(
        Uri.parse(
            'https://us-central1-journey-planner-79eb0.cloudfunctions.net/createUserAccount'),
        body: {'email': email, 'password': password},
      );

      /*
        If the account has been created successfully we will proceed to assign privilages to the account.
        Otherwise an error messgae will be returned 
      */
      if (response.statusCode != 200) {
        print("error");
        return false;
      } else {
        // return _AccountModel(user);

        /* 
          Assigning the account admin privilages that will ensure it can only log into Anseo Admin and not Anseo Validator or Anseo Transit.
          This is done by making a call to a Firebase Cloud Function named 'setAdminAccountPrivilages', which uses Firebase Auth to set the
          token of 'admin' as true for this account.
        */
        final response2 = await http.post(
          Uri.parse(
              'https://us-central1-journey-planner-79eb0.cloudfunctions.net/setAdminAccountPrivilages'),
          body: {'uid': response.body},
        );

        /*
          If the privilages have been assigned successfully we will create a firebase document to store the personal information relating to this 
          account and return the ID of the newly created account. Otherwise an error messgae will be returned 
        */
        if (response2.statusCode != 200) {
          print("error");
          return false;
        } else {
          /* Creating a new document for the user using the uid that 
      will store the addtional information that we obtained 
      in the sign up page  */
          await FDB()
              .initUpdateAdminData(firstName, lastName, response.body, email);
          return response.body;
        }
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
