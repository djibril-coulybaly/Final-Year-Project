/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: route_direction.dart
  Description: This file will display two route direction in relation to the route chosen prior in 'search_by_route.dart'.
*/

// Imports utilised in this file
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_planner/models/search_direction.dart';
import 'package:journey_planner/pages/real_time/route_stops.dart';

class RouteDirection extends StatefulWidget {
  /* 
    This class takes in 2 parameters: the route ID and the operator name. The operator name will be used 
    to get the trips from the specific JSON file relating to the operator and the route ID will be used 
    to get the directions that the route goes both inbound and outbound
  */
  final String routeID;
  final String operatorName;

  const RouteDirection(
      {Key? key, required this.routeID, required this.operatorName})
      : super(key: key);

  @override
  State<RouteDirection> createState() => _RouteDirectionState();
}

class _RouteDirectionState extends State<RouteDirection> {
  // Initialising Direction text that will be displayed to the user
  late String inboundDirection = "";
  late String outboundDirection = "";

  /* 
    Function that will display both the inbound direction and outbound direction of the route selected.
  */
  Future readJson() async {
    // Initializing Variables
    List<SearchDirection> directionList = [];
    String directionResponse = '';

    // If the operator name is either Dublin Bus, Go Ahead, Iarnrod Eireann or Luas, the apporpiate JSON file will be accessed
    if (widget.operatorName == "Dublin Bus") {
      directionResponse =
          await rootBundle.loadString('assets/gtfs/trips/dublinBusTrips.json');
    } else if (widget.operatorName == "Go Ahead") {
      directionResponse =
          await rootBundle.loadString('assets/gtfs/trips/goAheadTrips.json');
    } else if (widget.operatorName == "Iarnrod Eireann") {
      directionResponse = await rootBundle
          .loadString('assets/gtfs/trips/iarnrodEireannTrips.json');
    } else if (widget.operatorName == "Luas") {
      directionResponse =
          await rootBundle.loadString('assets/gtfs/trips/luasTrips.json');
    }

    // Converting our JSON data to a SearchDirection Class list
    final directionData = await json.decode(directionResponse) as List;
    directionList =
        directionData.map((e) => SearchDirection.fromJson(e)).toList();

    // Setting the inbound direction and outbound directionfrom our SearchDirection Class list
    setState(() {
      this.inboundDirection = directionList
          .firstWhere((element) => element.routeId == widget.routeID)
          .inboundName;
      this.outboundDirection = directionList
          .firstWhere((element) => element.routeId == widget.routeID)
          .outboundName;
    });
  }

  @override
  void initState() {
    super.initState();

    /* 
      Function call to get the inbound and outbound directions pertaining to the particular route. 
      This is being called in the initState() functions so that the data can be loaded before the screen is shown
    */
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Select Direction of Route',
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
      body: SafeArea(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Inbound Direction Button
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

                            // Image Icon for Inbound Direction
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    height: 90,
                                    width: 90,
                                    child: Image.asset(
                                      'assets/icons/back.png',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Direction Text
                          const SizedBox(height: 12),
                          SizedBox(
                            width: 150,
                            child: Text(
                              'Towards\n$inboundDirection',
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),

                      /* 
                        If the user clicks on the button, they will be redirected to the list of  
                        stops screen (route_stops.dart).

                        Note: This redirects to a screen with a button that contains a pre filled stopID. I didn't
                        have eneough time to implement and populate the stops pertaining to the route direction. If i had 
                        enough time, I'd use the flutter package sqlflite to create a table and join with the _, _ and _ files
                        in order to populate the stops.  
                      */
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RouteStops(
                                  routeID: widget.routeID,
                                  operatorName: widget.operatorName,
                                )),
                      ),
                    ),

                    // Outbound Direction Button
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

                            // Image Icon for outbound direction
                            child: Center(
                              child: Column(
                                children: [
                                  Container(
                                    height: 90,
                                    width: 90,
                                    child: Image.asset(
                                      'assets/icons/forward.png',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Direction Text
                          const SizedBox(height: 12),
                          SizedBox(
                            width: 150,
                            child: Text(
                              'Towards\n$outboundDirection',
                              textAlign: TextAlign.center,
                              maxLines: 5,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontFamily: GoogleFonts.poppins().fontFamily,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),

                      /* 
                        If the user clicks on the button, they will be redirected to the list of  
                        stops screen (route_stops.dart)

                        Note: This redirects to a screen with a button that contains a pre filled stopID. I didn't
                        have eneough time to implement and populate the stops pertaining to the route direction. If i had 
                        enough time, I'd use the flutter package sqlflite to create a table and join with the _, _ and _ files
                        in order to populate the stops. 
                      */
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RouteStops(
                                routeID: widget.routeID,
                                operatorName: widget.operatorName)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
