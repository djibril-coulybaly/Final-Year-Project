/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Validator
  File Name: routes.dart
  Description: This is the routes model that we use to structure specific information to display in the radio button when 
               the driver is selecting a route. Each radio button will hold the follwing:

               - Whether the route is selected or not
               - The name of the route
               - A pin icon associated with the route
*/
// Imports utilised in this file
import 'package:flutter/material.dart';

class Routes {
  late String route;
  bool isSelected = false;
  IconData icon = Icons.place;

  Routes({required this.isSelected});

  Routes.fromJson(Map<String, dynamic> json) {
    route = (json['route_long_name'].toString() == "")
        ? json['route_short_name'].toString()
        : json['route_long_name'].toString();
  }
}
