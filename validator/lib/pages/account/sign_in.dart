/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Validator
  File Name: sign_in.dart
  File Description: This file allows the driver to sign in to the application by entering their details in the form. 
                    The data will be validated and processed by firebase_auth in signing in and checking if the 
                    account has been assigned driver privilages in order to use this application 
*/

// Imports utilised in this file
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validator/pages/select_option_for_driver.dart';
import 'package:validator/services/firebase_auth.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Instance of the class FAS located in firebase_auth.dart, allowing us to authenticate the user with Firebase
  final FAS _auth = FAS();

  // A global key that assists us in validating the sign in form
  final _formKey = GlobalKey<FormState>();

  // Text field state within the form
  String error = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Sign In",
                    style: (TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.w400,
                      fontFamily: GoogleFonts.manrope().fontFamily,
                      color: Colors.black,
                    )),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),

                // Form wiget which will display the required information from the user and provide validation on user input
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      /* Input Email Address */
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const Text(
                            "Email Address",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                              color: Color(0xFF9CA4AA),
                            ),
                          ),
                          const SizedBox(
                            height: 7.0,
                          ),
                          TextFormField(
                            validator: (val) =>
                                val!.isEmpty ? 'Enter an email' : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      /* Input Password */
                      const SizedBox(height: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            "Password",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                              color: Color(0xFF9CA4AA),
                            ),
                          ),
                          const SizedBox(
                            height: 7.0,
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (val) => val!.length < 6
                                ? 'Enter a password 6+ chars long'
                                : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 15.0),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /* Sign in button */
                const SizedBox(height: 40.0),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      // primary: Colors.transparent,
                      // shadowColor: Colors.transparent,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    /* 
                      If the form validator doesnt produce any errors, the application will attempt to sign the driver in. 
                      If it encounters an error, it will be displayed to the driver.
                    */
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result =
                            await _auth.signInUser(email, password);

                        if (result is FirebaseAuthException) {
                          setState(() {
                            error = result.message!;
                          });
                        } else {
                          // The value that we want to obtain when we check the driver privilages of the account trying to sign in to the application
                          final isDriver =
                              (await _auth.currentUserClaims)!['driver'] ==
                                  true;

                          /* 
                            If the account has driver privilages, the driver will be redirected to the Select Options screen in 'select_options_for_driver.dart'. Otherwise, the account will be 
                            logged out of the application and be notified that their account doensn't have the required privilages to access this application
                          */
                          if (isDriver) {
                            // var driverInfo = _dbAuth.getDriverData(result.uid);

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SelectOptionForDriver(result.uid)),
                              (Route<dynamic> route) => false,
                            );
                          } else {
                            await _auth.signOut();
                            setState(() {
                              error =
                                  "This account doesn't have privilages to access the validator application!";
                            });
                          }
                        }
                      }
                    },
                    child: Ink(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF4158D0),
                            Color(0xFFC850C0),
                          ],
                        ),
                      ),
                      child: Container(
                        width: 300,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          'SIGN IN',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.w400,
                            fontFamily: GoogleFonts.manrope().fontFamily,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // ),

                /* Displaying any error messages to the user */
                const SizedBox(height: 12.0),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
