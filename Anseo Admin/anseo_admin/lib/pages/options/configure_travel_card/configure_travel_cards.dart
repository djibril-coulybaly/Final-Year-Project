/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: configure_travel_cards.dart
  Description: This file allows the admin to select the travel card type that they want to configure 
               on to the travel card. The admin can choose one of the following travel card types 
               from a dropdown list: 
               
               - Adult
               - Child
               - Student

               From here, they will be redirected to the NFC Scan page (nfc_scan.dart) where the 
               admin can scan the selected travel card to be configured with the travel card type.
*/

// Imports utilised in this file
import 'package:anseo_admin/pages/options/configure_travel_card/nfc_scan.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConfigureTravelCards extends StatefulWidget {
  const ConfigureTravelCards({Key? key}) : super(key: key);

  @override
  State<ConfigureTravelCards> createState() => _ConfigureTravelCardsState();
}

class _ConfigureTravelCardsState extends State<ConfigureTravelCards> {
  /*
    Initializing the variable used to select the travel card type in the dropdown list.
    Note: The value specified in this variable must be the first item declared in order
    for the dropdown list to work. 
  */
  String travelCardType = 'Adult';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[300],
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          'Configure Travel Card',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w500,
            fontFamily: GoogleFonts.manrope().fontFamily,
            color: Colors.white,
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Select Type for Travel Card",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.0,
                  color: const Color(0xFF9CA4AA),
                  fontFamily: GoogleFonts.manrope().fontFamily,
                ),
              ),
              const SizedBox(
                height: 7.0,
              ),

              // Dropdown list which the admin can select to modify a user account, driver account or admin account
              DropdownButton<String>(
                isExpanded: true,
                value: travelCardType,
                icon: const Icon(Icons.arrow_downward),
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    travelCardType = newValue!;
                  });
                },
                items: <String>['Adult', 'Child', 'Student']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),

              /* Submit Button */
              const SizedBox(height: 40.0),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    // primary: Colors.transparent,
                    // shadowColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),

                  /* 
                    The travel card type will be passed to the NFC Scan page (nfc_scan.dart), where the
                    admin will be able to scan and configure the travel card to contain the travel card
                    type
                  */
                  onPressed: () async {
                    if (travelCardType.isNotEmpty) {
                      // Navigator.of(context).pushReplacement(
                      //   MaterialPageRoute<void>(
                      //     builder: (BuildContext context) => SelectOption(),
                      //     // WrapperForFirebase(),
                      //   ),
                      // );

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NFCScan(travelCardType)));
                    } else {
                      // setState(() {
                      //   error = 'Please supply a valid email';
                      // });
                    }
                  },
                  child: Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFF4158D0),
                          Color(0xFFC850C0),
                        ],
                      ),
                    ),
                    child: Container(
                      width: 300,
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        'CONFIGURE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w400,
                          fontFamily: GoogleFonts.manrope().fontFamily,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
