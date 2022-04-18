/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: ticket_overview.dart
  Description: This file presents the user with the option to interact with the tickets and/or travel cards 
               associated with their account. The user will be able to accomplish the following:
               -Add a travel card or ticket to their account
               -Use a travel card or ticket associated with their account
               -Delete a travel card associated with their account
               -Top up a travel card associated with their account
               -View the remaining balance on their travel card
               -View the recent activity that has been made with the travel card associated with their account
               -View the capping level of each mode of transportation with their travel card

               For the circle indicator of the ticket/travel card display, I used the following 
               website as reference: https://medium.com/flutter-community/how-to-create-card-carousel-in-flutter-979bc8ecf19 
*/

// Imports utilised in this file
import 'dart:developer';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:journey_planner/models/ticket.dart';
import 'package:journey_planner/models/travel_card.dart';
import 'package:journey_planner/pages/ticket/activity.dart';
import 'package:journey_planner/pages/ticket/add_travel_card_ticket.dart';
import 'package:journey_planner/pages/ticket/balance.dart';
import 'package:journey_planner/pages/ticket/capping.dart';
import 'package:journey_planner/pages/ticket/top_up_travel_card.dart';
import 'package:journey_planner/pages/ticket/use_travel_card_ticket.dart';
import 'package:journey_planner/services/firebase_database.dart';
import 'package:journey_planner/widgets/colour_type.dart';
import 'package:sweetsheet/sweetsheet.dart';
import 'package:google_fonts/google_fonts.dart';

// Instance of the Firebase Authentication SDK
final FirebaseAuth _auth = FirebaseAuth.instance;

// Instance of the class FDB located in firebase_database.dart, allowing us to make CRUD operations with the user data stored in Firebase
final FDB _dbAuth = FDB(uid: _auth.currentUser!.uid);

// Instance of the flutter package 'sweetsheets', which allow us to create custom pop-up messages to the user
final SweetSheet _sweetSheet = SweetSheet();

// Initializing Variables
String _currentTicketID = "";
dynamic _currentTicketFare;

class TicketOverview extends StatefulWidget {
  const TicketOverview({Key? key}) : super(key: key);

  @override
  State<TicketOverview> createState() => _TicketOverviewState();
}

class _TicketOverviewState extends State<TicketOverview> {
  /* 
    Initialising the current index of the ticket or travel card that is being viewed, list of travel cards, 
    list of tickets, and a master list with both travel card and ticket list combined 
  */
  int _currentIndex = 0;
  List<Ticket> _ticketTravelCardList = [];
  List<TravelCard> _travelCardList = [];
  List _masterList = [];

/* 
  Function to map the number of travel cards/tickets to a circle indicator that will visually show the user how many
  travel cards/tickets are associated with the account.
*/
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    super.initState();

