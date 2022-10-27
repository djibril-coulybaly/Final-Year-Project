/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: modify_driver_account_details.dart
  Description: This file allows the admin to modify the personal information associated with a driver account. 
               The admin will be able to edit the following personal information:
               
               - First Name
               - Last Name
               - Operator

               Once validated, the inputted information will be updated on the drivers firebase document using a firebase query 
*/

// Imports utilised in this file
import 'dart:developer';

import 'package:anseo_admin/models/driver.dart';
import 'package:anseo_admin/services/firebase_auth.dart';
import 'package:anseo_admin/services/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweetsheet/sweetsheet.dart';

class ModifyDriverAccountDetails extends StatefulWidget {
  /* 
    This class takes in 1 parameters: 
    -The account whose personal information we are about to modify.
  */
  final Driver account;
  const ModifyDriverAccountDetails(this.account, {Key? key}) : super(key: key);

  @override
  State<ModifyDriverAccountDetails> createState() =>
      _ModifyDriverAccountDetailsState();
}

class _ModifyDriverAccountDetailsState
    extends State<ModifyDriverAccountDetails> {
  // A global key that assists us in validating the sign in form
  final _formKey = GlobalKey<FormState>();

  // Instance of the class FDB located in firebase_database.dart, allowing us to make CRUD operations with the user data stored in Firebase
  final FDB _dbAuth = FDB();

  // Instance of the flutter package 'sweetsheets', which allow us to create custom pop-up messages to the user
  final SweetSheet _sweetSheet = SweetSheet();

  @override
  Widget build(BuildContext context) {
    /* 
      Text field state within the form. Using TextEditingController to 
      keep track of changes when editing
    */
    String error = '';
    final _firstNameController = TextEditingController();
    final _lastNameController = TextEditingController();
    // final _emailController = TextEditingController();
    // final _operatorNameController = TextEditingController();

    _firstNameController.text = widget.account.firstName;
    _lastNameController.text = widget.account.lastName;
    // _emailController.text = widget.account.emailAddress;
    // _operatorNameController.text = widget.account.operatorName;

    String operatorName = widget.account.operatorName;

    // bool firstName = false;
    // bool lastName = false;
    // bool addressline1 = false;
    // bool addressline2 = false;
    // bool city = false;
    // bool county = false;
    // bool postcode = false;
    // bool phoneNumber = false;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Modify Driver Account',
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
                                    controller: _firstNameController,
                                    validator: (val) => val!.isEmpty
                                        ? 'Enter a first name'
                                        : null,
                                    // onChanged: (val) {
                                    //   setState(() => firstName = val);
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
                                    controller: _lastNameController,
                                    validator: (val) => val!.isEmpty
                                        ? 'Enter a last name'
                                        : null,
                                    // onChanged: (val) {
                                    //   setState(() => lastName = val);
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
                          ),
                        ],
                      ),
                      /* Input Operator Name */
                      const SizedBox(height: 20.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            "Select Operator",
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
                          DropdownButton<String>(
                            value: operatorName,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? newValue) {
                              setState(() {
                                operatorName = newValue!;
                              });
                            },
                            items: <String>[
                              'Dublin Bus',
                              'Go Ahead',
                              'Iarnrod Eireann',
                              'Luas'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
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
                      personal information using firebase queries.
                    */
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _dbAuth.updateDriverPersonalInformation(
                            widget.account.driverID,
                            _firstNameController.text,
                            _lastNameController.text,
                            operatorName);

                        _sweetSheet.show(
                          isDismissible: false,
                          context: context,
                          title: const Text("Account Modified!"),
                          description: const Text(
                              "The personal information has been modified sucessfully. Click on 'Return' to return to the homepage"),
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
                          'UPDATE ACCOUNT',
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
