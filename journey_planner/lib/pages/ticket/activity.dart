/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: activity.dart
  Description: This file contains a searchable ListTile widget that will display a list of transactions that was made on the 
               travel card associated with the users account. Each transaction will contain the route name/number, fare amount
               date/time of transaction and the operator logo
*/

// Imports utilised in this file
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_planner/models/transactions.dart';
import 'package:journey_planner/models/travel_card.dart';
import 'package:journey_planner/widgets/colour_type.dart';
import 'package:intl/intl.dart';

// Instance of the Firebase Authentication SDK
final FirebaseAuth _auth = FirebaseAuth.instance;

class Activity extends StatefulWidget {
  final dynamic card;
  const Activity(this.card, {Key? key}) : super(key: key);

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  List<Transactions> _travelCardTransactionList = [];
  String _ticketOperatorName = '';
  double _ticketPrice = 0.0;
  DateTime _ticketDate = DateTime.now();
  String _ticketRoute = '';

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   getTravelCardTransactionsList(widget.card);
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTravelCardTransactionsList(widget.card);
  }

  @override
  Widget build(BuildContext context) {
    // inspect(_travelCardTransactionList);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Activity',
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
      body: SingleChildScrollView(
        child: Center(
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
                                widget.card is TravelCard
                                    ? "€${widget.card.balance}"
                                    : "€${widget.card.price}",
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
                                widget.card is TravelCard
                                    ? "${widget.card.travelCardID}"
                                    : "${widget.card.ticketID}",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            widget.card is TravelCard
                                ? const SizedBox.shrink()
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      widget.card.activated == true
                                          ? "Status: Valid"
                                          : "Status: Invalid",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
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
                const SizedBox(height: 30),

                /* 
                  If there's an activity associated with the travel card, then it it'll be displayed to the user. 
                  Otherwise the appropiate error message will be displayed 
                */
                (_travelCardTransactionList.isNotEmpty ||
                        (_ticketOperatorName.isNotEmpty))
                    ? Column(
                        children: [
                          widget.card is TravelCard
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: _travelCardTransactionList.length,
                                  itemBuilder: (context, index) {
                                    final route =
                                        _travelCardTransactionList[index];

                                    return ListTile(
                                      // Operator Logo
                                      leading: Image.asset(
                                        route.operatorLogo,
                                        fit: BoxFit.cover,
                                        width: 50,
                                        height: 50,
                                      ),
                                      // Route name
                                      title: Text("Route: ${route.route}"),
                                      // Fare amount
                                      subtitle:
                                          Text("Amount: €${route.amount}"),
                                      // Date and time of transaction
                                      trailing: Text(
                                          "${DateFormat('EEE d MMM\nkk:mm:ss').format(route.date)}"),
                                    );
                                  },
                                )
                              : ListTile(
                                  // Operator Logo
                                  leading: Image.asset(
                                    _ticketOperatorName,
                                    fit: BoxFit.cover,
                                    width: 50,
                                    height: 50,
                                  ),
                                  // Route name
                                  title: Text("Route: ${_ticketRoute}"),
                                  // Fare amount
                                  subtitle: Text("${_ticketPrice}"),
                                  // Date and time of transaction
                                  trailing: Text(
                                      "${DateFormat('EEE d MMM\nkk:mm:ss').format(_ticketDate)}"),
                                )
                        ],
                      )
                    : Text(
                        'No transactions associated with this travel card!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Colors.black,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /* 
    Function call to get the list of transactions associated with the travel card connected to the user account from the 
    firebase database
  */
  Future getTravelCardTransactionsList(card) async {
    final User? user = _auth.currentUser;
    final uid = user!.uid;

    if (card is TravelCard) {
// Firebase Query to get collection of transactions associated with the travel card connected to the user account
      var travelCardTransactions = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('travel_card')
          .doc(widget.card.travelCardID)
          .collection('transactions')
          .get();

      /*
      Mapping the data from the Firebase Database to a list with a Transactions Class Model
      setState() is called at the end to ensure all the changes are relected on the screen.
    */
      setState(() {
        _travelCardTransactionList = List.from(travelCardTransactions.docs
            .map((doc) => Transactions.fromSnapshot(doc)));
      });
    } else {
      // Firebase Query to get transaction fields associated with the ticket connected to the user account
      var ticketTransactions = await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('ticket')
          .doc(widget.card.ticketID)
          .get();

      // Assigning the correct field to io the correct variable 
      var ticketOperatorName = (ticketTransactions.data()!["operator"] ==
              "Dublin Bus")
          ? 'assets/dublinBusLogo.png'
          : (ticketTransactions.data()!["operator"] == "Go Ahead")
              ? 'assets/goAheadLogo.png'
              : (ticketTransactions.data()!["operator"] == "Iarnrod Eireann")
                  ? 'assets/iarnrodEireannLogo.png'
                  : (ticketTransactions.data()!["operator"] == "Luas")
                      ? 'assets/luasLogo.png'
                      : "";
      var ticketPrice = ticketTransactions.data()!["price"].toDouble();
      var ticketDate = ticketTransactions.data()!["date"].toDate();
      var ticketRoute = ticketTransactions.data()!["route"];

      setState(() {
        _ticketOperatorName = ticketOperatorName;
        _ticketPrice = ticketPrice;
        _ticketDate = ticketDate;
        _ticketRoute = ticketRoute;
      });
    }
  }
}
