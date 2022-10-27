/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: modify_account.dart
  Description: This file allows the admin to select the type of account that they want to modify.
               The admin can choose to modify one of the following accounts from a dropdown list: 
               
               - User Account 
               - Driver Account
               - Admin Account

               From here, they will be redirected to the View Account List page (view_account_list.dart)
               where the admin can specify the account to modify from a list of accounts with a specific 
               account type
*/

// Imports utilised in this file
import 'dart:developer';

import 'package:anseo_admin/models/admin.dart';
import 'package:anseo_admin/models/driver.dart';
import 'package:anseo_admin/models/user.dart';
import 'package:anseo_admin/pages/options/view_account_list.dart';
import 'package:anseo_admin/services/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ModifyAccount extends StatefulWidget {
  const ModifyAccount({Key? key}) : super(key: key);

  @override
  State<ModifyAccount> createState() => _ModifyAccountState();
}

class _ModifyAccountState extends State<ModifyAccount> {
  /*
    Initializing the variable used to select the account type in the dropdown list.
    Note: The value specified in this variable must be the first item declared in order
    for the dropdown list to work. 
  */
  String accountType = 'User';

  /*
    This variable is used to indicate to view_account_list.dart whether an account 
    from the list of accounts displayed will be deleted or modified. This was implemented 
    as both modify_account.dart and delete_account.dart have view_account_list.dart as a 
    commonality to display the list of accounts. In this instance the admin wants to modify 
    an account rather than delete, hense the variable is set to false 
  */
  bool toDeleteAccount = false;

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
          'Modify Account',
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

              // Dropdown list which the admin can select to modify a user account, driver account or admin account
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
                  onPressed: () async {
                    if (accountType.isNotEmpty) {
                      dynamic accountListQuery;

                      /* 
                        Depending on the account type, a list of accounts with the account type model is 
                        created and poplated using a query from firebase. This list, alongside the account
                        type and the variable 'toDeleteAccount' will be passed to the View Account List 
                        page (view_account_list.dart).

                      */
                      if (accountType == "User") {
                        // Creating list using the users model
                        List<UserAccount> accountList = [];

                        // Function call to get list of users
                        accountListQuery = await FDB().getUserList();

                        // inspect(accountListQuery);

                        // Mapping the firebase query results to the users model list
                        accountList = List.from(
                          accountListQuery.docs.map(
                            (doc) => UserAccount(
                              userID: doc.id,
                              emailAddress: doc.data()["email"],
                              firstName: doc.data()["first_name"],
                              lastName: doc.data()["last_name"],
                              addressline1: doc.data()["address_line_1"],
                              addressline2: doc.data()["address_line_2"],
                              city: doc.data()["city"],
                              county: doc.data()["county"],
                              postcode: doc.data()["postcode"],
                              phoneNumber: doc.data()["phone_number"],
                            ),
                          ),
                        );
                        inspect(accountList);

                        /* 
                          The admin will be redirected to the View Account List page (view_account_list.dart)
                          where the admin can specify the account to modify from the list created.
                        */
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewAccountList(
                                accountList, accountType, toDeleteAccount),
                          ),
                        );
                      } else if (accountType == "Driver") {
                        // Creating list using the driver model
                        List<Driver> accountList = [];

                        // Function call to get list of drivers
                        accountListQuery = await FDB().getDriverList();

                        // inspect(accountListQuery);

                        // Mapping the firebase query results to the driver model list
                        accountList = List.from(
                          accountListQuery.docs.map(
                            (doc) => Driver(
                              driverID: doc.id,
                              emailAddress: doc.data()["email"],
                              firstName: doc.data()["first_name"],
                              lastName: doc.data()["last_name"],
                              operatorName: doc.data()["operator"],
                            ),
                          ),
                        );

                        inspect(accountList);

                        /* 
                          The admin will be redirected to the View Account List page (view_account_list.dart)
                          where the admin can specify the account to modify from the list created.
                        */
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewAccountList(
                                accountList, accountType, toDeleteAccount),
                          ),
                        );
                      } else {
                        // Creating list using the admin model
                        List<Admin> accountList = [];

                        // Function call to get list of admins
                        accountListQuery = await FDB().getAdminList();
                        inspect(accountListQuery);

                        // Mapping the firebase query results to the account model list
                        accountList = List.from(
                          accountListQuery.docs.map(
                            (doc) => Admin(
                              adminID: doc.id,
                              emailAddress: doc.data()["email"],
                              firstName: doc.data()["first_name"],
                              lastName: doc.data()["last_name"],
                            ),
                          ),
                        );

                        inspect(accountList);

                        /* 
                          The admin will be redirected to the View Account List page (view_account_list.dart)
                          where the admin can specify the account to modify from the list created.
                        */
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewAccountList(
                                accountList, accountType, toDeleteAccount),
                          ),
                        );
                        // accountList
                      }
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
                        'VIEW ${accountType.toUpperCase()} LIST',
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
