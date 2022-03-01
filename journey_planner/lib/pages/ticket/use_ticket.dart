import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:journey_planner/services/aes_encryption.dart';
// import 'package:journey_planner/services/firebase_database.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UseTicket extends StatefulWidget {
  final String uid;
  final String document;

  const UseTicket(this.uid, this.document, {Key? key}) : super(key: key);

  @override
  State<UseTicket> createState() => _UseTicketState();
}

// final FirebaseAuth _auth = FirebaseAuth.instance;

// String inputData() {
//   final User? user = _auth.currentUser;
//   final uid = user!.uid;
//   return uid;
// }

class _UseTicketState extends State<UseTicket> {
  AESEncryption encryption = new AESEncryption();
  // final FDB _dbAuth = FDB();
  // final document = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(inputData())
  //     .collection('ticket')
  //     .doc();

  @override
  Widget build(BuildContext context) {
    String finalQRData = widget.uid + '/' + widget.document;

    inspect(finalQRData);
    inspect(encryption.encryptDocID(finalQRData).base16);
    inspect(encryption
        .decryptDocID(
            encryption.getCode(encryption.encryptDocID(finalQRData).base16))
        .toString());

    // _dbAuth.initUserTicket(
    // true, 2.5, DateTime.now(), "", 0, "", "", "Student", document);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[400],
        elevation: 0.0,
        title: const Text('Use Travel Card or Ticket'),
      ),
      body: Center(
        // Encrypted QR code
        child: QrImage(
          data: encryption.encryptDocID(finalQRData).base16,
          version: QrVersions.auto,
          size: 250.0,
        ),
      ),
    );
  }
}
