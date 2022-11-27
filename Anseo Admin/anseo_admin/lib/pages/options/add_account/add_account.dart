/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: add_account.dart
  Description: This file allows the admin to select the type of account that they want to create.
               The admin can choose to add one of the following accounts from a dropdown list: 
               
               - User Account 
               - Driver Account
               - Admin Account
*/

// Imports utilised in this file
import 'package:anseo_admin/pages/options/add_account/add_account_details.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddAccount extends StatefulWidget {
  const AddAccount({Key? key}) : super(key: key);

  @override
  State<AddAccount> createState() => _AddAccountState();
}

class _AddAccountState extends State<AddAccount> {
  /*
    Initializing the variable used to select the account type in the dropdown list.
    Note: The value specified in this variable must be the first item declared in order
    for the dropdown list to work. 
  */
  String accountType = 'User';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Add Account',
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
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Select Account Type",
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

              // Dropdown list in which admin can choose to add a user account, driver account or admin account
              DropdownButton<String>(
                isExpanded: true,
                value: accountType,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    accountType = newValue!;
                  });
                },
                items: <String>['User', 'Driver', 'Admin']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
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
                    If the admin clicks on the button, they will be redirected to the Add Account Details page
                    (add_account_details.dart) with the account type passed as a parameter. This is done to show
                    the appropiate form based on the account type.
                  */
                  onPressed: () async {
                    if (accountType.isNotEmpty) {
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute<void>(
                      //     builder: (BuildContext context) => SelectOption(),
                      //     // WrapperForFirebase(),
                      //   ),
                      // );

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AddAccountDetails(accountType)));
                    } else {
                      // setState(() {
                      //   error = 'Please supply a valid email';
                      // });
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
                        'CONFIGURE',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
