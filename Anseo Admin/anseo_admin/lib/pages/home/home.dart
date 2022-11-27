/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: home.dart
  File Description: This file presents the user with the option to search for real time information on a particular stop based on the following:
                    -Configure Travel Card
                    -Add Account
                    -Modify Account
                    -Delete Account
*/

// Imports utilised in this file
import 'package:anseo_admin/firebase_wrapper.dart';
import 'package:anseo_admin/pages/options/add_account/add_account.dart';
import 'package:anseo_admin/pages/options/configure_travel_card/configure_travel_cards.dart';
import 'package:anseo_admin/pages/options/delete_account/delete_account.dart';
import 'package:anseo_admin/pages/options/modify_account/modify_account.dart';
import 'package:anseo_admin/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Instance of the class FAS located in firebase_auth.dart, allowing us to authenticate the admin with Firebase
  final FAS _auth = FAS();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple[300],
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Admin Panel',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            fontFamily: GoogleFonts.manrope().fontFamily,
            color: Colors.white,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              /*
                If the admin clicks on the button, they will be signed out of the account and redirected to 'firebase_wrapper.dart',
                which will check to see if the admin is logged into the application. In this case the admin is signed out and 
                therefore will be shown the landing page.
              */
              await _auth.signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const WrapperForFirebase(),
                ),
              );
            },
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Select one fo the following options",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontFamily: GoogleFonts.manrope().fontFamily,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                // Configure Travel Cards and Add Account Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Configure Travel Card Button
                    GestureDetector(
                      child: Column(
                        children: [
                          // Styling the Container
                          Container(
                            height: 150,
                            width: 150,
                            padding: const EdgeInsets.all(28),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),

                            // Image Icon for Configure Travel Card
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 90,
                                    width: 90,
                                    child: Image.asset(
                                      'assets/icons/travel_card.png',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Configure Travel Card Text
                          const SizedBox(height: 12),
                          Text(
                            'Configure\nTravel Cards',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: GoogleFonts.manrope().fontFamily,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      /* 
                        If the admin clicks on the button, they will be redirected to the Configure Travel Cards page
                        (configure_travel_cards.dart)
                      */
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConfigureTravelCards()),
                      ),
                    ),

                    // Add Account Button
                    GestureDetector(
                      child: Column(
                        children: [
                          Container(
                            // Styling the Container
                            height: 150,
                            width: 150,
                            padding: const EdgeInsets.all(28),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),

                            // Image Icon for Add Account
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 90,
                                    width: 90,
                                    child: Image.asset(
                                      'assets/icons/add.png',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Add Account Text
                          const SizedBox(height: 12),
                          Text(
                            'Add\nAccount',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: GoogleFonts.manrope().fontFamily,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      /* 
                        If the admin clicks on the button, they will be redirected to the Add Account page
                        (add_account.dart)
                      */
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddAccount()),
                      ),
                    ),
                  ],
                ),

                // Spacing between the first row of buttons and the second row of buttons
                const SizedBox(height: 18),

                // Modify Account and Delete Account Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Modify Account Button
                    GestureDetector(
                      child: Column(
                        children: [
                          Container(
                            // Styling the Container
                            height: 150,
                            width: 150,
                            padding: const EdgeInsets.all(28),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),

                            // Image Icon for Modify Account
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 90,
                                    width: 90,
                                    child: Image.asset(
                                      'assets/icons/edit.png',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Modify Account Text
                          const SizedBox(height: 12),
                          Text(
                            'Modify\nAccount',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: GoogleFonts.manrope().fontFamily,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      /* 
                        If the admin clicks on the button, they will be redirected to the Modify Account page
                        (modify_account.dart)
                      */
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ModifyAccount()),
                      ),
                    ),

                    // Delete Account Button
                    GestureDetector(
                      child: Column(
                        children: [
                          Container(
                            // Styling the Container
                            height: 150,
                            width: 150,
                            padding: const EdgeInsets.all(28),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),

                            // Image Icon for Delete Account
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 90,
                                    width: 90,
                                    child: Image.asset(
                                      'assets/icons/delete.png',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Delete Account Text
                          const SizedBox(height: 12),
                          Text(
                            'Delete\nAccount',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              fontFamily: GoogleFonts.manrope().fontFamily,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      /* 
                        If the admin clicks on the button, they will be redirected to the Delete Account page
                        (delete_account.dart)
                      */
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DeleteAccount()),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
