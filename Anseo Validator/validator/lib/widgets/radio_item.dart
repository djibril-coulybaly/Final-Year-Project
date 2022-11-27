/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Validator
  File Name: radio_item.dart
  Description: This widget is a template for the radio buttons that will allow the driver to select the options needed to carry out a transaction. 
               
               Each radio item will contain an icon and some text explaining the nature of this button
*/

// Imports utilised in this file
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:validator/models/radio_model.dart';

class RadioItem extends StatelessWidget {
  /* 
    This class takes in 1 parameters: 
    - The item that is going to be modelled into a selectable radio button
  */
  final dynamic _item;
  const RadioItem(this._item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          _item.icon,
          color: _item.isSelected ? Colors.deepPurple : Colors.grey[500],
          size: 35,
        ),
        Text(
          /* 
            If the item in question is not a route, then we will name it accordingly, 
            otherwise well give it the appropiate name
          */
          (_item is RadioModel) ? _item.name : _item.route,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontFamily: GoogleFonts.manrope().fontFamily,
            color: _item.isSelected ? Colors.deepPurple : Colors.grey[500],
          ),
        ),
      ],
    ));
  }
}
