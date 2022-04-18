/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: search_by_route.dart
  Description: This file contains a searchable ListView widget that will display a list of routes from Dublin Bus, Go Ahead
               Iarnrod Eireann and Luas. The user can search for a route based on its Name/Number. Each Route will contain 
               the name/number of the route alongside the operator logo

               I learned how to create this searchable ListView using the following YouTube tutorial: https://www.youtube.com/watch?v=ZHdg2kfKmjI
*/

// Imports utilised in this file
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_planner/models/search_routes.dart';
import 'package:journey_planner/pages/real_time/route_direction.dart';
import 'package:journey_planner/pages/real_time/route_stops.dart';

class SearchByRoute extends StatefulWidget {
  const SearchByRoute({Key? key}) : super(key: key);

  @override
  State<SearchByRoute> createState() => _SearchByRouteState();
}

class _SearchByRouteState extends State<SearchByRoute> {
  // Initialising the list of routes, earch results of the list of routes, search query and the controller for the text input
  late List<SearchRoute> routeList = [];
  late List<SearchRoute> searchResults = [];
  String query = '';
  final controller = TextEditingController();

  /* 
    Function call to get a list of route from the 4 operators. These routes will be mapped to a SearchRoute Class Model
    and concatonated into one big list
  */
  Future readJson() async {
    // Getting JSON data of routes
    final String dublinBusResponse =
        await rootBundle.loadString('assets/gtfs/routes/dublinBusRoutes.json');
    final String goAheadResponse =
        await rootBundle.loadString('assets/gtfs/routes/goAheadRoutes.json');
    final String iarnrodEireannResponse = await rootBundle
        .loadString('assets/gtfs/routes/iarnrodEireannRoutes.json');
    final String luasResponse =
        await rootBundle.loadString('assets/gtfs/routes/luasRoutes.json');

    // Converting and mapping the JSON data to a list with a SearchRoute Class
    final dublinBusData = await json.decode(dublinBusResponse) as List;
    final goAheadData = await json.decode(goAheadResponse) as List;
    final iarnrodEireannData =
        await json.decode(iarnrodEireannResponse) as List;
    final luasData = await json.decode(luasResponse) as List;

    routeList = dublinBusData.map((e) => SearchRoute.fromJson(e)).toList();
    routeList += goAheadData.map((e) => SearchRoute.fromJson(e)).toList();
    routeList +=
        iarnrodEireannData.map((e) => SearchRoute.fromJson(e)).toList();
    routeList += luasData.map((e) => SearchRoute.fromJson(e)).toList();

    // Setting the search list so that we can search for a route without affecting the original list of routes
    setState(() {
      searchResults = routeList;
    });
  }

  @override
  void initState() {
    super.initState();

    /* 
      Function call to get the list of route from the 4 operators. 
      This is being called in the initState() functions so that the data can be loaded before the screen is shown
    */
    readJson();
    routeList = searchResults;
  }

  @override
  Widget build(BuildContext context) {
    inspect(routeList);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0.0,
        title: Text(
          'Search By Route',
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
                hintText: 'Enter Route',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.deepOrange),
                ),
              ),
              onChanged: searchForRoute,
            ),
          ),

          // List of routes
          Expanded(
            child: ListView.builder(
              itemCount: routeList.length,
              itemBuilder: (context, index) {
                final route = routeList[index];

                // ListView of routes
                return ListTile(
                  leading: route.operatorLogo == null
                      ? const Placeholder()
                      : Image.asset(
                          route.operatorLogo,
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        ),
                  title: Text(route.routeName),
                  onTap: () {
                    /* 
                      Since the stops on a route pertaining to Iarnrod Eireann and Luas are bi-directional, there's no need to 
                      specify the direction, therefore they'll be redirected to the route stops page (route_stops.dart)
                    */
                    if (route.operatorName == "Iarnrod Eireann" ||
                        route.operatorName == "Luas") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RouteStops(
                                routeID: route.routeId,
                                operatorName: route.operatorName)),
                      );
                    } else {
                      /* 
                        If the user selects a Dublin Bus or Go Ahead route, they will be redirected to the route direction page
                        (route_direction.dart)
                      */
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RouteDirection(
                                routeID: route.routeId,
                                operatorName: route.operatorName)),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /* 
    Function call to get the list of routes that the user is searching for. 
    It takes the user query as a parameter
  */
  void searchForRoute(String query) {
    final suggestions = searchResults.where((route) {
      final routeName = route.routeName.toLowerCase();
      final input = query.toLowerCase();

      return routeName.contains(input);
    }).toList();

    //  setState() is called at the end to ensure all the changes are relected on the screen.
    setState(() {
      this.routeList = suggestions;
      this.query = query;
    });
  }
}
