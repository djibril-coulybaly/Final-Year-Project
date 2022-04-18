/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: search_by_stop_address.dart
  Description: This file contains a searchable ListView widget that will display a list of stops from Dublin Bus, Go Ahead
               Iarnrod Eireann and Luas. The user can search for a route based on its Stop Address. Each stop will contain 
               the stop name/number, stop address and the operator logo

               I learned how to create this searchable ListView using the following YouTube tutorial: https://www.youtube.com/watch?v=ZHdg2kfKmjI
*/

// Imports utilised in this file
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_planner/models/search_stop.dart';
import 'package:journey_planner/pages/real_time/real_time_results.dart';

class SearchByStopAddress extends StatefulWidget {
  const SearchByStopAddress({Key? key}) : super(key: key);

  @override
  State<SearchByStopAddress> createState() => _SearchByStopAddressState();
}

class _SearchByStopAddressState extends State<SearchByStopAddress> {
  // Initialising the list of stops, earch results of the list of stops, search query and the controller for the text input
  late List<SearchStop> stopList = [];
  late List<SearchStop> dublinBusTestList = [];
  late List<SearchStop> goAheadTestList = [];
  late List<SearchStop> testList = [];
  late List<SearchStop> combineFilteredTestList = [];
  late List<SearchStop> searchResults = [];

  String query = '';
  final controller = TextEditingController();

  //  Function call to get the list of stops from the 4 operators.
  Future readJson() async {
    // Getting JSON data of routes
    final String dublinBusResponse =
        await rootBundle.loadString('assets/gtfs/stops/dublinBusStops.json');
    final String goAheadResponse =
        await rootBundle.loadString('assets/gtfs/stops/goAheadStops.json');
    final String iarnrodEireannResponse = await rootBundle
        .loadString('assets/gtfs/stops/iarnrodEireannStops.json');
    final String luasResponse =
        await rootBundle.loadString('assets/gtfs/stops/luasStops.json');

    // Converting JSON data to a list
    final dublinBusData = await json.decode(dublinBusResponse) as List;
    final goAheadData = await json.decode(goAheadResponse) as List;
    final iarnrodEireannData =
        await json.decode(iarnrodEireannResponse) as List;
    final luasData = await json.decode(luasResponse) as List;

    // Getting the stops that are operated on by Dublin Bus and Go Ahead
    dublinBusTestList =
        dublinBusData.map((e) => SearchStop.fromJson(e, "Dublin Bus")).toList();
    goAheadTestList =
        goAheadData.map((e) => SearchStop.fromJson(e, "Go Ahead")).toList();

    /* 
      Dublin Bus and Go Ahead share some stops together. What I am doing is comparing 
      both the Dublin Bus and Go Ahead stops list. If they have the same Stop ID in both
      lists, then that stop is being served by both operators. We'll create a new list that 
      will contain the common stops between the two operators and include the Go Ahead logo 
      to the list too. The reason why were adding the Go Ahead logo to the list as opposed to 
      the Dublin Bus logo is because Dublin Bus has all the stops that Go Ahead has. Prior to 2017,
      the stops that Go Ahead are operating on now were managed by Dublin Bus.  
    */
    for (var x in dublinBusTestList) {
      for (var y in goAheadTestList) {
        if (x.stopID == y.stopID) {
          x.operatorLogo2 = "assets/goAheadLogo.png";
          combineFilteredTestList.add(x);
        }
      }
    }

    /* 
      Getting a list of stops from Dublin Bus that doesn't contain the common stop that we obtained in 
      combineFilteredTestList. 
    */
    stopList = dublinBusTestList
        .where(
            (a) => combineFilteredTestList.every((b) => a.stopID != b.stopID))
        .toList();

    // Adding the stops in combineFilteredTestList to the list of stops not in common between Dublin Bus and Go Ahead
    stopList += combineFilteredTestList;

    // Adding the stops in Iarnrod Eireann to the list
    stopList += iarnrodEireannData
        .map((e) => SearchStop.fromJson(e, "Iarnrod Eireann"))
        .toList();

    // Adding the stops in Luas to the list
    stopList += luasData.map((e) => SearchStop.fromJson(e, "Luas")).toList();

    // Setting the search list so that we can search for a route without affecting the original list of routes
    setState(() {
      searchResults = stopList;
    });
  }

  @override
  void initState() {
    super.initState();

    /* 
      Function call to get the list of stops from the 4 operators. 
      This is being called in the initState() functions so that the data can be loaded before the screen is shown
    */
    readJson();
    stopList = searchResults;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: Text(
          'Search By Stop Address',
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
      body: Column(
        children: <Widget>[
          // Text Input for searching stop address
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Enter Stop Address',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.deepOrange),
                ),
              ),
              onChanged: searchForRoute,
            ),
          ),

          // List of Stops
          Expanded(
            child: ListView.builder(
              itemCount: stopList.length,
              itemBuilder: (context, index) {
                final route = stopList[index];

                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  elevation: 6,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                        // Stop Number
                        leading: Text(
                          route.stopNumber,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                            fontFamily: GoogleFonts.poppins().fontFamily,
                            color: Colors.black,
                          ),
                        ),

                        /* 
                          Since the stop name and stop address for Luas and Iarnrod Eireann are the same respectively,
                          I wont show the stop name for Luas and Iarnrod Eireann here. Rather I'll show it in the stop
                          number above. For Dublin Bus and Go Ahead they have different stop name and numbers so it can 
                          be displayed
                        */
                        title: route.operatorLogo1 ==
                                    "assets/iarnrodEireannLogo.png" ||
                                route.operatorLogo1 == "assets/luasLogo.png"
                            ? const SizedBox.shrink()
                            : Text(route.stopName,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: GoogleFonts.poppins().fontFamily,
                                  color: Colors.black,
                                )),

                        // Logo of Operator/s serving this stop
                        trailing: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: Image.asset(
                                    route.operatorLogo1,
                                    width: 75,
                                    height: 68,
                                  ),
                                ),
                                route.operatorLogo2 != ""
                                    ? SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: Image.asset(
                                          route.operatorLogo2,
                                          width: 15,
                                          height: 18,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ],
                            ),
                          ],
                        ),

                        /* 
                          If the user clicks on the button, they will be redirected to the real time results page 
                          (real_time_results.dart), where it'll display the real time information pertaining to 
                          that stop using the stop ID and our GTFS server
                        */
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RealTimeResults(stopID: route.stopID)),
                          );
                        }),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /* 
    Function call to get the list of routes with a particular address that the user is searching for. 
    It takes the user query as a parameter
  */
  void searchForRoute(String query) {
    final suggestions = searchResults.where((route) {
      final routeName = route.stopName.toLowerCase();
      final input = query.toLowerCase();

      return routeName.contains(input);
    }).toList();

    //  setState() is called at the end to ensure all the changes are relected on the screen.
    setState(() {
      this.stopList = suggestions;
      this.query = query;
    });
  }
}
