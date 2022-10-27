/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Validator
  File Name: display_transaction.dart
  Description: This file will display a successful transaction to the commuter and driver. 
               
               The following will be displayed as part of the confirmation message:
               - Date of Transaction
               - Operator 
               - Route Name/Number
               - Fare
               - Amount (in Euro/€)
               - The user ID
               - Travel Card/Ticket ID
*/

// Imports utilised in this file
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class DisplayTransaction extends StatefulWidget {
  /* 
    This class takes in 8 parameters: 
    - The user ID of the commuter 
    - Whether the payment was a ticket or a travel card
    - The Ticket/Travel Card ID
    - The date of the transaction
    - The selected fare that the commuter chose
    - The name of the operator 
    - The route that the driver is driving
  */
  final String uid;
  final String ticketOrTravelCard;
  final String docID;
  final double amount;
  final DateTime date;
  final String selectedFare;
  final String selectedOperator;
  final String selectedRoute;

  const DisplayTransaction(
      this.uid,
      this.ticketOrTravelCard,
      this.docID,
      this.amount,
      this.date,
      this.selectedFare,
      this.selectedOperator,
      this.selectedRoute,
      {Key? key})
      : super(key: key);

  @override
  State<DisplayTransaction> createState() => _DisplayTransactionState();
}

class _DisplayTransactionState extends State<DisplayTransaction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[300],
        appBar: AppBar(
          backgroundColor: Colors.deepPurple[300],
          elevation: 0.0,
          title: Text(
            'Scan QR Code',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w500,
              fontFamily: GoogleFonts.manrope().fontFamily,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 20.0,
                ),

                // Confirmation Text
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        "${widget.ticketOrTravelCard} Validated\nSuccessfully!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          fontFamily: GoogleFonts.manrope().fontFamily,
                          color: Colors.black,
                        ),
                      ),
                      Image.asset("assets/icons/verified.png")
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),

                // Display results of transaction
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // Date of Transaction
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Date: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "${DateFormat('EEE d MMM @ kk:mm:ss a').format(widget.date)}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Operator
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Operator: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "${widget.selectedOperator}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Route Name/Number
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Route: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Text(
                                "${widget.selectedRoute}",
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: GoogleFonts.manrope().fontFamily,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Fare
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Fare: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "${widget.selectedFare} ${widget.ticketOrTravelCard}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Amount (In Euro/€)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Amount: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "€${widget.amount}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // User ID
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "User ID: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              width: 180,
                              child: Text(
                                "${widget.uid}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: GoogleFonts.manrope().fontFamily,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Travel Card/Ticket ID
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "${widget.ticketOrTravelCard} ID: ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              "${widget.docID}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: GoogleFonts.manrope().fontFamily,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
