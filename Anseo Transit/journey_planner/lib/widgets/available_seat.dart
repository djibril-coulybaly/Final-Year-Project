/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: available_seat.dart
  Description: This file is a widget template for when a seat is available in the Available Seats screen (available_seats.dart).
               If a seat is available it will be coloured in green
*/

// Imports utilised in this file
import 'package:flutter/material.dart';

Widget availableSeat() {
  return InkWell(
    child: Container(
      height: 40.0,
      width: 10.0,
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(3.0),
      ),
    ),
  );
}
