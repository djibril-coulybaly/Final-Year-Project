/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Validator
  File Name: radio_model.dart
  Description: This is the radio model that we use to structure specific information to display in the radio button when 
               the driver is selecting an option. Each radio button will hold the follwing:

               - Whether the option is selected or not
               - The name of the option
               - The icon associated with the option
*/
// Imports utilised in this file
import 'package:flutter/material.dart';

class RadioModel {
  bool isSelected;
  String name;
  IconData icon;
  RadioModel(this.isSelected, this.name, this.icon);
}
