/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: select_information_to_modify.dart
  Description: This file allows the admin to modify the following about a specific account: 
               - Email 
               - Password
               - Personal Information

               The account to modify, alongside its account type, have been previously selected  
               from view_account_list.dart
*/

// Imports utilised in this file
import 'package:anseo_admin/pages/options/modify_account/modify_admin_account_details.dart';
import 'package:anseo_admin/pages/options/modify_account/modify_driver_account_details.dart';
import 'package:anseo_admin/pages/options/modify_account/modify_email.dart';
import 'package:anseo_admin/pages/options/modify_account/modify_password.dart';
import 'package:anseo_admin/pages/options/modify_account/modify_user_account_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectInformationToModify extends StatefulWidget {
  /* 
    This class takes in 2 parameters: 
    -The account whose details we are about to modify
    -The type of the account whose details we are about to modify.
  */
  final dynamic account;
  final String accountType;
  const SelectInformationToModify(this.account, this.accountType, {Key? key})
      : super(key: key);

  @override
  State<SelectInformationToModify> createState() =>
      _SelectInformationToModifyState();
}

class _SelectInformationToModifyState extends State<SelectInformationToModify> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.deepPurple[300],
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Select Information To Modify',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            fontFamily: GoogleFonts.manrope().fontFamily,
            color: Colors.white,
          ),
        ),
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
                  "Select one of the following options",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    fontFamily: GoogleFonts.manrope().fontFamily,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),

                // Modify Email and Modify Password Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Modify Email Button
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

                            // Image Icon for Modify Email
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 90,
                                    width: 90,
                                    child: Image.asset(
                                      'assets/icons/email.png',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Modify Email Text
                          Text(
                            'Modify Email',
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
                        If the admin clicks on the button, they will be redirected to the Modify Email page
                        (modify_email.dart) with the account and account type passed as parameters
                      */
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ModifyEmail(
                                widget.account, widget.accountType)),
                      ),
                    ),

                    // Modify Password Button
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

                            // Image Icon for Modify Password
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 90,
                                    width: 90,
                                    child: Image.asset(
                                      'assets/icons/password.png',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Modify Password Text
                          Text(
                            'Modify Password',
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
                        If the admin clicks on the button, they will be redirected to the Modify Password page
                        (modify_password.dart) with the account and account type passed as parameters
                      */
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ModifyPassword(
                                widget.account, widget.accountType)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),

                // Modify Personal Information Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Modify Personal Information Button
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

                            // Image Icon for Modify Personal Information
                            child: Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 90,
                                    width: 90,
                                    child: Image.asset(
                                      'assets/icons/information.png',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Modify Personal Information Text
                          Text(
                            'Modify\nPersonal Information',
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
                        If the admin clicks on the button, depending on the account type, the admin will be redirected to 
                        the Modify User Account Details page (modify_user_account_details.dart), Modify Driver Account Details page (modify_driver_account_details.dart)
                        or Modify Admin Account Details page (modify_admin_account_details.dart). In any case, the account selected for modifying will be  
                        passed as a parameter to these pages
                      */
                      onTap: () => widget.accountType == "User"
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ModifyUserAccountDetails(widget.account)),
                            )
                          : widget.accountType == "Driver"
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ModifyDriverAccountDetails(
                                              widget.account)),
                                )
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ModifyAdminAccountDetails(
                                              widget.account)),
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
