import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:journey_planner/services/aes_encryption.dart';
import 'package:qr_flutter/qr_flutter.dart';

class UseTravelCardOrTicket extends StatefulWidget {
  const UseTravelCardOrTicket({Key? key}) : super(key: key);

  @override
  State<UseTravelCardOrTicket> createState() => _UseTravelCardOrTicketState();
}

final FirebaseAuth _auth = FirebaseAuth.instance;

String inputData() {
  final User? user = _auth.currentUser;
  final uid = user!.uid;
  return uid;
}

class _UseTravelCardOrTicketState extends State<UseTravelCardOrTicket> {
  AESEncryption encryption = new AESEncryption();
  final document = FirebaseFirestore.instance
      .collection('users')
      .doc(inputData())
      .collection('ticket')
      .doc();

  @override
  Widget build(BuildContext context) {
    inspect(document.id);
    inspect(encryption.encryptDocID(document.id).base16);
    inspect(encryption
        .decryptDocID(
            encryption.getCode(encryption.encryptDocID(document.id).base16))
        .toString());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[400],
        elevation: 0.0,
        title: const Text('Use Travel Card or Ticket'),
      ),
      body: Center(
        child: Column(
          children: [
            // Encrypted QR code
            QrImage(
              data: encryption.encryptDocID(document.id).base16,
              version: QrVersions.auto,
              size: 250.0,
            ),

            // Decrypted QR Code
            QrImage(
              data: encryption
                  .decryptDocID(encryption
                      .getCode(encryption.encryptDocID(document.id).base16))
                  .toString(),
              version: QrVersions.auto,
              size: 250.0,
            ),
          ],
        ),
      ),
    );
  }
}
