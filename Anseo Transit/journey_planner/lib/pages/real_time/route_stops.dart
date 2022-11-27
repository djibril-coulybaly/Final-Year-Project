/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: route_stops.dart
  Description: This file will display a list of stops that pertain to a particular route direction that was chosen 
               from 'route_direction.dart' 
               
               Note: This screen contains a button that is pre-populated with a stopID. I didn't have eneough time 
               to implement and populate the stops pertaining to the route direction. If i had enough time, I'd use 
               the flutter package sqlflite to create a table and join with the _, _ and _ files in order to populate 
               the stops. 
*/

// Imports utilised in this file
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_planner/pages/real_time/real_time_results.dart';
// import 'package:sqflite/sqflite.dart';

class RouteStops extends StatefulWidget {
  /* 
    This class takes in 2 parameters: the route ID and the operator name. The operator name will be used 
    to get the trips from the specific JSON file relating to the operator and the route ID will be used 
    to get the directions that the route goes both inbound and outbound
  */
  final String routeID;
  final String operatorName;
  const RouteStops(
      {Key? key, required this.routeID, required this.operatorName})
      : super(key: key);

  @override
  State<RouteStops> createState() => _RouteStopsState();
}

class _RouteStopsState extends State<RouteStops> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Select Stop',
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /* 
              Button that is pre-populated with a stop ID. When clicked, it'll redirect them to the real time results page 
              (real_time_results.dart), where it'll display the real time information pertaining to that stop using the stop ID 
              and our GTFS server
            */
            ElevatedButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const RealTimeResults(
                          // This stop is Stop 4747 - Blanchardstown SC
                          stopID: "8240DB004747",
                        )),
              ),
              child: const Text(
                'Testing Real Time Information',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
