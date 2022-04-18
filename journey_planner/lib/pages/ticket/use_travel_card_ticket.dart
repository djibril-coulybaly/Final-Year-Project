/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: use_travel_card_ticket.dart
  Description: This file allows the user to use their travel card or ticket in a QR Code format.
               The QR code will then be validated by Anseo Validator and processed as a transaction
*/

// Imports utilised in this file
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_planner/services/aes_encryption.dart';
import 'package:qr_flutter/qr_flutter.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:journey_planner/services/firebase_database.dart';

class UseTravelCardOrTicket extends StatefulWidget {
  /* 
    This class takes in 3 parameters: 
    - The User ID
    - The ID of the ticket/travel card 
    - Whether the payment was a ticket or a travel card
  */
  final String uid;
  final String document;
  final String ticketOrTravelCard;

  const UseTravelCardOrTicket(this.uid, this.document, this.ticketOrTravelCard,
      {Key? key})
      : super(key: key);

  @override
  State<UseTravelCardOrTicket> createState() => _UseTravelCardOrTicketState();
}

// final FirebaseAuth _auth = FirebaseAuth.instance;

// String inputData() {
//   final User? user = _auth.currentUser;
//   final uid = user!.uid;
//   return uid;
// }

class _UseTravelCardOrTicketState extends State<UseTravelCardOrTicket> {
  // Instance of the AES Encryption Class - allows us to encrypt the data that we want to add to the QR Code
  AESEncryption encryption = AESEncryption();
  // final FDB _dbAuth = FDB();
  // final document = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(inputData())
  //     .collection('ticket')
  //     .doc();

  @override
  Widget build(BuildContext context) {
    // Data to be encrypted in the QR Code
    String finalQRData =
        widget.uid + '/' + widget.ticketOrTravelCard + '/' + widget.document;

    /* Debugging the encrytion/decryption of the data */
    // inspect(finalQRData);
    // inspect(encryption.encryptDocID(finalQRData).base16);
    // inspect(encryption
    //     .decryptDocID(
    //         encryption.getCode(encryption.encryptDocID(finalQRData).base16))
    //     .toString());

    // _dbAuth.initUserTicket(
    // true, 2.5, DateTime.now(), "", 0, "", "", "Student", document);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        // backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(
          'Use Travel Card or Ticket',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            fontFamily: GoogleFonts.poppins().fontFamily,
            color: Colors.white,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        backgroundColor: Colors.deepPurple[300],
      ),
      body: Center(
        // Encrypted QR code
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // SizedBox(
            //   height: 150,
            // ),
            Text(
              "Scan the QR Code on the ticket validator onboard!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
                fontFamily: GoogleFonts.poppins().fontFamily,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              height: 30,
            ),

            // Creating a QR Code with the encrypted data
            QrImage(
              data: encryption.encryptDocID(finalQRData).base16,
              version: QrVersions.auto,
              size: 250.0,
            ),
          ],
        ),
      ),
    );
  }
}
