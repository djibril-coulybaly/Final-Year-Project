/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: sign_up.dart
  File Description: This file allows the user to sign up to the application by entering their details in the form. 
                    The data will be validated and processed by firebase_auth in creating a user account and 
                    assigning user privilages 
*/

// Imports utilised in this file
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:anseo_admin/pages/home/home.dart';
import 'package:anseo_admin/services/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({
    Key? key,
  }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Instance of the class FAS located in firebase_auth.dart, allowing us to authenticate the user with Firebase
  final FAS _auth = FAS();

  // A global key that assists us in validating the sign in form
  final _formKey = GlobalKey<FormState>();

  // Text field state within the form
  String error = '';
  String email = '';
  String password = '';
  String firstName = '';
  String lastName = '';

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
                // Sign Up Text
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Sign Up",
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

                // Form wiget which will display the required information from the admin and provide validation on admin input
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          /* Input First Name */
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  "First Name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.0,
                                    color: const Color(0xFF9CA4AA),
                                    fontFamily:
                                        GoogleFonts.manrope().fontFamily,
                                  ),
                                ),
                                const SizedBox(
                                  height: 7.0,
                                ),
                                TextFormField(
                                    validator: (val) => val!.isEmpty
                                        ? 'Enter a first name'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => firstName = val);
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
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15.0),

                          /* Input Last Name */
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(
                                  "Last Name",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14.0,
                                    color: const Color(0xFF9CA4AA),
                                    fontFamily:
                                        GoogleFonts.manrope().fontFamily,
                                  ),
                                ),
                                const SizedBox(
                                  height: 7.0,
                                ),
                                TextFormField(
                                    validator: (val) => val!.isEmpty
                                        ? 'Enter a last name'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => lastName = val);
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
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      /* Input Email Address */
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            "Email Address",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                              color: const Color(0xFF9CA4AA),
                              fontFamily: GoogleFonts.manrope().fontFamily,
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
                              )),
                        ],
                      ),
                      /* Input Password */
                      const SizedBox(height: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            "Password",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 14.0,
                              color: const Color(0xFF9CA4AA),
                              fontFamily: GoogleFonts.manrope().fontFamily,
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
                              )),
                        ],
                      ),
                    ],
                  ),
                ),

                /* Submit Button */
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
                      If the form validator doesn't produce any errors, the application will attempt to 
                      sign up the admin, assign admin privialges and log them into the application. 
                      If it encounters an error, it will be displayed to the admin. Otherwise the admin will 
                      be redirected to the home screen in 'home.dart'.
                    */
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result = await _auth.signUpCurrentAdmin(
                            email, password, firstName, lastName);
                        if (result == null) {
                          setState(() {
                            error = 'Please supply a valid email';
                          });
                        } else {
                          // Navigator.of(context).pushReplacement(
                          //   MaterialPageRoute<void>(
                          //     builder: (BuildContext context) => SelectOption(),
                          //     // WrapperForFirebase(),
                          //   ),
                          // );

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Home()),
                            (Route<dynamic> route) => false,
                          );
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
                          'SIGN UP',
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

                /* Displaying any error messages to the user */
                const SizedBox(height: 12.0),
                Text(
                  error,
                  style: const TextStyle(color: Colors.red, fontSize: 14.0),
                ),
              ],
            ),
          ),

          // ElevatedButton(
          //     style:
          //         ElevatedButton.styleFrom(primary: Colors.orange[400]),
          //     // color: Colors.pink[400],
          //     child: const Text(
          //       'Sign Up',
          //       style: TextStyle(color: Colors.white),
          //     ),
          //     onPressed: () async {
          //       if (_formKey.currentState!.validate()) {
          //         dynamic result = await _auth.signUpUser(
          //             email,
          //             password,
          //             firstName,
          //             lastName,
          //             addressline1,
          //             addressline2,
          //             city,
          //             county,
          //             postcode,
          //             phoneNumber);
          //         if (result == null) {
          //           setState(() {
          //             error = 'Please supply a valid email';
          //           });
          //         }
          //       }
          //     }),
          // const SizedBox(height: 12.0),
          // Text(
          //   error,
          //   style: const TextStyle(color: Colors.red, fontSize: 14.0),
          // )
          // ],
        ),
      ),
    );
  }
}
