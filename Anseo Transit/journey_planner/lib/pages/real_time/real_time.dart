/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: real_time.dart
  Description: This file presents the user with the option to search for real time information on a particular stop based on the following:
               -Search by Route
               -Search by Stop Name
               -Search by Stop Address
               -Search by Map
*/

// Imports utilised in this file
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_planner/pages/real_time/search_by_route.dart';
import 'package:journey_planner/pages/real_time/search_by_stop_address.dart';
import 'package:journey_planner/pages/real_time/search_by_stop_number.dart';
import 'package:journey_planner/pages/real_time/search_on_map.dart';

class RealTime extends StatefulWidget {
  const RealTime({Key? key}) : super(key: key);

  @override
  State<RealTime> createState() => _RealTimeState();
}

class _RealTimeState extends State<RealTime> {
  @override
  Widget build(BuildContext context) {
    /* 
      Wrapping the Scaffold within a Navaigator and MaterialPageRoute widget to have the bottom navigator bar 
      persist throughout the application. When we don’t use Navigator, whenever we push any route the route
      will be stacked on the default Navigator that comes with MaterialApp.
    */
    return Navigator(
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            return Scaffold(
              extendBody: true,
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                iconTheme: const IconThemeData(color: Colors.white),
                centerTitle: true,
                elevation: 0.0,
                title: Text(
                  'Real Time Information',
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
              body: SafeArea(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Select an option to view real time information",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Search by Route Button
                            GestureDetector(
                              child: Column(
                                children: [
                                  Container(
                                    // Styling the Container
                                    height: 150,
                                    width: 150,
                                    padding: const EdgeInsets.all(28),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),

                                    // Image Icon for Search by Route
                                    child: Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 90,
                                            width: 90,
                                            child: Image.asset(
                                              'assets/icons/route.png',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Search By Route Text
                                  const SizedBox(height: 12),
                                  Text(
                                    'Search By\nRoute',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),

                              /* 
                                If the user clicks on the button, they will be redirected to the Search by Route page
                                (search_by_route.dart)
                              */
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SearchByRoute()),
                              ),
                            ),

                            // Seach by Stop Address Button
                            GestureDetector(
                              child: Column(
                                children: [
                                  Container(
                                    // Styling the Container
                                    height: 150,
                                    width: 150,
                                    padding: const EdgeInsets.all(28),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),

                                    // Image Icon for Search by Stop Address
                                    child: Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 90,
                                            width: 90,
                                            child: Image.asset(
                                              'assets/icons/address.png',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Search by Stop Address Text
                                  const SizedBox(height: 12),
                                  Text(
                                    'Search By\nStop Address',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),

                              /* 
                                If the user clicks on the button, they will be redirected to the Search by Stop Address page
                                (search_by_stop_address.dart)
                              */
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SearchByStopAddress()),
                              ),
                            ),
                          ],
                        ),
                        // Spacing between the first row of buttons and the second row of buttons
                        const SizedBox(height: 18),

                        // Search By Stop Number and Search on Map Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Search By Stop Number Button
                            GestureDetector(
                              child: Column(
                                children: [
                                  Container(
                                    // Styling the Container
                                    height: 150,
                                    width: 150,
                                    padding: const EdgeInsets.all(28),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),

                                    // Image Icon for Seach by Stop Number
                                    child: Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 90,
                                            width: 90,
                                            child: Image.asset(
                                              'assets/icons/numbers.png',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Search By Stop Number Text
                                  const SizedBox(height: 12),
                                  Text(
                                    'Search By\nStop Number',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),

                              /* 
                                If the user clicks on the button, they will be redirected to the Search by Stop Number page
                                (search_by_stop_number.dart)
                              */
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SearchByStopNumber()),
                              ),
                            ),

                            // Search on Map Button
                            GestureDetector(
                              child: Column(
                                children: [
                                  Container(
                                    // Styling the Container
                                    height: 150,
                                    width: 150,
                                    padding: const EdgeInsets.all(28),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),

                                    // Image Icon for Search on Map
                                    child: Center(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 90,
                                            width: 90,
                                            child: Image.asset(
                                              'assets/icons/map_marker.png',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // Search on Map Text
                                  const SizedBox(height: 12),
                                  Text(
                                    'Search On\nMap',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily:
                                          GoogleFonts.poppins().fontFamily,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),

                              /* 
                                If the user clicks on the button, they will be redirected to the Search on Map page
                                (search_on_map.dart)
                              */
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SearchOnMap()),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
