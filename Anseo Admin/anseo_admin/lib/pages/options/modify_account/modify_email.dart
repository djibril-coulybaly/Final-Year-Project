/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: modify_email.dart
  Description: This file contains a Form widget that will allow the admin to modify the email pertaining to a particular account.
               This is done in conjunction with the cloud function that is set up in index.js
*/

// Imports utilised in this file
import 'dart:convert';
import 'dart:developer';

import 'package:anseo_admin/services/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:sweetsheet/sweetsheet.dart';

class ModifyEmail extends StatefulWidget {
  /* 
    This class takes in 2 parameters: 
    -The account whose details we are about to modify
    -The type of the account whose details we are about to modify.
  */
  final dynamic account;
  final String accountType;
  const ModifyEmail(this.account, this.accountType, {Key? key})
      : super(key: key);

  @override
  State<ModifyEmail> createState() => _ModifyEmailState();
}

class _ModifyEmailState extends State<ModifyEmail> {
  // A global key that assists us in validating the sign in form
  final _formKey = GlobalKey<FormState>();

  // Instance of the class FDB located in firebase_database.dart, allowing us to make CRUD operations with the user data stored in Firebase
  final FDB _dbAuth = FDB();

  // Instance of the flutter package 'sweetsheets', which allow us to create custom pop-up messages to the user
  final SweetSheet _sweetSheet = SweetSheet();

  @override
  Widget build(BuildContext context) {
    // Text field state within the form
    final _emailController = TextEditingController();
    _emailController.text = widget.account.emailAddress;
    String error = '';

    // List<AccountModel> ac = [];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Modify Email',
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
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: const Text(
                    "Update Form",
                    style: (TextStyle(fontSize: 30.0)),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      /* Input Email Address */
                      const SizedBox(height: 20.0),
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
                              controller: _emailController,
                              validator: (val) =>
                                  val!.isEmpty ? 'Enter an email' : null,
                              // onChanged: (val) {
                              //   setState(() => email = val);
                              // },
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
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    /* 
                      If the form validator doesn't produce any errors, the application will attempt to update the 
                      current email set on the account with the new email entered using cloud functions. If it 
                      encounters an error, it will be displayed to the user. Otherwise the user will be 
                      redirected to the home screen in 'home.dart'.
                    */
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        inspect(_emailController);

                        /* 
                          Updating the email associated with the account by passing the UID of the account and the new email 
                          to a Firebase Cloud Function named 'updateSpecificUserEmail'
                        */
                        final response = await http.post(
                            Uri.parse(
                                'https://us-central1-journey-planner-79eb0.cloudfunctions.net/updateSpecificUserEmail'),
                            body: {
                              'uid': widget.accountType == "User"
                                  ? widget.account.userID
                                  : widget.accountType == "Driver"
                                      ? widget.account.driverID
                                      : widget.account.adminID,
                              'email': _emailController.text,
                            });

                        final jsonResponse = jsonDecode(response.body);

                        /*
                          If the email has been modified successfully we will update the firebase document pertaining to the account
                          to reflect the email change. Otherwise the appropiate error messages will be displayed 
                        */
                        if (response.statusCode != 200) {
                          _sweetSheet.show(
                            isDismissible: false,
                            context: context,
                            title: const Text("ERROR!"),
                            description: Text(
                                "${jsonResponse['message']}. Click on 'Return' to try again"),
                            color: SweetSheetColor.DANGER,
                            icon: Icons.task_alt_sharp,
                            positive: SweetSheetAction(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              title: 'RETURN',
                              icon: Icons.keyboard_return,
                            ),
                          );
                        } else {
                          // ac = List.from(jsonResponse.map((doc) =>
                          //     AccountModel(
                          //         uid: doc["uid"], email: doc["email"])));

                          // inspect(ac);

                          // widget.account(emailAddress: "hello");

                          dynamic result = widget.accountType == "User"
                              ? await _dbAuth.updateUserEmailAddress(
                                  widget.account.userID, _emailController.text)
                              : widget.accountType == "Driver"
                                  ? await _dbAuth.updateDriverEmailAddress(
                                      widget.account.driverID,
                                      _emailController.text)
                                  : await _dbAuth.updateAdminEmailAddress(
                                      widget.account.adminID,
                                      _emailController.text);

                          if (result != true) {
                            setState(() {
                              error = 'Please supply a valid email';
                            });

                            _sweetSheet.show(
                              isDismissible: false,
                              context: context,
                              title: const Text("ERROR!"),
                              description: Text(
                                  "${result}. Click on 'Return' to try again"),
                              color: SweetSheetColor.DANGER,
                              icon: Icons.task_alt_sharp,
                              positive: SweetSheetAction(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                title: 'RETURN',
                                icon: Icons.keyboard_return,
                              ),
                            );
                          } else {
                            _sweetSheet.show(
                              isDismissible: false,
                              context: context,
                              title: const Text("Email Modified!"),
                              description: Text(
                                  "The email has been modified to '${_emailController.text}'. Click on 'Return' to return to the homepage"),
                              color: SweetSheetColor.SUCCESS,
                              icon: Icons.task_alt_sharp,
                              positive: SweetSheetAction(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                },
                                title: 'RETURN',
                                icon: Icons.keyboard_return,
                              ),
                            );
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
                          'UPDATE EMAIL',
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
