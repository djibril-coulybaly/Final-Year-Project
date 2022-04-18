/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: available_seats.dart
  Description: This file contains a Scaffold widget that will display a seating arrangement of a fleet
               with the colours of the seats indicating whether it is available to sit (Green) on or not (Red)
*/

// Imports utilised in this file
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_planner/services/firebase_database.dart';

/*
  Initializing variables used for displaying the seating arrangement.
  Note: 1 indicates that a seat is available and 2 indicates that a seat
  is unavailable. 
*/
int spacing = 1;
int seat1 = 1;
int seat2 = 1;
int seat3 = 1;
int seat4 = 1;

// Initialising the display for the seating arrangement on board a fleet
var _seatStatus = [
  [seat1, seat2, spacing, spacing, seat3, seat4, spacing],
  [seat4, seat3, spacing, spacing, seat4, seat1, spacing],
  [seat3, seat4, spacing, spacing, seat1, seat2, spacing],
  [seat2, seat1, spacing, spacing, seat2, seat1, spacing],
  [seat2, seat3, spacing, spacing, seat1, seat3, spacing],
  [seat4, seat4, spacing, spacing, seat2, seat1, spacing],
  [seat2, seat1, spacing, spacing, seat4, seat3, spacing],
  [seat4, seat4, spacing, spacing, seat1, seat2, spacing],
  [seat1, seat2, spacing, spacing, seat3, seat3, spacing],
];

// Instance of the class FAS located in firebase_auth.dart, allowing us to authenticate the user with Firebase
final FirebaseAuth _auth = FirebaseAuth.instance;

// Instance of the class FDB located in firebase_database.dart, allowing us to make CRUD operations with the user data stored in Firebase
final FDB _dbAuth = FDB(uid: _auth.currentUser!.uid);

class AvailableSeats extends StatefulWidget {
  const AvailableSeats({Key? key}) : super(key: key);

  @override
  State<AvailableSeats> createState() => _AvailableSeatsState();
}

class _AvailableSeatsState extends State<AvailableSeats> {
  @override
  void initState() {
    super.initState();
    /* 
      Function call to get a snapshot of the available and unavailbale seats stored in the firebase database. 
      This is being called in the initState() functions so that the data can be loaded before the screen is shown
    */
    getAvailableSeatsList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Available Seats',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            fontFamily: GoogleFonts.poppins().fontFamily,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple[300],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SafeArea(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 40),

                  /* 
                    Displaying information about what the colours of the seats mean.
                    Note: Green: Available and Red: Unavilable
                  */
                  Container(
                    // Styling the Container
                    decoration: BoxDecoration(
                        color: Colors.deepPurple[300],
                        borderRadius: BorderRadius.circular(35),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: const Offset(0, 10),
                          ),
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Green',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                color: Colors.green,
                              ),
                            ),
                            Text(
                              '=',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Available',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Red',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              '=',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Unavailable',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),

                  // Using a loop to diplay the seats in a table fashion
                  for (int i = 0; i < 9; i++)
                    Container(
                      margin: EdgeInsets.only(top: i == 0 ? 50 : 0),
                      child: Row(
                        children: <Widget>[
                          for (int x = 1; x < 7; x++)
                            Expanded(
                              child: (x == 3) || (x == 4)
                                  ? Container()
                                  : Container(
                                      margin: const EdgeInsets.all(5),
                                      /* 
                                        If the seat is free, we will style it appropiatly with the availableSeat() function,
                                        which takes the row and column that the seat is located. Otherwise we will style it 
                                        with the unavailableSeat() function
                                      */
                                      child: _seatStatus[i][x - 1] == 1
                                          ? availableSeat(i, x - 1)
                                          : unavailableSeat(),
                                    ),
                            ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /*
    Function that gets a snapshot of the available and unavailbale seats stored in the firebase database.
 */
  Future getAvailableSeatsList() async {
    // Query to get snapshot from database
    Stream<DocumentSnapshot<Map<String, dynamic>>> streamNumbers =
        FirebaseFirestore.instance
            .collection('available_seats')
            .doc("vehicle1")
            .snapshots();

    /* 
      Listener to check if the the following field in the firebase database has changed as a result of someone
      sitting up/sitting down on a seat. If it has, it'll store the new value in the appropiate seat variable 
      and save it to the seating arrangement. setState() is called at the end to ensure all the changes are 
      relected on the screen. 
    */
    streamNumbers.listen((snapshot) {
      seat1 = snapshot.data()!["seat1"] == false ? 1 : 2;
      seat2 = snapshot.data()!["seat2"] == false ? 1 : 2;
      seat3 = snapshot.data()!["seat3"] == false ? 1 : 2;
      seat4 = snapshot.data()!["seat4"] == false ? 1 : 2;

      _seatStatus = [
        [seat1, seat2, spacing, spacing, seat3, seat4, spacing],
        [seat4, seat3, spacing, spacing, seat4, seat1, spacing],
        [seat3, seat4, spacing, spacing, seat1, seat2, spacing],
        [seat2, seat1, spacing, spacing, seat2, seat1, spacing],
        [seat2, seat3, spacing, spacing, seat1, seat3, spacing],
        [seat4, seat4, spacing, spacing, seat2, seat1, spacing],
        [seat2, seat1, spacing, spacing, seat4, seat3, spacing],
        [seat4, seat4, spacing, spacing, seat1, seat2, spacing],
        [seat1, seat2, spacing, spacing, seat3, seat3, spacing],
      ];

      setState(() {});
    });
  }

  /* 
    Function that will return a container with the appropiate stying for  
    an unavailable seat
  */
  unavailableSeat() {
    return InkWell(
      child: Container(
        height: 40.0,
        width: 10.0,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(3.0),
        ),
      ),
    );
  }

  /* 
    Function that will return a container with the appropiate stying for  
    an available seat
  */
  availableSeat(int a, int b) {
    _seatStatus[a][b] = 1;
    setState(() {});

    return InkWell(
      child: Container(
        height: 40.0,
        width: 10.0,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(3.0),
        ),
      ),
    );
  }
}
