/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Validator
  File Name: nfc_scan.dart
  Description: This file will allow the commuter to scan their NFC travel card to process their transaction.
               They will be instructed to hold their NFC travel card behind the validator
               
               The data embedded within the NFC travle card will be decrypted, validated, and used to charging 
               the transaction to the commuters account.
               
               If the travel card has sufficient funds, the transaction will be executed and a confirmation 
               message approving of the transaction will be displayed. Otherwise an error message informing 
               the driver that the commuter doesn't have any money on the travel card will be displayed.
        
               The code for implementing the NFC scanner was found in the example folder of the package 'nfc_manager', which is being used in this project
               Link to GitHub: 
*/

// Imports utilised in this file
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nfc_manager/nfc_manager.dart';
import 'package:nfc_manager/platform_tags.dart';
import 'package:sweetsheet/sweetsheet.dart';
import 'package:validator/config/extensions.dart';
import 'package:validator/pages/display_transaction.dart';
import 'package:validator/pages/ndef_record.dart';
import 'package:validator/services/aes_encryption.dart';
import 'package:validator/services/firebase_database.dart';

class NFCScan extends StatefulWidget {
  /* 
    This class takes in 3 parameters: 
    - The selected fare that the commuter chose
    - The name of the operator 
    - The route that the driver is driving
  */
  final String selectedFare;
  final String selectedOperator;
  final String selectedRoute;

  const NFCScan(
    this.selectedFare,
    this.selectedOperator,
    this.selectedRoute, {
    Key? key,
  }) : super(key: key);

  @override
  State<NFCScan> createState() => _NFCScanState();
}

class _NFCScanState extends State<NFCScan> {
  // Instance of the AES Encryption Class - allows us to decrypt the data that we want to obtain from the QR Code
  AESEncryption encryption = AESEncryption();

  // Instance of the flutter package 'sweetsheets', which allow us to create custom pop-up messages to the user
  final SweetSheet _sweetSheet = SweetSheet();

