/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: add_travel_card.dart
  Description: This file presents the user with the option to add their physical travel card to their account
               For the reading and writing of NFC data, I used the flutter package 'nfc_manager'.
*/

// Imports utilised in this file
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_planner/config/extensions.dart';
import 'package:journey_planner/pages/ticket/use_travel_card_ticket.dart';
import 'package:journey_planner/services/aes_encryption.dart';
import 'package:journey_planner/services/firebase_database.dart';
import 'package:journey_planner/widgets/ndef_record.dart';
import 'package:sweetsheet/sweetsheet.dart';

import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';

class AddTravelCard extends StatefulWidget {
  const AddTravelCard({Key? key}) : super(key: key);

  @override
  State<AddTravelCard> createState() => _AddTravelCardState();
}

class _AddTravelCardState extends State<AddTravelCard> {
  // Instance of the AES Encryption Class - allows us to encrypt the data that we want to add to the QR Code
  AESEncryption encryption = AESEncryption();

  // Instance of the flutter package 'sweetsheets', which allow us to create custom pop-up messages to the user
  final SweetSheet _sweetSheet = SweetSheet();

  // Instance of the Firebase Authentication SDK
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    _ndefWrite();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Add Travel Card',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/stock_images/nfc.png',
              width: 300,
            ),
            const SizedBox(
              height: 100,
            ),
            const Text(
              'Hold your NFC Card near this device',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* 
    Function to analyse the configuration of the travel card, encrypt the user ID, write it to 
    the NFC card and create a new document to associate the card with the user's account
  */
  Future<void> _ndefWrite() async {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      final travelCardID = NfcA.from(tag)?.identifier.toHexString();
      final userID = _auth.currentUser!.uid;
      final finalNFCData = encryption.encryptDocID(userID).base16;
      Ndef? ndef = Ndef.from(tag);

      final record = ndef!.cachedMessage!.records[0];
      final info = NdefRecordInfo.fromNdef(record);
      final cardType = info.subtitle.replaceAll("(en) ", "");

      inspect(userID);
      inspect(finalNFCData);

      final FDB _dbAuth = FDB(uid: userID);

      NdefMessage message = NdefMessage([
        NdefRecord.createText(finalNFCData),
      ]);

      try {
        await ndef.write(message);

        await _dbAuth.initUserTravelCard(
            0, 0, 0, 0, 0, cardType, travelCardID!);

        NfcManager.instance.stopSession();

        _sweetSheet.show(
          isDismissible: false,
          context: context,
          title: const Text("Travel Card Added"),
          description: const Text(
              "Click on 'Use' to use the travel card or 'Return' to return to the homepage"),
          color: SweetSheetColor.SUCCESS,
          icon: Icons.task_alt_sharp,
          positive: SweetSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UseTravelCardOrTicket(
                      userID, travelCardID, "travel_card"),
                ),
              );
            },
            title: 'USE',
            icon: Icons.qr_code,
          ),
          negative: SweetSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            title: 'RETURN',
            icon: Icons.exit_to_app,
          ),
          // ),
        );
      } catch (e) {
        NfcManager.instance.stopSession(errorMessage: e.toString());
        return;
      }
    });
  }
}
