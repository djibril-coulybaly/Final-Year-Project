/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: home.dart
  File Description: This is the file used to display the Home Dashboard. This includes links to the main features of the 
                    application such as 'Real Time Information', 'Ticket', 'Journey Planner', 'Available Seats' and 
                    'Account'(Concept Idea - not functional at the moment), a list of favourite stops added by 
                    the user (Concept Idea - not functional at the moment) and a section of quick links that will open a 
                    web browser within the application with the specified url available  
*/

// Imports utilised in this file
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_planner/models/user.dart';
import 'package:journey_planner/pages/firebase_wrapper.dart';
import 'package:journey_planner/pages/home/user_account.dart';
import 'package:journey_planner/services/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  final GlobalKey<CurvedNavigationBarState> bottomNavigationKey;
  const Home(this.bottomNavigationKey, {Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Instance of the class FAS located in firebase_auth.dart, allowing us to authenticate the user with Firebase
  final FAS _auth = FAS();

  // Function that takes a url as a parameter and attempts to open the url within the application
  // Code Source = https://medium.flutterdevs.com/explore-open-urls-in-flutter-4b6273884f13
  _launchURLApp(url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: true, forceWebView: true);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
            settings: settings,
            builder: (BuildContext context) {
              return Scaffold(
                extendBody: true,
                extendBodyBehindAppBar: true,
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: Text(
                    'Home Dashboard',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.deepPurple[300],
                  centerTitle: true,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                  iconTheme: const IconThemeData(color: Colors.white),
                  elevation: 0.0,
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.logout),

                      /*
                If the user clicks on the button, they will be signed out of the account and redirected to 'firebase_wrapper.dart',
                which will check to see if the usere is logged into the application. In this case the user is signed out and 
                therefore will be shown the walkthrough page.
              */
                      onPressed: () async {
                        await _auth.signOut();
                        Navigator.of(context, rootNavigator: true)
                            .pushReplacement(MaterialPageRoute(
                                builder: (context) =>
                                    new WrapperForFirebase()));
                        // Navigator.of(context).pushReplacement(
                        //   MaterialPageRoute<void>(
                        //     builder: (BuildContext context) =>
                        //         const WrapperForFirebase(),
                        //   ),
                        // );
                      },
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Center(
                    child: SafeArea(
                      child: Column(
                        children: [
                          // Spacing from appbar to welcome message
                          const SizedBox(height: 25.0),

                          // Welcome Message to User
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
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "Welcome Back,\n",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 25.0,
                                                fontFamily:
                                                    GoogleFonts.poppins()
                                                        .fontFamily,
                                                color: Colors.white,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "John Doe!",
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                fontFamily:
                                                    GoogleFonts.poppins()
                                                        .fontFamily,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),

                                      // Image Icon for User Account - Plan to replace it with an custom image thats uploaded by the user in the future
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(100)),
                                        child: Image.asset(
                                          "assets/icons/account.png",
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Displaying dashboard to user
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 25.0),

                              // Code for the 'Explore More' Section
                              Container(
                                // Styling the Container
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple[200],
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(35),
                                      bottomLeft: Radius.circular(35),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: const Offset(0, 10),
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Explore More Title
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20.0),
                                        child: Text(
                                          "Explore More",
                                          style: (TextStyle(
                                            fontSize: 25.0,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: GoogleFonts.poppins()
                                                .fontFamily,
                                            color: Colors.white,
                                          )),
                                        ),
                                      ),

                                      /* 
                                Row encapsulated within a SingleChildScrollView that allows the user to scroll 
                                through the available options in a horizontal manner 
                              */
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Real Time Information Button
                                              GestureDetector(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        // Styling the Container
                                                        height: 150,
                                                        width: 150,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(28),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 1,
                                                              blurRadius: 5,
                                                              offset:
                                                                  const Offset(
                                                                      0, 3),
                                                            ),
                                                          ],
                                                        ),

                                                        // Image Icon for Real Time Information
                                                        child: Center(
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 90,
                                                                width: 90,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/icons/real_time.png',
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      // Real Time Information Text
                                                      const SizedBox(
                                                          height: 12),
                                                      SizedBox(
                                                        width: 150,
                                                        child: Text(
                                                          'Real Time Information',
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 2,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .poppins()
                                                                    .fontFamily,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  // If the user clicks the button, they will be redirected to the Real Time Information Screen
                                                  onTap: () {
                                                    final CurvedNavigationBarState?
                                                        navigationBar = widget
                                                            .bottomNavigationKey
                                                            .currentState;
                                                    navigationBar!.setPage(0);
                                                  }),
                                              const SizedBox(width: 12),

                                              // Ticket Button
                                              GestureDetector(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        // Styling the Container
                                                        height: 150,
                                                        width: 150,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(28),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 1,
                                                              blurRadius: 5,
                                                              offset:
                                                                  const Offset(
                                                                      0, 3),
                                                            ),
                                                          ],
                                                        ),

                                                        // Image Icon for Ticket
                                                        child: Center(
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 90,
                                                                width: 90,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/icons/ticket.png',
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      // Ticket Text
                                                      const SizedBox(
                                                          height: 12),
                                                      SizedBox(
                                                        width: 150,
                                                        child: Text(
                                                          'Ticket',
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 5,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .poppins()
                                                                    .fontFamily,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  // If the user clicks the button, they will be redirected to the Ticket Screen
                                                  onTap: () {
                                                    final CurvedNavigationBarState?
                                                        navigationBar = widget
                                                            .bottomNavigationKey
                                                            .currentState;
                                                    navigationBar!.setPage(1);
                                                  }),
                                              const SizedBox(width: 12),

                                              // Journey Planner Button
                                              GestureDetector(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        // Styling the Container
                                                        height: 150,
                                                        width: 150,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(28),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 1,
                                                              blurRadius: 5,
                                                              offset:
                                                                  const Offset(
                                                                      0, 3),
                                                            ),
                                                          ],
                                                        ),

                                                        // Image Icon for Journey Planner
                                                        child: Center(
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 90,
                                                                width: 90,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/icons/journey_planner.png',
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      // Journey Planner Text
                                                      const SizedBox(
                                                          height: 12),
                                                      SizedBox(
                                                        width: 150,
                                                        child: Text(
                                                          'Journey Planner',
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 5,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .poppins()
                                                                    .fontFamily,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  onTap: () {
                                                    final CurvedNavigationBarState?
                                                        navigationBar = widget
                                                            .bottomNavigationKey
                                                            .currentState;
                                                    navigationBar!.setPage(3);
                                                  }),
                                              const SizedBox(width: 12),

                                              // Available Seats Button
                                              GestureDetector(
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 150,
                                                        width: 150,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(28),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(16),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.5),
                                                              spreadRadius: 1,
                                                              blurRadius: 5,
                                                              offset:
                                                                  const Offset(
                                                                      0, 3),
                                                            ),
                                                          ],
                                                        ),

                                                        // Image Icon for Available Seats
                                                        child: Center(
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 90,
                                                                width: 90,
                                                                child:
                                                                    Image.asset(
                                                                  'assets/icons/seat.png',
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),

                                                      // Available Seats Text
                                                      const SizedBox(
                                                          height: 12),
                                                      SizedBox(
                                                        width: 150,
                                                        child: Text(
                                                          'Available Seats',
                                                          textAlign:
                                                              TextAlign.center,
                                                          maxLines: 5,
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .poppins()
                                                                    .fontFamily,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  onTap: () {
                                                    final CurvedNavigationBarState?
                                                        navigationBar = widget
                                                            .bottomNavigationKey
                                                            .currentState;
                                                    navigationBar!.setPage(4);
                                                  }),
                                              const SizedBox(width: 12),

                                              // Account Button - Currently only a mockup of what I plan to improve in the future, not functional at the moment
                                              GestureDetector(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      // Styling the Container
                                                      height: 150,
                                                      width: 150,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              28),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 1,
                                                            blurRadius: 5,
                                                            offset:
                                                                const Offset(
                                                                    0, 3),
                                                          ),
                                                        ],
                                                      ),

                                                      // Image Icon for Account
                                                      child: Center(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 90,
                                                              width: 90,
                                                              child:
                                                                  Image.asset(
                                                                'assets/icons/account.png',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    // Account Text
                                                    const SizedBox(height: 12),
                                                    SizedBox(
                                                      width: 150,
                                                      child: Text(
                                                        'Account',
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 5,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .poppins()
                                                                  .fontFamily,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                // onTap: () => Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //       builder: (context) => RouteStops(
                                                //           routeID: widget.routeID,
                                                //           operatorName: widget.operatorName)),
                                                // ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25.0),

                              /* 
                        Code for the 'Favourite Stops' Section - Still in development, mockup of what I want to potentially 
                        develop in the future. I plan to modularise the cards by creating a widget class and dynamically 
                        get the real time information 
                      */
                              Container(
                                // Styling the Container
                                decoration: BoxDecoration(
                                    color: Colors.indigo[200],
                                    borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(35),
                                      bottomRight: Radius.circular(35),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: const Offset(0, 10),
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      // Explore More Title
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20.0),
                                        child: Text(
                                          "Favourite Stops",
                                          style: (TextStyle(
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.w300,
                                              fontFamily: GoogleFonts.poppins()
                                                  .fontFamily,
                                              color: Colors.white)),
                                        ),
                                      ),

                                      /* 
                                Row encapsulated within a SingleChildScrollView that allows the user to scroll 
                                through the available options in a horizontal manner 
                              */
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                child: Column(
                                                  children: [
                                                    Card(
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        child: Column(
                                                          children: [
                                                            // Stop Name/Number and the logo of operators serving this particular stop
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                color: Colors
                                                                        .indigo[
                                                                    100],
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  // Stop Number/Name
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "Stop 1234",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontFamily:
                                                                            GoogleFonts.poppins().fontFamily,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),

                                                                  // Logo of operators serving this particular stop
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: SizedBox
                                                                        .square(
                                                                      dimension:
                                                                          30,
                                                                      child: Image
                                                                          .asset(
                                                                              "assets/dublinBusLogo.png"),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),

                                                            // Route + Route Direction + Arrival Time (in minutes)
                                                            Row(
                                                              children: [
                                                                // Route
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      color: Colors
                                                                              .indigo[
                                                                          100]),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "39",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontFamily:
                                                                            GoogleFonts.poppins().fontFamily,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                                // Route Direction
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "Towards Burlington Road",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),

                                                                // Arrival Time (in minutes)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "14 mins",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 5),

                                                            // Route + Route Direction + Arrival Time (in minutes)
                                                            Row(
                                                              children: [
                                                                // Route
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      color: Colors
                                                                              .indigo[
                                                                          100]),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "39",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontFamily:
                                                                            GoogleFonts.poppins().fontFamily,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                                // Route Direction
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "Towards Burlington Road",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),

                                                                // Arrival Time (in minutes)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "14 mins",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 5),

                                                            // Route + Route Direction + Arrival Time (in minutes)
                                                            Row(
                                                              children: [
                                                                // Route
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      color: Colors
                                                                              .indigo[
                                                                          100]),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "39",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontFamily:
                                                                            GoogleFonts.poppins().fontFamily,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                                // Route Direction
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "Towards Burlington Road",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),

                                                                // Arrival Time (in minutes)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "14 mins",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 5),

                                                            // Route + Route Direction + Arrival Time (in minutes)
                                                            Row(
                                                              children: [
                                                                // Route
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      color: Colors
                                                                              .indigo[
                                                                          100]),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "39",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontFamily:
                                                                            GoogleFonts.poppins().fontFamily,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),

                                                                // Route Direction
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "Towards Burlington Road",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),

                                                                // Arrival Time (in minutes)
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "14 mins",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                                height: 5),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 12,
                                              ),
                                              GestureDetector(
                                                child: Column(
                                                  children: [
                                                    Card(
                                                      // color: getColorType(card.type),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        // decoration:
                                                        //     getColorType(card.type),
                                                        // color: Colors.white,
                                                        child: Column(
                                                          // mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                color: Colors
                                                                        .indigo[
                                                                    100],
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "Stop 1234",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontFamily:
                                                                            GoogleFonts.poppins().fontFamily,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: SizedBox
                                                                        .square(
                                                                      dimension:
                                                                          30,
                                                                      child: Image
                                                                          .asset(
                                                                              "assets/dublinBusLogo.png"),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Row(
                                                              // mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      color: Colors
                                                                              .indigo[
                                                                          100]),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "39",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontFamily:
                                                                            GoogleFonts.poppins().fontFamily,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "Towards Burlington Road",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "14 mins",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              // mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      color: Colors
                                                                              .indigo[
                                                                          100]),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "39",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontFamily:
                                                                            GoogleFonts.poppins().fontFamily,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "Towards Burlington Road",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "14 mins",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              // mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      color: Colors
                                                                              .indigo[
                                                                          100]),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "39",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontFamily:
                                                                            GoogleFonts.poppins().fontFamily,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "Towards Burlington Road",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "14 mins",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              // mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      color: Colors
                                                                              .indigo[
                                                                          100]),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "39",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontFamily:
                                                                            GoogleFonts.poppins().fontFamily,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "Towards Burlington Road",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "14 mins",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 12,
                                              ),
                                              GestureDetector(
                                                child: Column(
                                                  children: [
                                                    Card(
                                                      // color: getColorType(card.type),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        // decoration:
                                                        //     getColorType(card.type),
                                                        // color: Colors.white,
                                                        child: Column(
                                                          // mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15),
                                                                color: Colors
                                                                        .indigo[
                                                                    100],
                                                              ),
                                                              child: Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "Stop 1234",
                                                                      textAlign:
                                                                          TextAlign
                                                                              .left,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            18,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontFamily:
                                                                            GoogleFonts.poppins().fontFamily,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child: SizedBox
                                                                          .square(
                                                                        dimension:
                                                                            30,
                                                                        child: Image.asset(
                                                                            "assets/dublinBusLogo.png"),
                                                                      )),
                                                                  // Padding(
                                                                  //     padding:
                                                                  //         const EdgeInsets
                                                                  //             .all(8.0),
                                                                  //     child: SizedBox
                                                                  //         .square(
                                                                  //       dimension: 25,
                                                                  //       child: Image.asset(
                                                                  //           "assets/goAheadLogo.png"),
                                                                  //     )),
                                                                ],
                                                              ),
                                                            ),
                                                            Row(
                                                              // mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      color: Colors
                                                                              .indigo[
                                                                          100]),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "39",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontFamily:
                                                                            GoogleFonts.poppins().fontFamily,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "Towards Burlington Road",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "14 mins",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              // mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      color: Colors
                                                                              .indigo[
                                                                          100]),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "39",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontFamily:
                                                                            GoogleFonts.poppins().fontFamily,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "Towards Burlington Road",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "14 mins",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              // mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      color: Colors
                                                                              .indigo[
                                                                          100]),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "39",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontFamily:
                                                                            GoogleFonts.poppins().fontFamily,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "Towards Burlington Road",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "14 mins",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Row(
                                                              // mainAxisAlignment: MainAxisAlignment.center,
                                                              children: [
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              15),
                                                                      color: Colors
                                                                              .indigo[
                                                                          100]),
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child: Text(
                                                                      "39",
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontFamily:
                                                                            GoogleFonts.poppins().fontFamily,
                                                                        color: Colors
                                                                            .black,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "Towards Burlington Road",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Text(
                                                                    "14 mins",
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          13.5,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontFamily:
                                                                          GoogleFonts.poppins()
                                                                              .fontFamily,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 12,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25.0),

                              // Code for the 'Quick Links' Section
                              Container(
                                // Styling the Container
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple[200],
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(35),
                                      bottomLeft: Radius.circular(35),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: const Offset(0, 10),
                                      ),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Quick Links Title
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20.0),
                                        child: Text(
                                          "Quick Links",
                                          style: (TextStyle(
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.w300,
                                              fontFamily: GoogleFonts.poppins()
                                                  .fontFamily,
                                              color: Colors.white)),
                                        ),
                                      ),

                                      /* 
                                Row encapsulated within a SingleChildScrollView that allows the user to scroll 
                                through the available options in a horizontal manner 
                              */
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              // Transport For Ireland Button
                                              GestureDetector(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      // Styling the Container
                                                      height: 150,
                                                      width: 150,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              28),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 1,
                                                            blurRadius: 5,
                                                            offset:
                                                                const Offset(
                                                                    0, 3),
                                                          ),
                                                        ],
                                                      ),

                                                      // Image Logo of operator/authority
                                                      child: Center(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 90,
                                                              width: 90,
                                                              child:
                                                                  Image.asset(
                                                                'assets/transportForIrelandLogo.png',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    // Name of operator/authority
                                                    const SizedBox(height: 12),
                                                    SizedBox(
                                                      width: 150,
                                                      child: Text(
                                                        'Transport For Ireland',
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .poppins()
                                                                  .fontFamily,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                /* 
                                          If the user clicks on the button, they will be redirected to a web browser 
                                          within the application with the specified link
                                        */
                                                onTap: () => _launchURLApp(
                                                    "https://www.transportforireland.ie/"),
                                              ),
                                              const SizedBox(width: 12),

                                              // Dublin Bus Button
                                              GestureDetector(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      // Styling the Container
                                                      height: 150,
                                                      width: 150,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              28),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 1,
                                                            blurRadius: 5,
                                                            offset:
                                                                const Offset(
                                                                    0, 3),
                                                          ),
                                                        ],
                                                      ),

                                                      // Image Logo of operator/authority
                                                      child: Center(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 90,
                                                              width: 90,
                                                              child:
                                                                  Image.asset(
                                                                'assets/dublinBusLogo1.png',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    // Name of operator/authority
                                                    const SizedBox(height: 12),
                                                    SizedBox(
                                                      width: 150,
                                                      child: Text(
                                                        'Dublin Bus',
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 5,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .poppins()
                                                                  .fontFamily,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                /* 
                                          If the user clicks on the button, they will be redirected to a web browser 
                                          within the application with the specified link
                                        */
                                                onTap: () => _launchURLApp(
                                                    "https://www.dublinbus.ie/"),
                                              ),
                                              const SizedBox(width: 12),

                                              // Go Ahead Button
                                              GestureDetector(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      // Styling the Container
                                                      height: 150,
                                                      width: 150,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              28),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 1,
                                                            blurRadius: 5,
                                                            offset:
                                                                const Offset(
                                                                    0, 3),
                                                          ),
                                                        ],
                                                      ),

                                                      // Image Logo of operator/authority
                                                      child: Center(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 90,
                                                              width: 90,
                                                              child:
                                                                  Image.asset(
                                                                'assets/goAheadLogo1.png',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    // Name of operator/authority
                                                    const SizedBox(height: 12),
                                                    SizedBox(
                                                      width: 150,
                                                      child: Text(
                                                        'Go Ahead',
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 5,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .poppins()
                                                                  .fontFamily,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                /* 
                                          If the user clicks on the button, they will be redirected to a web browser 
                                          within the application with the specified link
                                        */
                                                onTap: () => _launchURLApp(
                                                    "https://www.goaheadireland.ie/"),
                                              ),
                                              const SizedBox(width: 12),

                                              // Iarnrod Eireann Button
                                              GestureDetector(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      // Styling the Container
                                                      height: 150,
                                                      width: 150,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              28),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 1,
                                                            blurRadius: 5,
                                                            offset:
                                                                const Offset(
                                                                    0, 3),
                                                          ),
                                                        ],
                                                      ),

                                                      // Image Logo of operator/authority
                                                      child: Center(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 90,
                                                              width: 90,
                                                              child:
                                                                  Image.asset(
                                                                'assets/iarnrodEireannLogo1.png',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    // Name of operator/authority
                                                    const SizedBox(height: 12),
                                                    SizedBox(
                                                      width: 150,
                                                      child: Text(
                                                        'Iarnrod Eireann',
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 5,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .poppins()
                                                                  .fontFamily,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                /* 
                                          If the user clicks on the button, they will be redirected to a web browser 
                                          within the application with the specified link
                                        */
                                                onTap: () => _launchURLApp(
                                                    "https://www.irishrail.ie/en-ie/"),
                                              ),
                                              const SizedBox(width: 12),

                                              // Luas Button
                                              GestureDetector(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      // Styling the Container
                                                      height: 150,
                                                      width: 150,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              28),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 1,
                                                            blurRadius: 5,
                                                            offset:
                                                                const Offset(
                                                                    0, 3),
                                                          ),
                                                        ],
                                                      ),

                                                      // Image Logo of operator/authority
                                                      child: Center(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 90,
                                                              width: 90,
                                                              child:
                                                                  Image.asset(
                                                                'assets/luasLogo1.png',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),

                                                    // Name of operator/authority
                                                    const SizedBox(height: 12),
                                                    SizedBox(
                                                      width: 150,
                                                      child: Text(
                                                        'Luas',
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 5,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .poppins()
                                                                  .fontFamily,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                /* 
                                          If the user clicks on the button, they will be redirected to a web browser 
                                          within the application with the specified link
                                        */
                                                onTap: () => _launchURLApp(
                                                    "https://www.luas.ie/"),
                                              ),
                                              const SizedBox(width: 12),

                                              // National Transport Authority Button
                                              GestureDetector(
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      // Styling the Container
                                                      height: 150,
                                                      width: 150,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              28),
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    0.5),
                                                            spreadRadius: 1,
                                                            blurRadius: 5,
                                                            offset:
                                                                const Offset(
                                                                    0, 3),
                                                          ),
                                                        ],
                                                      ),

                                                      // Image Logo of operator/authority
                                                      child: Center(
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 90,
                                                              width: 90,
                                                              child:
                                                                  Image.asset(
                                                                'assets/ntaLogo.png',
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),

                                                    // Name of operator/authority
                                                    SizedBox(
                                                      width: 150,
                                                      child: Text(
                                                        'National Transport Authority',
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 5,
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .poppins()
                                                                  .fontFamily,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),

                                                /* 
                                          If the user clicks on the button, they will be redirected to a web browser 
                                          within the application with the specified link
                                        */
                                                onTap: () => _launchURLApp(
                                                    "https://www.nationaltransport.ie/"),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Additional spacing for bottom navigation bar
                              const SizedBox(height: 50.0),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            });
      },
    );
  }
}
