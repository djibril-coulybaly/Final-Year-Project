/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: sign_up.dart
  File Description: This file allows the user to sign up to the application by entering their details in the form. 
                    The data will be validated and processed by firebase_auth in creating a user account and 
                    assigning user privilages 
*/

// Imports utilised in this file
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_planner/pages/home/home.dart';
import 'package:journey_planner/pages/home/root_navigation.dart';
import 'package:journey_planner/services/firebase_auth.dart';

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
  String addressline1 = '';
  String addressline2 = '';
  String city = '';
  String county = '';
  String postcode = '';
  String phoneNumber = '';

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
                  child: const Text(
                    "Sign Up",
                    style: (TextStyle(fontSize: 30.0)),
                  ),
                ),
                const SizedBox(height: 30.0),

                // Form wiget which will display the required information from the user and provide validation on user input
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
                                const Text(
                                  "First Name",
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
                                const Text(
                                  "Last Name",
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
                              )),
                        ],
                      ),
                      /* Input Password */
                      const SizedBox(height: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
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
                              )),
                        ],
                      ),
                      /* Input Phone Number */
                      const SizedBox(height: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const Text(
                            "Phone Number",
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
                                  val!.isEmpty ? 'Enter a phone number' : null,
                              onChanged: (val) {
                                setState(() => phoneNumber = val);
                              },
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                              ],
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

                      /* Input Address Line 1 */
                      const SizedBox(height: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const Text(
                            "Address Line 1",
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
                              validator: (val) => val!.isEmpty
                                  ? 'Enter an address line 1'
                                  : null,
                              onChanged: (val) {
                                setState(() => addressline1 = val);
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

                      /* Input Address Line 2 */
                      const SizedBox(height: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const Text(
                            "Address Line 2",
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
                              validator: (val) => val!.isEmpty
                                  ? 'Enter an address line 2'
                                  : null,
                              onChanged: (val) {
                                setState(() => addressline2 = val);
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

                      /* Input City */
                      const SizedBox(height: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          const Text(
                            "City",
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
                                  val!.isEmpty ? 'Enter a city' : null,
                              onChanged: (val) {
                                setState(() => city = val);
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
                      const SizedBox(height: 20.0),
                      Row(
                        children: <Widget>[
                          /* Input County */
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                const Text(
                                  "County",
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
                                        val!.isEmpty ? 'Enter a county' : null,
                                    onChanged: (val) {
                                      setState(() => county = val);
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
                          const SizedBox(
                            width: 15.0,
                          ),
                          /* Input Postcode */
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                const Text(
                                  "Postcode",
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
                                    validator: (val) => val!.isEmpty
                                        ? 'Enter a postcode'
                                        : null,
                                    onChanged: (val) {
                                      setState(() => postcode = val);
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
                    ],
                  ),
                ),

                /* Submit Button */
                const SizedBox(height: 40.0),
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    /* 
                      If the form validator doesnt produce any errors, the application will attempt to 
                      sign up the user, assign user privialges and log them into the application. 
                      If it encounters an error, it will be displayed to the user. Otherwise the user will 
                      be redirected to the homepage in 'homepage.dart'.
                    */
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        dynamic result = await _auth.signUpUser(
                            email,
                            password,
                            firstName,
                            lastName,
                            addressline1,
                            addressline2,
                            city,
                            county,
                            postcode,
                            phoneNumber);
                        if (result == null) {
                          setState(() {
                            error = 'Please supply a valid email';
                          });
                        } else {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RootNavigation()),
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
        ),
      ),
    );
  }
}
