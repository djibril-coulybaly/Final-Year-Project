/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: search_on_map.dart
  Description: This file contains a full screen map that will display the geographical stops from Dublin Bus, Go Ahead
               Iarnrod Eireann and Luas. The user can click on a stop, which will display a card containing the stop name/number, 
               stop address and the operator logo.

               I learned how to create this map using the following YouTube tutorial: https://www.youtube.com/watch?v=gaKvL88Zws0&t=223s
*/

// Imports utilised in this file
import 'dart:convert';
import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:journey_planner/models/map_marker.dart';
import 'package:journey_planner/pages/real_time/real_time_results.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter/services.dart' show rootBundle;

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1IjoiZGppYnJpbC1jIiwiYSI6ImNrd3UxaGlrNzFsbDUyd3VzcW84b3JkbG8ifQ.XljcOHaEsc1CwqEPWWh-Xw';
const MAPBOX_STYLE = 'djibril-c/ckx2g4egb452414o451sbjlaq';
const MARKER_COLOR = Colors.deepPurple;
const MARKER_SIZE_EXPANDED = 45.0;
const MARKER_SIZE_SHRINKED = 25.0;

// location of where I want the map to start at - Centre of Dublin
final _mylocation = LatLng(53.3498, -6.2603);

class SearchOnMap extends StatefulWidget {
  const SearchOnMap({Key? key}) : super(key: key);

  @override
  State<SearchOnMap> createState() => _SearchOnMapState();
}

class _SearchOnMapState extends State<SearchOnMap>
    with SingleTickerProviderStateMixin {
  // Initialising the list of stops, each results of the list of stops, search query and the controller for the text input
  final _pageController = PageController();
  late final AnimationController _animationController;
  int _selectedIndex = -1;

  List<MapMarker> mapMarkers = [];
  List<MapMarker> dublinBusTestList = [];
  List<MapMarker> goAheadTestList = [];
  List<MapMarker> combineUnfilteredTestList = [];
  List<MapMarker> combineFilteredTestList = [];
  List<MapMarker> testList5 = [];

  //  Function call to get the list of stops from the 4 operators.
  Future<void> readJson() async {
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
        dublinBusData.map((e) => MapMarker.fromJson(e, "Dublin Bus")).toList();

    goAheadTestList =
        goAheadData.map((e) => MapMarker.fromJson(e, "Go Ahead")).toList();

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
        if (x.stopId == y.stopId) {
          x.image2 = "assets/goAheadLogo.png";
          combineFilteredTestList.add(x);
        }
      }
    }

    /* 
      Getting a list of stops from Dublin Bus that doesn't contain the common stop that we obtained in 
      combineFilteredTestList. 
    */
    mapMarkers = dublinBusTestList
        .where(
            (a) => combineFilteredTestList.every((b) => a.stopId != b.stopId))
        .toList();

    // Adding the stops in combineFilteredTestList to the list of stops not in common between Dublin Bus and Go Ahead
    mapMarkers += combineFilteredTestList;

    // Adding the stops in Iarnrod Eireann to the list
    mapMarkers += iarnrodEireannData
        .map((e) => MapMarker.fromJson(e, "Iarnrod Eireann"))
        .toList();

    // Adding the stops in Luas to the list
    mapMarkers += luasData.map((e) => MapMarker.fromJson(e, "Luas")).toList();
  }

  List<Marker> _buildMarkers() {
    final _markerList = <Marker>[];
    readJson();
    for (int i = 0; i < mapMarkers.length; i++) {
      final mapItem = mapMarkers[i];
      _markerList.add(
        Marker(
          height: MARKER_SIZE_EXPANDED,
          width: MARKER_SIZE_EXPANDED,
          point: LatLng(mapItem.stopLat, mapItem.stopLon),
          builder: (_) {
            return GestureDetector(
              onTap: () {
                _selectedIndex = i;
                setState(() {
                  _pageController.animateToPage(i,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.elasticOut);
                  debugPrint('Selected: ${mapItem.stopName}');
                });
              },
              child: _LocationMarker(
                selected: _selectedIndex == i,
              ),
            );
          },
        ),
      );
    }
    return _markerList;
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animationController.repeat(reverse: true);
    super.initState();
    readJson().then((value) => {setState(() {})});
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _markers = _buildMarkers();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
                minZoom: 5,
                maxZoom: 18,
                zoom: 14,
                center: _mylocation,
                plugins: [MarkerClusterPlugin()]),
            nonRotatedLayers: [
              TileLayerOptions(
                urlTemplate:
                    'https://api.mapbox.com/styles/v1/{id}/tiles/256/{z}/{x}/{y}@2x?access_token={accessToken}',
                additionalOptions: {
                  'accessToken': MAPBOX_ACCESS_TOKEN,
                  'id': MAPBOX_STYLE,
                },
              ),
              // MarkerLayerOptions(
              //   markers: _markers,
              // ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                      height: 50,
                      width: 50,
                      point: _mylocation,
                      builder: (_) {
                        return _MyLocationMarker(_animationController);
                      }),
                ],
              ),
              MarkerClusterLayerOptions(
                maxClusterRadius: 120,
                size: const Size(40, 40),
                fitBoundsOptions: const FitBoundsOptions(
                  padding: EdgeInsets.all(50),
                ),
                markers: _markers,
                polygonOptions: const PolygonOptions(borderStrokeWidth: 3),
                builder: (context, markers) {
                  return FloatingActionButton(
                    child: Text(markers.length.toString()),
                    onPressed: null,
                  );
                },
              ),
            ],
          ),
          //Add a pageview
          Positioned(
            left: 0,
            right: 0,
            bottom: 20,
            height: MediaQuery.of(context).size.height * 0.3,
            child: PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: mapMarkers.length,
              itemBuilder: (context, index) {
                final item = mapMarkers[index];
                return _MapItemDetails(
                  mapMarker: item,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Class that returns the marker used to highlight a stop
class _LocationMarker extends StatelessWidget {
  /* 
    This class takes in 1 parameters: the bool selected. 'selected' will be used to determine whether a 
    particular stop has been selected or not.If it has been selected then the size of the marker will 
    be increased to indicate it has been selected, otherwise it'll have a regular size
  */
  const _LocationMarker({Key? key, this.selected = false}) : super(key: key);

  final bool selected;
  @override
  Widget build(BuildContext context) {
    // If the stop is selected, the size of the marker will be increased to indicate it has been selected
    final size = selected ? MARKER_SIZE_EXPANDED : MARKER_SIZE_SHRINKED;
    return Center(
      child: AnimatedContainer(
        height: size,
        width: size,
        duration: const Duration(milliseconds: 400),
        child: Image.asset('assets/marker.png'),
      ),
    );
  }
}

// Class that returns the marker used to highlight the users location
class _MyLocationMarker extends AnimatedWidget {
  const _MyLocationMarker(Animation<double> animation, {Key? key})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final value = (listenable as Animation<double>).value;
    final newValue = lerpDouble(0.5, 1.0, value)!;
    const size = 50.0;
    return Center(
      child: Stack(
        children: [
          Center(
            child: Container(
              height: size * newValue,
              width: size * newValue,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: MARKER_COLOR.withOpacity(0.5),
              ),
            ),
          ),
          Center(
            child: Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                color: MARKER_COLOR,
                shape: BoxShape.circle,
              ),
            ),
          )
        ],
      ),
    );
  }
}

