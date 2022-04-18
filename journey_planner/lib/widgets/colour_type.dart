/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: colour_type.dart
  Description: This file provides the card design for the ticket/travel card that is used in the Ticket section.
               The travel cards/tickets will have a different colour assigned to them. 
*/

// Imports utilised in this file
import 'package:flutter/material.dart';

getColorType(String? type) {
  // Design for a ticket/travel card thats for students
  if (type == "Student") {
    // return Color(0xFFb88afe);
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: const LinearGradient(
        colors: [
          Color(0xFF4158D0),
          Color(0xFFC850C0),
          Color(0xFFFFCC70),
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
    );
  }
  // Design for a ticket/travel card thats for children
  else if (type == "Child") {
    // return Color(0xFF3bbbe9);
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: const LinearGradient(
        colors: [
          Color(0xFF8EC5FC),
          Color(0xFFE0C3FC),
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
    );
  }
  // Design for a ticket/travel card thats for adults
  else {
    // return Color(0xFF784BA0);
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: const LinearGradient(
        colors: [
          Color(0xFF0061ff),
          Color(0xFF60efff),
        ],
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
      ),
    );
  }
}