    /* 
      Function calls to get the list of travel cards/tickets associated with the account and to subsequently 
      update the list if a travel card/ticket has been added/deleted/modified from the account.  
      This is being called in the initState() functions so that the data can be loaded before the screen is shown
    */
    getUsersTicketTravelCardList();
    // ticketTravelCardUpdate();
  }

  @override
  Widget build(BuildContext context) {
    /* Debug Checks to test values */
    // inspect(_ticketTravelCardList);
    // _currentTicketID = _ticketTravelCardList[0].ticketID!;
    // inspect(_currentTicketID);
    // inspect(_travelCardList);
    inspect(_masterList);
    inspect(_currentTicketFare);
    // print(_ticketTravelCardList.runtimeType);

    return SafeArea(
      top: false,
      bottom: true,
      child: Navigator(
        onGenerateRoute: (RouteSettings settings) {
          return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              return Scaffold(
                extendBodyBehindAppBar: true,
                extendBody: true,
                resizeToAvoidBottomInset: false,
                appBar: AppBar(
                  backgroundColor: Colors.deepPurple[300],
                  centerTitle: true,
                  elevation: 0.0,
                  title: Text(
                    'Ticket Overview',
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
                ),
                body: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 95),
                      child: _masterList.isNotEmpty
                          ? Column(
                              children: [
                                // Carousel that will display the travel cards/tickets associated with the user account
                                CarouselSlider(
                                  options: CarouselOptions(
                                    height: 200.0,
                                    autoPlay: false,
                                    enableInfiniteScroll: false,
                                    aspectRatio: 2.0,
                                    onPageChanged: (index, reason) {
                                      setState(() {
                                        _currentIndex = index;
                                        _currentTicketID = getIDBasedOnListType(
                                            _masterList[index]);
                                        _currentTicketFare = _masterList[index];
                                      });
                                    },
                                  ),
                                  items: _masterList.map((card) {
                                    return Builder(
                                        builder: (BuildContext context) {
                                      return SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.30,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        // Displaying each ticket/travel card
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          child: Container(
                                            decoration: getColorType(card.type),
                                            child: Column(
                                              children: [
                                                // Ticket/Travel Card + type and the Anseo logo
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    // Ticket/Travel Card + type
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            "${card.type} ${card.runtimeType}",
                                                            textAlign:
                                                                TextAlign.left,
                                                            style: TextStyle(
                                                              fontSize: 18,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontFamily: GoogleFonts
                                                                      .poppins()
                                                                  .fontFamily,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),

                                                    // Anseo Logo
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0,
                                                                  right: 8.0),
                                                          child:
                                                              SizedBox.square(
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
                                                          const EdgeInsets.only(
                                                              left: 8.0,
                                                              right: 8.0),
                                                      child:
                                                          getBalanceBasedOnListType(
                                                              card),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 60),

                                                // ID of ticket/travel card and the activation status (Only applicable to Ticket)
                                                Row(
                                                  children: [
                                                    // ID of ticket/travel card
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child:
                                                          getTextIDBasedOnListType(
                                                              card),
                                                    ),

                                                    // Activation status (Only applicable to Ticket)
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child:
                                                          getActivatedBasedOnListType(
                                                              card),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                                  }).toList(),
                                ),

                                // Circle indicator for indicating which ticket/travel card is being viewed at the moment
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:
                                      map<Widget>(_masterList, (index, url) {
                                    return Container(
                                      width: 10.0,
                                      height: 10.0,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10.0, horizontal: 2.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: _currentIndex == index
                                            ? Colors.blueAccent
                                            : Colors.grey,
                                      ),
                                    );
                                  }),
                                ),

                                const SizedBox(height: 20),

                                // List of options that are available to the user in regards to the travel cards/tickets present on their account
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 24,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          /* 
                                            If the ticket is currently selected and if the user clicks on this option, they will be redirected to the 
                                            use travel card or ticket screen (use_travel_card_ticket.dart). The class takes the document id of the ticket
                                            from firebase as a parameter along with the string value 'Ticket' to generate a unique QR code. 
                                            
                                            If the travel card is currently selected however the above will occur, only that the document id of the travel 
                                            card and string value of 'Card' will be used instead
                                          */
                                          (_currentTicketFare is! Ticket)
                                              ? const UseCardTicketWidget(
                                                  "Card")
                                              : const UseCardTicketWidget(
                                                  "Ticket"),

                                          // Add Travel Card or Ticket
                                          const AddCardTicketWidget(),

                                          // View Activity relating to travel card
                                          const ActivityWidget(),
                                        ],
                                      ),
                                      const SizedBox(height: 18),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // View the remaining balance on their travel card
                                          (_currentTicketFare is! Ticket)
                                              ? const BalanceWidget()
                                              : const SizedBox.shrink(),

                                          // Top up a travel card associated with their account
                                          (_currentTicketFare is! Ticket)
                                              ? const TopUpTravelCardWidget()
                                              : const SizedBox.shrink(),

                                          // View the capping level of each mode of transportation with their travel card
                                          (_currentTicketFare is! Ticket)
                                              ? const CappingWidget()
                                              : const SizedBox.shrink(),
                                        ],
                                      ),
                                      const SizedBox(height: 18),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          // Delete Travel Card
                                          (_currentTicketFare is! Ticket)
                                              ? const DeleteTravelCardWidget()
                                              : const SizedBox.shrink(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 50.0),
                              ],
                            )
                          : Center(
                              child: Container(
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    const SizedBox(height: 60),
                                    Text(
                                      'No Travel Card or Ticket associated with this account!',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w400,
                                        fontFamily:
                                            GoogleFonts.poppins().fontFamily,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Center(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),

                                        /* 
                                        If the user clicks on the button, they will be redirected to the add travel card or ticket page
                                        (add_travel_card_ticket.dart)
                                      */
                                        onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const AddTravelCardOrTicket()),
                                        ),
                                        child: Ink(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFF4158D0),
                                                Color(0xFFC850C0),
                                              ],
                                            ),
                                          ),
                                          child: Container(
                                            width: 300,
                                            height: 50,
                                            alignment: Alignment.center,
                                            child: Text(
                                              'Add Travel Card/Ticket',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 23,
                                                fontWeight: FontWeight.w400,
                                                fontFamily:
                                                    GoogleFonts.manrope()
                                                        .fontFamily,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 100.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  /* 
    Function call to get the list of travel cards and/or tickets associated with this account 
  */
  Future getUsersTicketTravelCardList() async {
    final User? user = _auth.currentUser;
    final uid = user!.uid;
    var ticketData = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('ticket')
        .get();

    var travelCardData = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('travel_card')
        .get();

    // inspect(ticketData);

    setState(() {
      _ticketTravelCardList =
          List.from(ticketData.docs.map((doc) => Ticket.fromSnapshot(doc)));
      _travelCardList = List.from(
          travelCardData.docs.map((doc) => TravelCard.fromSnapshot(doc)));
      _currentTicketID = _ticketTravelCardList[0].ticketID!;
      _masterList.addAll(_ticketTravelCardList);
      _masterList.addAll(_travelCardList);
      _currentTicketFare = _masterList[0];
    });

    // inspect(_ticketTravelCardList);
  }

  /* 
    Function call to recieve a snapshots of any chsnges made to the travel card/ticket present 
  */
  Future ticketTravelCardUpdate() async {
    final User? user = _auth.currentUser;
    final uid = user!.uid;

    // Stream<QuerySnapshot<Map<String, dynamic>>> ticketStream =
    //     FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(uid)
    //     .collection('ticket')
    //     .snapshots();

    // Stream<QuerySnapshot<Map<String, dynamic>>> travelCardStream =
    //     FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(uid)
    //     .collection('travel_card')
    //     .snapshots();

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('ticket')
        .get()
        .then(
          (QuerySnapshot querySnapshot) => setState(
            () {
              _ticketTravelCardList = List.from(
                  querySnapshot.docs.map((doc) => Ticket.fromSnapshot(doc)));
              _masterList.addAll(_ticketTravelCardList);
            },
          ),
        );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('travel_card')
        .get()
        .then(
          (QuerySnapshot querySnapshot) => setState(
            () {
              _travelCardList = List.from(querySnapshot.docs
                  .map((doc) => TravelCard.fromSnapshot(doc)));
              _masterList.addAll(_travelCardList);
            },
          ),
        );
  }

  /* 
    Function call to get the ID based on whether it is a travel card or a ticket 
  */
  getTextIDBasedOnListType(dynamic card) {
    if (card is Ticket) {
      return Text(
        "${card.ticketID}",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: GoogleFonts.poppins().fontFamily,
          color: Colors.white,
        ),
      );
    } else {
      return Text(
        "${card.travelCardID}",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          fontFamily: GoogleFonts.poppins().fontFamily,
          color: Colors.white,
        ),
      );
    }
  }

  /* 
    Function call to get the balance based on whether it is a travel card or a ticket 
  */
  getBalanceBasedOnListType(dynamic card) {
    if (card is Ticket) {
      return Text(
        "€${card.amount}",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w400,
          fontFamily: GoogleFonts.poppins().fontFamily,
          color: Colors.white,
        ),
      );
    } else {
      return Text(
        "€${card.balance}",
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w400,
          fontFamily: GoogleFonts.poppins().fontFamily,
          color: Colors.white,
        ),
      );
    }
  }

  /* 
    Function call to get the activation status of the ticket
  */
  getActivatedBasedOnListType(dynamic card) {
    if (card is Ticket) {
      if (card.activated == true) {
        return Text(
          "Status: Valid",
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w400,
            fontFamily: GoogleFonts.poppins().fontFamily,
            color: Colors.white,
          ),
        );
      } else {
        return Text(
          "Status: Invalid",
          style: TextStyle(
            fontSize: 13.5,
            fontWeight: FontWeight.w400,
            fontFamily: GoogleFonts.poppins().fontFamily,
            color: Colors.white,
          ),
        );
      }
    } else {
      return const SizedBox.shrink();
    }
  }

  /* 
    Function call to get the current ID of the travel card/ticket selected based on whether it is a travel card or a ticket 
  */
  getIDBasedOnListType(dynamic card) {
    if (card is Ticket) {
      return card.ticketID;
    } else {
      return card.travelCardID;
    }
  }
}

