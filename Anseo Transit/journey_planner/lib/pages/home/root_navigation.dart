/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: root_navigation.dart
  Description: This file contains a Scaffold with a bottom navigation bar that will display a page 
               from the list of children available. These pages will be individually linked to the 
               bottom navigation bar via icons
*/

// Imports utilised in this file
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:journey_planner/pages/home/home.dart';
import 'package:journey_planner/pages/plan_route/plan_route.dart';
import 'package:journey_planner/pages/real_time/available_seats.dart';
import 'package:journey_planner/pages/real_time/real_time.dart';
import 'package:journey_planner/pages/ticket/ticket_overview.dart';

class RootNavigation extends StatefulWidget {
  const RootNavigation({Key? key}) : super(key: key);

  @override
  State<RootNavigation> createState() => _RootNavigationState();
}

class _RootNavigationState extends State<RootNavigation> {
  // Variable to initially start the application on the 3rd child in the list '_pages' i.e. The Home Screen
  int _page = 2;

  // Global Key that contains the value of what icon is selected in the bottom navigation bar
  final GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

/* 
    List of pages that will be displayed within the application i.e. the main features of the application.
    They are place in order of the icons arranged in the bottom navigation bar 
*/

  List<Widget> _pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      const RealTime(),
      const TicketOverview(),
      Home(_bottomNavigationKey),
      const PlanRoute(),
      const AvailableSeats(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      /* 
        Indexed Stack allows for each child in the _pages list to have their own state. This means
        that you can change the state of that child, move to another child and upon returning to the 
        previous child, the state will be preserved
      */
      // body: PageView(
      //   children: _pages,
      //   // physics: const NeverScrollableScrollPhysics(),
      //   // index: _page,
      // ),
      body: IndexedStack(
        children: _pages,
        index: _page,
      ),

      // Bottom Navigation Bar that will be displayed throughout the application
      // Source Code = https://pub.dev/packages/curved_navigation_bar
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 2,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.departure_board, size: 30, color: Colors.white),
          Icon(Icons.credit_card, size: 30, color: Colors.white),
          Icon(Icons.home, size: 30, color: Colors.white),
          Icon(Icons.directions, size: 30, color: Colors.white),
          Icon(Icons.airline_seat_recline_normal,
              size: 30, color: Colors.white),
        ],
        color: Colors.deepPurple.shade300,
        buttonBackgroundColor: Colors.deepPurple.shade400,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
