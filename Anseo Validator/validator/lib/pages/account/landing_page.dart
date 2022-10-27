/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Validator
  File Name: landing_page.dart
  Description: This file allows the driver to select whether to sign in or sign up to the 
               application when either logged out or running the application for the first time
*/

// Imports utilised in this file
import 'package:flutter/material.dart';
import 'package:validator/pages/account/sign_in.dart';
import 'package:validator/pages/account/sign_up.dart';
import 'package:google_fonts/google_fonts.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[200],
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Image.asset("assets/logo/logo1_black.png"),
            ),
            Text(
              'Anseo Transit\nValidator Application',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w400,
                fontFamily: GoogleFonts.manrope().fontFamily,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 50),

            // Container for Sign In/Sign Up
            Container(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 20, top: 40),
              decoration: BoxDecoration(
                color: Colors.deepPurple[300],
                // color: Color.fromARGB(246, 228, 228, 228),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              height: 250.0,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 15.0,
                  ),

                  // Sign In Button
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

                      // If the button is pressed the user will be redirected to the Sign In screen in 'sign_in.dart'
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignIn()),
                        );
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
                  const SizedBox(height: 40.0),

                  // Sign Up Button
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

                      // If the button is pressed the user will be redirected to the Sign Up screen in 'sign_up.dart'
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()),
                        );
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

                  const SizedBox(
                    height: 15.0,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