  @override
  Widget build(BuildContext context) {
    _tagRead();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[300],
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            'Scan NFC',
            style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w500,
                fontFamily: GoogleFonts.manrope().fontFamily,
                color: Colors.white),
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
              Text(
                'Hold your NFC Card near this device',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  // fontWeight: FontWeight.w400,
                  fontFamily: GoogleFonts.manrope().fontFamily,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ));
  }

  /*
    Function to scan, decrypt and validate the contents of the NFC travel card, and 
    proceed with charging the transaction to the user account
  */
  Future<void> _tagRead() async {
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      // ID of the Travel Card
      final travelCardID = NfcA.from(tag)?.identifier.toHexString();

      //Preparing the data from the travel card
      final record = Ndef.from(tag)!.cachedMessage!.records[0];
      final info = NdefRecordInfo.fromNdef(record);
      final potentialData = info.subtitle.replaceAll("(en) ", "");

      // Decrypting the User ID
      final decryptedNFCData =
          encryption.decryptDocID(encryption.getCode(potentialData)).toString();

      final amount = (widget.selectedFare == "Child") ? 0.80 : 2.50;
      final date = DateTime.now();

      /* 
        Instance of the class FDB located in firebase_database.dart, allowing us to make CRUD 
        operations with the user data stored in Firebase 
      */
      final FDB _dbAuth = FDB();

      // Get the most recent data from the travel card via firebase query
      dynamic travelCardInfo =
          await _dbAuth.getUserTravelCardInfo(decryptedNFCData, travelCardID!);
      var travelCardBalance = travelCardInfo.data()!["balance"].toDouble();
      var travelCardBusCap = travelCardInfo.data()!["bus_cap"].toDouble();
      var travelCardMultiModeCap =
          travelCardInfo.data()!["multi_mode_cap"].toDouble();
      var travelCardTrainCap = travelCardInfo.data()!["train_cap"].toDouble();
      var travelCardTramCap = travelCardInfo.data()!["tram_cap"].toDouble();

      /*
          If the balance on the travel card is not €0.00, then we'll proceed to see if the commuter has reached 
          the cap limit on the specific mode of transportation or has reached the multi mode cap limit. 

          Note: The cap limit have been set as follows
                - Bus Cap = €10
                - Train Cap = €10
                - Tram Cap = €10
                - Multi Mode Cap = €20
          
          If they have reached the cap limit, then well proceed to create a new transaction with €0.00 being the amount
          charged, and update the capping information. Otherwise they will be charged with the amount specified at the 
          start of the transaction.

          If the balmpoance on the travel card is €0.00, then an error message will be displayed informing the driver that
          the commuter doesn't have any money on the travel card.
        */
      if (travelCardBalance != 0.0) {
        if (widget.selectedOperator == "Dublin Bus" ||
            widget.selectedOperator == "Go-Ahead") {
          if (travelCardBusCap >= 10 || travelCardMultiModeCap >= 20) {
            await _dbAuth.addTransactionToUserTravelCard(
                decryptedNFCData,
                travelCardID,
                0.0,
                widget.selectedOperator,
                widget.selectedRoute,
                date);

            await _dbAuth.updateCappingUserTravelCard(
                decryptedNFCData,
                travelCardID,
                0.0,
                widget.selectedOperator,
                widget.selectedRoute);

            NfcManager.instance.stopSession();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayTransaction(
                  decryptedNFCData,
                  "Travel Card",
                  travelCardID,
                  0.0,
                  date,
                  widget.selectedFare,
                  widget.selectedOperator,
                  widget.selectedRoute,
                ),
              ),
            );
          } else {
            await _dbAuth.addTransactionToUserTravelCard(
                decryptedNFCData,
                travelCardID,
                amount,
                widget.selectedOperator,
                widget.selectedRoute,
                date);

            await _dbAuth.updateCappingUserTravelCard(
                decryptedNFCData,
                travelCardID,
                amount,
                widget.selectedOperator,
                widget.selectedRoute);

            NfcManager.instance.stopSession();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayTransaction(
                  decryptedNFCData,
                  "Travel Card",
                  travelCardID,
                  amount,
                  date,
                  widget.selectedFare,
                  widget.selectedOperator,
                  widget.selectedRoute,
                ),
              ),
            );
          }
        } else if (widget.selectedOperator == "Iarnrod Eireann") {
          if (travelCardTrainCap >= 10 || travelCardMultiModeCap >= 20) {
            await _dbAuth.addTransactionToUserTravelCard(
                decryptedNFCData,
                travelCardID,
                0.0,
                widget.selectedOperator,
                widget.selectedRoute,
                date);

            await _dbAuth.updateCappingUserTravelCard(
                decryptedNFCData,
                travelCardID,
                0.0,
                widget.selectedOperator,
                widget.selectedRoute);

            NfcManager.instance.stopSession();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayTransaction(
                  decryptedNFCData,
                  "Travel Card",
                  travelCardID,
                  0.0,
                  date,
                  widget.selectedFare,
                  widget.selectedOperator,
                  widget.selectedRoute,
                ),
              ),
            );
          } else {
            await _dbAuth.addTransactionToUserTravelCard(
                decryptedNFCData,
                travelCardID,
                amount,
                widget.selectedOperator,
                widget.selectedRoute,
                date);

            await _dbAuth.updateCappingUserTravelCard(
                decryptedNFCData,
                travelCardID,
                amount,
                widget.selectedOperator,
                widget.selectedRoute);

            NfcManager.instance.stopSession();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayTransaction(
                  decryptedNFCData,
                  "Travel Card",
                  travelCardID,
                  amount,
                  date,
                  widget.selectedFare,
                  widget.selectedOperator,
                  widget.selectedRoute,
                ),
              ),
            );
          }
        } else if (widget.selectedOperator == "Luas") {
          if (travelCardTramCap >= 10 || travelCardMultiModeCap >= 20) {
            await _dbAuth.addTransactionToUserTravelCard(
                decryptedNFCData,
                travelCardID,
                0.0,
                widget.selectedOperator,
                widget.selectedRoute,
                date);

            await _dbAuth.updateCappingUserTravelCard(
                decryptedNFCData,
                travelCardID,
                0.0,
                widget.selectedOperator,
                widget.selectedRoute);

            NfcManager.instance.stopSession();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayTransaction(
                  decryptedNFCData,
                  "Travel Card",
                  travelCardID,
                  0.0,
                  date,
                  widget.selectedFare,
                  widget.selectedOperator,
                  widget.selectedRoute,
                ),
              ),
            );
          } else {
            await _dbAuth.addTransactionToUserTravelCard(
                decryptedNFCData,
                travelCardID,
                amount,
                widget.selectedOperator,
                widget.selectedRoute,
                date);

            await _dbAuth.updateCappingUserTravelCard(
                decryptedNFCData,
                travelCardID,
                amount,
                widget.selectedOperator,
                widget.selectedRoute);

            NfcManager.instance.stopSession();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayTransaction(
                  decryptedNFCData,
                  "Travel Card",
                  travelCardID,
                  amount,
                  date,
                  widget.selectedFare,
                  widget.selectedOperator,
                  widget.selectedRoute,
                ),
              ),
            );
          }
        }
      } else {
        _sweetSheet.show(
          isDismissible: false,
          context: context,
          title: const Text("No Money on Travel Card"),
          description: const Text(
              "There is no money left on the travel card! Please use another ticket or travel card."),
          color: SweetSheetColor.DANGER,
          icon: Icons.warning,
          positive: SweetSheetAction(
            onPressed: () async {
              Navigator.of(context).pop();
            },
            title: 'DELETE',
            icon: Icons.delete_forever,
          ),
        );
      }

      // await _dbAuth.addTransactionToUserTravelCard(
      //     decryptedNFCData,
      //     travelCardID,
      //     amount,
      //     widget.selectedOperator,
      //     widget.selectedRoute,
      //     date);

      // await _dbAuth.updateCappingUserTravelCard(decryptedNFCData, travelCardID,
      //     amount, widget.selectedOperator, widget.selectedRoute);

      //   NfcManager.instance.stopSession();

      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //         builder: (context) => DisplayTransaction(
      //             decryptedNFCData,
      //             "Travel Card",
      //             travelCardID!,
      //             amount,
      //             date,
      //             widget.selectedFare,
      //             widget.selectedOperator,
      //             widget.selectedRoute),
      //       ));
    });
  }
}