/* 
  Class to display the details of the selected stop. This includes the stop name/number, 
  stop address and the operator logo. 
*/
class _MapItemDetails extends StatelessWidget {
  const _MapItemDetails({
    Key? key,
    required this.mapMarker,
  }) : super(key: key);

  final MapMarker mapMarker;

  @override
  Widget build(BuildContext context) {
    final _styleTitle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w700,
      fontFamily: GoogleFonts.poppins().fontFamily,
      color: Colors.black,
    );
    final _styleAddress = TextStyle(
      color: Colors.grey[800],
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: GoogleFonts.poppins().fontFamily,
    );
    return Padding(
      padding: const EdgeInsets.only(
          left: 15.0, right: 15.0, top: 15.0, bottom: 60.0),
      child: Card(
        margin: EdgeInsets.zero,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Displaying the logos of the operators, the stop name and the stop address
            Expanded(
              child: Row(
                children: [
                  Image.asset(
                    mapMarker.image,
                    width: 105,
                    height: 85,
                  ),
                  mapMarker.image2 != ""
                      ? Padding(
                          padding: const EdgeInsets.only(top: 9),
                          child: Image.asset(
                            mapMarker.image2,
                            width: 75,
                            height: 68,
                          ),
                        )
                      : const SizedBox.shrink(),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          mapMarker.stopName,
                          style: _styleTitle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          mapMarker.stopAddress,
                          style: _styleAddress,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              padding: const EdgeInsets.only(bottom: 0.0),

              /* 
                If the user clicks on the button, they will be redirected to the real time results page 
                (real_time_results.dart), where it'll display the real time information pertaining to 
                that stop using the stop ID and our GTFS server
              */
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RealTimeResults(
                    stopID: mapMarker.stopId,
                  ),
                ),
              ),
              color: MARKER_COLOR,
              elevation: 3,
              height: 60,
              child: Text(
                'View Real Time Information',
                style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
