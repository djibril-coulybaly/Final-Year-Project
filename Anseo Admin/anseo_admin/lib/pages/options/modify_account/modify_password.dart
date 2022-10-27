/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: modify_password.dart
  Description: This file contains a Form widget that will allow the admin to modify the password pertaining to a particular account.
               This is done in conjunction with the cloud function that is set up in index.js
*/

// Imports utilised in this file
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:sweetsheet/sweetsheet.dart';

class ModifyPassword extends StatefulWidget {
  /* 
    This class takes in 2 parameters: 
    -The account whose details we are about to modify
    -The type of the account whose details we are about to modify.
  */
  final dynamic account;
  final String accountType;

  const ModifyPassword(this.account, this.accountType, {Key? key})
      : super(key: key);

  @override
  State<ModifyPassword> createState() => _ModifyPasswordState();
}

class _ModifyPasswordState extends State<ModifyPassword> {
  // A global key that assists us in validating the sign in form
  final _formKey = GlobalKey<FormState>();

  // Instance of the flutter package 'sweetsheets', which allow us to create custom pop-up messages to the user
  final SweetSheet _sweetSheet = SweetSheet();

  @override
  Widget build(BuildContext context) {
    // Text field state within the form
    final _passwordController = TextEditingController();
    _passwordController.text = '';
    String error = '';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Modify Password',
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
                            controller: _passwordController,
                            obscureText: true,
                            validator: (val) => val!.length < 6
                                ? 'Enter a password 6+ chars long'
                                : null,
                            // onChanged: (val) {
                            //   setState(() => password = val);
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
                      If the form validator doesn't produce any errors, the application will attempt to update the 
                      current password set on the account with the new password entered using cloud functions. If it 
                      encounters an error, it will be displayed to the user. Otherwise the user will be 
                      redirected to the home screen in 'home.dart'.
                    */
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        inspect(_passwordController);

                        /* 
                          Updating the password associated with the account by passing the UID of the account and the new password 
                          to a Firebase Cloud Function named 'updateSpecificUserPassword'
                        */
                        final response = await http.post(
                            Uri.parse(
                                'https://us-central1-journey-planner-79eb0.cloudfunctions.net/updateSpecificUserPassword'),
                            body: {
                              'uid': widget.accountType == "User"
                                  ? widget.account.userID
                                  : widget.accountType == "Driver"
                                      ? widget.account.driverID
                                      : widget.account.adminID,
                              'password': _passwordController.text,
                            });

                        final jsonResponse = jsonDecode(response.body);

                        /*
                          If the email has been modified successfully we will visually notify the admin. 
                          Otherwise the appropiate error messages will be displayed 
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
                          _sweetSheet.show(
                            isDismissible: false,
                            context: context,
                            title: const Text("Password Modified!"),
                            description: const Text(
                                "The password has been modified. Click on 'Return' to return to the homepage"),
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
                          'UPDATE PASSWORD',
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
