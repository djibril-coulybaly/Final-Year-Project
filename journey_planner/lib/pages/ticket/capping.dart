/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: capping.dart
  Description: This was meant to be the capping section in which users can see the cap levels for each mode of transportation. 
               However due to time constraints, I wasnt able to develop it however it is a feature that I want to implement in the future
*/
// Imports utilised in this file
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_planner/widgets/colour_type.dart';

class Capping extends StatefulWidget {
  final dynamic card;
  const Capping(this.card, {Key? key}) : super(key: key);

  @override
  State<Capping> createState() => _CappingState();
}

class _CappingState extends State<Capping> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: Text(
          'Capping',
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
        child: Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: [
              // Displaying the Travel Card that the user wants to view the activity
              Card(
                // color: getColorType(card.type),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Container(
                  decoration: getColorType(widget.card.type),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Ticket/Travel Card + type and the Anseo logo
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Ticket/Travel Card + type
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${widget.card.type} ${widget.card.runtimeType}",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Anseo Logo
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0),
                                child: SizedBox.square(
                                  dimension: 50,
                                  child: Image.asset(
                                    "assets/logo/logo1.png",
                                    width: 75,
                                    height: 68,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      // Balance on Travel Card/Ticket
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Text(
                              "€${widget.card.balance}",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.w400,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60),

                      // ID of ticket/travel card
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${widget.card.travelCardID}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60),
              Text(
                'Balance Remaining:',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: Colors.black,
                ),
              ),
              Text(
                '€${widget.card.balance}',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w400,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 60),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}
