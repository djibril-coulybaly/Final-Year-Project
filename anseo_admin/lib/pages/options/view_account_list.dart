/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: view_account_list.dart
  Description: This file allows the admin to select the specific account from a list of accounts populated 
               previously and either delete or modify it. The option to modify or delete an account has 
               already been made in either modify_account.dart or delete_account.dart and has been passed 
               to this class via a boolean variable named 'toDeleteAccount'.

               The list of accounts will display the following information for each account: 
               
               - First Name
               - Last Name
               - Email
               - ID

               Once an account has been selected, they will be redirected to either the 
               Select Information To Modify page (select_information_to_modify.dart), 
               where the admin can select whether they want to modify the email, password 
               or personal information pertaining to the account, or be presented with a 
               dialog to confirm or reject the deletion of the account in question.
*/

// Imports utilised in this file
import 'dart:convert';
import 'dart:developer';

import 'package:anseo_admin/pages/options/modify_account/select_information_to_modify.dart';
import 'package:anseo_admin/services/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:sweetsheet/sweetsheet.dart';

class ViewAccountList extends StatefulWidget {
  /* 
    This class takes in 3 parameters: 
    - The list of account we want to display to the admin
    - The type of account that the admin is trying to modify/delete
    - Boolean variable to determine if the selection of an account 
      indicates that it needs to be modified or deleted 
  */
  final List<dynamic> accountList;
  final String accountType;
  final bool toDeleteAccount;

  const ViewAccountList(
      this.accountList, this.accountType, this.toDeleteAccount,
      {Key? key})
      : super(key: key);

  @override
  State<ViewAccountList> createState() => _ViewAccountListState();
}

class _ViewAccountListState extends State<ViewAccountList> {
  // Instance of the class FDB located in firebase_database.dart, allowing us to make CRUD operations with the user data stored in Firebase
  final FDB _dbAuth = FDB();

  // Instance of the flutter package 'sweetsheets', which allow us to create custom pop-up messages to the user
  final SweetSheet _sweetSheet = SweetSheet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: Text(
          'Select Account to ${widget.toDeleteAccount ? "Delete" : "Modify"}',
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
      body: Column(
        children: <Widget>[
          Expanded(
            // Displaying the list
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: widget.accountList.length,
              itemBuilder: (context, index) {
                final account = widget.accountList[index];

                return ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                  leading: Image.asset(
                    "assets/icons/account.png",
                    fit: BoxFit.cover,
                    width: 50,
                    height: 50,
                  ),
                  title: Text("${account.firstName} ${account.lastName}"),
                  subtitle: widget.accountType == "User"
                      ? Text(
                          "Email: ${account.emailAddress}\nID: ${account.userID}")
                      : widget.accountType == "Driver"
                          ? Text(
                              "Email: ${account.emailAddress}\nID: ${account.driverID}")
                          : widget.accountType == "Admin"
                              ? Text(
                                  "Email: ${account.emailAddress}\nID: ${account.adminID}")
                              : const SizedBox.shrink(),

                  /* 
                    If the account is to be deleted, the admin will be shown a prompt to confirm or reject the 
                    deletion of the account. The deletion of the account is done by cloud functions and the 
                    personal information is removed via firebase queries.

                    Otherwise the admin will be redirected to either the Select Information To Modify page 
                    (select_information_to_modify.dart), where the admin can select whether they want to 
                    modify the email, password or personal information pertaining to the account
                  */
                  onTap: () async {
                    if (widget.toDeleteAccount == true) {
                      _sweetSheet.show(
                        isDismissible: false,
                        context: context,
                        title: const Text("Delete Account!"),
                        description: const Text(
                            "Once completed, this action cannot be undone. Do you wish to proceed?"),
                        color: SweetSheetColor.DANGER,
                        icon: Icons.delete_outline,
                        positive: SweetSheetAction(
                          onPressed: () async {
                            Navigator.of(context).pop();

                            /* 
                              Deleting an account by making a call to a Firebase Cloud Function named 'deleteSpecificUser', 
                              which uses Firebase Auth to delete the account on the server side.
                            */
                            final response = await http.post(
                              Uri.parse(
                                  'https://us-central1-journey-planner-79eb0.cloudfunctions.net/deleteSpecificUser'),
                              body: {
                                'uid': widget.accountType == "User"
                                    ? account.userID
                                    : widget.accountType == "Driver"
                                        ? account.driverID
                                        : account.adminID
                              },
                            );

                            /*
                              If the account has been deleted successfully we will also proceed to delete the firebase document 
                              associated with the account. Otherwise an error messgae will be shown 
                            */
                            if (response.statusCode != 200) {
                              final jsonResponse = jsonDecode(response.body);

                              _sweetSheet.show(
                                isDismissible: false,
                                context: context,
                                title: const Text("Error!"),
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
                              widget.accountType == "User"
                                  ? await _dbAuth
                                      .deleteUserAccount(account.userID)
                                  : widget.accountType == "Driver"
                                      ? await _dbAuth
                                          .deleteDriverAccount(account.driverID)
                                      : await _dbAuth
                                          .deleteAdminAccount(account.adminID);

                              _sweetSheet.show(
                                isDismissible: false,
                                context: context,
                                title: const Text("Account Deleted!"),
                                description: Text(
                                    "The account with the ID '${widget.accountType == "User" ? account.userID : widget.accountType == "Driver" ? account.driverID : account.adminID}' has been deleted sucessfully. Click on 'Return' to return to the homepage"),
                                color: SweetSheetColor.SUCCESS,
                                icon: Icons.task_alt_sharp,
                                positive: SweetSheetAction(
                                  onPressed: () {
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
                          title: 'DELETE',
                          icon: Icons.delete_forever,
                        ),
                        negative: SweetSheetAction(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          title: 'RETURN',
                          icon: Icons.exit_to_app,
                        ),
                      );
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SelectInformationToModify(
                                  account, widget.accountType)));
                    }

                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) =>
                    //             ModifyUserAccountDetails(account)));
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
