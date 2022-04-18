/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: real_time_results.dart
  Description: This file contains a ListView widget that will display a list of upcoming routes from a particular stop.
               The information is obtained via a GET request made to our GTFS server. The Source Code for this server can
               be found on the following GitHub repository: https://github.com/seanrees/gtfs-upcoming
*/

// Imports utilised in this file
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:journey_planner/models/real_time_information.dart';

class RealTimeResults extends StatefulWidget {
  // This class takes the stop ID as a parameter. This is necessary to get the list of upcoming routes from our GTFS server
  final String stopID;
  const RealTimeResults({Key? key, required this.stopID}) : super(key: key);

  @override
  State<RealTimeResults> createState() => _RealTimeResultsState();
}

class _RealTimeResultsState extends State<RealTimeResults> {
  late List<RealTimeInformation> routeList = [];

  /* 
    Function that will return a list of upcomming routes from a particlular stop  
    my making a GET Request to our GTFS server
  */
  Future readJson() async {
    /* 
      Making a GET Request to our GTFS server to get the latest information on fleets arriving
      at a particular stop. Note that since the server was build locally and isnt deployed for production
      everytime the server is closed and started, a new IP address will be generated and much be inputted
      here before building
    */
    final response = await http.get(Uri.http(
        '192.168.1.12:6824', '/upcoming.json', {'stop': widget.stopID}));

    /* 
    Converting the JSON reults obtained from the GTFS server and mapping it to our RealTimeInformation Class Model
  */
    routeList =
        List<Map<String, dynamic>>.from(json.decode(response.body)['upcoming'])
            .map((e) => RealTimeInformation.fromJson(e))
            .toList();

    // setState() is called at the end to ensure all the changes are relected on the screen.
    setState(() {
      this.routeList = routeList;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
          'Real Time Information',
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
              If the list that we populated from the GET Request is empty, that indicates that there no more routes
              serving this stop at the moment and the appropiate error message will be displayed to the user. 
              Otherwise the following information will be displayed to the user:

              -Operator Logo
              -Route Name
              -Route Direction
              -Arrivial Time

            */
            (routeList.isNotEmpty)
                ? Expanded(
                    child: ListView.builder(
                      itemCount: routeList.length,
                      itemBuilder: (context, index) {
                        final route = routeList[index];

                        return Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          elevation: 6,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              // Operator Logo
                              leading: Image.asset(
                                route.operatorLogo,
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                              ),

                              // Route Name
                              title: Text(route.routeName),

                              // Route Direction
                              subtitle: Text("Towards ${route.towards}"),

                              // Arrival Time
                              trailing: Text(
                                  Duration(seconds: route.due.toInt())
                                          .inMinutes
                                          .toString() +
                                      " mins"),
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : Text(
                    'No real time information available at the moment!',
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
    );
  }
}
