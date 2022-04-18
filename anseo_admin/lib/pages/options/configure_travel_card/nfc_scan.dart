/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: nfc_scan.dart
  Description: This file allows the admin to configure the travel card to the selected type chosen in configure_travel_cards.dart 
               by writing the travel card type on to the travel card via NFC. Once configured, the admin will be notified.
*/

// Imports utilised in this file
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:sweetsheet/sweetsheet.dart';

class NFCScan extends StatefulWidget {
  /* 
    This class takes in 1 parameters: 
    -The travel card type that we want to configure on to the travel card
  */
  final String travelCardType;

  const NFCScan(
    this.travelCardType, {
    Key? key,
  }) : super(key: key);

  @override
  State<NFCScan> createState() => _NFCScanState();
}

class _NFCScanState extends State<NFCScan> {
  // Instance of the flutter package 'sweetsheets', which allow us to create custom pop-up messages to the user
  final SweetSheet _sweetSheet = SweetSheet();

  @override
  Widget build(BuildContext context) {
    _ndefWrite();
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.deepPurple[300],
          centerTitle: true,
          elevation: 0.0,
          title: Text(
            'Configure Travel Card',
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
                  //   fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ));
  }

  /* 
    Function to write the travel card type on to the travel card. This is done so that 
    when a user wants to add a travel card to their account using Anseo Transit, they 
    would be able to link it to their account via firebase query
  */
  Future<void> _ndefWrite() async {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      /* 
        Instance of the class NDEF, which is part of the flutter package 
        'nfc_manager'. This allows us to access NDEF operations on the tag.
      */
      Ndef? ndef = Ndef.from(tag);

      // Format the travel card type to an NDEF Record
      NdefMessage message = NdefMessage([
        NdefRecord.createText(widget.travelCardType),
      ]);

      try {
        await ndef!.write(message);

        NfcManager.instance.stopSession();

        _sweetSheet.show(
          isDismissible: false,
          context: context,
          title: const Text("Travel Card Configured"),
          description: Text(
              "The Travel Card has been configured with the type '${widget.travelCardType}'. Click on 'Return' to return to the homepage"),
          color: SweetSheetColor.SUCCESS,
          icon: Icons.task_alt_sharp,
          positive: SweetSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            title: 'USE',
            icon: Icons.keyboard_return,
          ),
        );
      } catch (e) {
        NfcManager.instance.stopSession(errorMessage: e.toString());
        return;
      }
    });
  }
}
