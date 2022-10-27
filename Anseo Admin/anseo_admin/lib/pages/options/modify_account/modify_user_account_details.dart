/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: modify_user_account_details.dart
  Description: This file allows the admin to modify the personal information associated with a user account. 
               The admin will be able to edit the following personal information:
               
               - First Name
               - Last Name
               - Address Line 1 
               - Address Line 2 
               - City
               - County
               - Postcode
               - Phone Number

               Once validated, the inputted information will be updated on the users firebase document using a firebase query 
*/

// Imports utilised in this file
import 'dart:developer';

import 'package:anseo_admin/models/user.dart';
import 'package:anseo_admin/services/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sweetsheet/sweetsheet.dart';

class ModifyUserAccountDetails extends StatefulWidget {
  /* 
    This class takes in 1 parameters: 
    -The account whose personal information we are about to modify.
  */
  final UserAccount account;
  const ModifyUserAccountDetails(this.account, {Key? key}) : super(key: key);

  @override
  State<ModifyUserAccountDetails> createState() => _ModifyAccountDetailsState();
}

class _ModifyAccountDetailsState extends State<ModifyUserAccountDetails> {
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
    final _addressline1Controller = TextEditingController();
    final _addressline2Controller = TextEditingController();
    final _cityController = TextEditingController();
    final _countyController = TextEditingController();
    final _postcodeController = TextEditingController();
    final _phoneNumberController = TextEditingController();

    _firstNameController.text = widget.account.firstName;
    _lastNameController.text = widget.account.lastName;
    _addressline1Controller.text = widget.account.addressline1;
    _addressline2Controller.text = widget.account.addressline2;
    _cityController.text = widget.account.city;
    _countyController.text = widget.account.county;
    _postcodeController.text = widget.account.postcode;
    _phoneNumberController.text = widget.account.phoneNumber;

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
          'Modify User Account',
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
                                    controller: _firstNameController,
                                    validator: (val) => val!.isEmpty
                                        ? 'Enter a first name'
                                        : null,
                                    // onChanged: (val) {
                                    //   setState(() => firstName = true);
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
                                    controller: _lastNameController,
                                    validator: (val) => val!.isEmpty
                                        ? 'Enter a last name'
                                        : null,
                                    // onChanged: (val) {
                                    //   setState(() => lastName = true);
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
                              controller: _phoneNumberController,
                              validator: (val) =>
                                  val!.isEmpty ? 'Enter a phone number' : null,
                              // onChanged: (val) {
                              //   setState(() => phoneNumber = true);
                              // },
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
                              controller: _addressline1Controller,
                              validator: (val) => val!.isEmpty
                                  ? 'Enter an address line 1'
                                  : null,
                              // onChanged: (val) {
                              //   setState(() => addressline1 = true);
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
                              controller: _addressline2Controller,
                              validator: (val) => val!.isEmpty
                                  ? 'Enter an address line 2'
                                  : null,
                              // onChanged: (val) {
                              //   setState(() => addressline2 = true);
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
                              controller: _cityController,
                              validator: (val) =>
                                  val!.isEmpty ? 'Enter a city' : null,
                              // onChanged: (val) {
                              //   setState(() => city = true);
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
                                    controller: _countyController,
                                    validator: (val) =>
                                        val!.isEmpty ? 'Enter a county' : null,
                                    // onChanged: (val) {
                                    //   setState(() => county = true);
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
                                    controller: _postcodeController,
                                    validator: (val) => val!.isEmpty
                                        ? 'Enter a postcode'
                                        : null,
                                    // onChanged: (val) {
                                    //   setState(() => postcode = true);
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
                        await _dbAuth.updateUserPersonalInformation(
                            widget.account.userID,
                            _firstNameController.text,
                            _lastNameController.text,
                            _addressline1Controller.text,
                            _addressline2Controller.text,
                            _cityController.text,
                            _countyController.text,
                            _postcodeController.text,
                            _phoneNumberController.text);

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