// Class to display the Capping Button
class CappingWidget extends StatelessWidget {
  const CappingWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            height: 90,
            width: 90,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: Image.asset(
                      'assets/icons/capping.png',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Capping',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: GoogleFonts.poppins().fontFamily,
              color: Colors.black,
            ),
          ),
        ],
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Capping(_currentTicketFare)),
      ),
    );
  }
}

// Class to display the Balance Button
class BalanceWidget extends StatelessWidget {
  const BalanceWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            height: 90,
            width: 90,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: Image.asset(
                      'assets/icons/balance.png',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Balance',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: GoogleFonts.poppins().fontFamily,
              color: Colors.black,
            ),
          ),
        ],
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Balance(_currentTicketFare)),
      ),
    );
  }
}

// Class to display the Activity Button
class ActivityWidget extends StatelessWidget {
  const ActivityWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            height: 90,
            width: 90,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: Image.asset(
                      'assets/icons/activity.png',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Activity',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: GoogleFonts.poppins().fontFamily,
              color: Colors.black,
            ),
          ),
        ],
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Activity(_currentTicketFare)),
      ),
    );
  }
}

// Class to display the Top Up Button
class TopUpTravelCardWidget extends StatelessWidget {
  const TopUpTravelCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            height: 90,
            width: 90,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: Image.asset(
                      'assets/icons/top_up.png',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Top Up',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: GoogleFonts.poppins().fontFamily,
              color: Colors.black,
            ),
          ),
        ],
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TopUpTravelCard(_currentTicketFare)),
      ),
    );
  }
}

