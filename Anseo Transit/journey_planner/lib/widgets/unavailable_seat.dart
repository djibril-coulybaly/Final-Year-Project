/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: unavailable_seat.dart
  Description: This file is a widget template for when a seat is unavailable in the Available Seats screen (available_seats.dart).
               If a seat is unavailable it will be coloured in red
*/

// Imports utilised in this file
import 'package:flutter/material.dart';

Widget unavailableSeat() {
  return InkWell(
    child: Container(
      height: 40.0,
      width: 10.0,
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(3.0),
      ),
    ),
  );
}