// Class to display the Delete Button
class DeleteTravelCardWidget extends StatelessWidget {
  const DeleteTravelCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            height: 90,
            width: 90,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: Image.asset(
                      'assets/icons/delete.png',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Delete',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: GoogleFonts.poppins().fontFamily,
              color: Colors.black,
            ),
          ),
        ],
      ),
      onTap: () => _sweetSheet.show(
        isDismissible: false,
        context: context,
        title: const Text("Delete Travel Card"),
        description:
            const Text("This action is irreversible. Do you wish to proceed?"),
        color: SweetSheetColor.DANGER,
        icon: Icons.warning,
        positive: SweetSheetAction(
          onPressed: () async {
            Navigator.of(context).pop();
            await _dbAuth.deleteUserTravelCard(_currentTicketFare.travelCardID);
          },
          title: 'DELETE',
          icon: Icons.delete_forever,
        ),
        negative: SweetSheetAction(
            onPressed: () {
              Navigator.of(context).pop();
            },
            title: 'CANCEL',
            icon: Icons.arrow_back),
        // ),
      ),
    );
  }
}

// Class to display the Add Button
class AddCardTicketWidget extends StatelessWidget {
  const AddCardTicketWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            height: 90,
            width: 90,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 45,
                  width: 45,
                  child: Image.asset(
                    'assets/icons/add.png',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Add',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: GoogleFonts.poppins().fontFamily,
              color: Colors.black,
            ),
          ),
        ],
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AddTravelCardOrTicket()),
      ),
    );
  }
}

// Class to display the Use Button
class UseCardTicketWidget extends StatelessWidget {
  final String type;
  const UseCardTicketWidget(
    this.type, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Container(
            height: 90,
            width: 90,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 45,
                    width: 45,
                    child: Image.asset(
                      'assets/icons/use.png',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            'Use ${type}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontFamily: GoogleFonts.poppins().fontFamily,
              color: Colors.black,
            ),
          ),
        ],
      ),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => (_currentTicketFare is Ticket)
                ? UseTravelCardOrTicket(
                    _auth.currentUser!.uid, _currentTicketID, "ticket")
                : UseTravelCardOrTicket(
                    _auth.currentUser!.uid, _currentTicketID, "travel_card")),
      ),
    );
  }
}
