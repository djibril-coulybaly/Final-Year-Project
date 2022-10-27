/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: walkthrough.dart
  Description: This file contains a PageView widget that will highlight the important features of this application
               to the user when they are using the application for the first time
*/

// Imports utilised in this file
import 'package:flutter/material.dart';
import 'package:journey_planner/pages/authentication/landing_page.dart';
import 'package:journey_planner/providers/walkthrough_provider.dart';
import 'package:journey_planner/widgets/walkthrough_progress_indicator.dart';
import 'package:journey_planner/widgets/walkthrough_template.dart';
import 'package:provider/provider.dart';

class Walkthrough extends StatelessWidget {
  // PageController - allows for monitoring what page the user is on while scrolling in the walkthrough
  final PageController _pageViewController = PageController(initialPage: 0);
  Walkthrough({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Provider that will listen for changes in the page number that the user is on
    final WalkthroughProvider _walkthroughProvider =
        Provider.of<WalkthroughProvider>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: PageView(
                controller: _pageViewController,
                onPageChanged: (int index) {
                  _walkthroughProvider.onPageChange(index);
                },

                //Custom Widget to display each feature to the user
                children: <Widget>[
                  WalkThroughTemplate(
                    title: "Integrated Account Ticketing",
                    subtitle:
                        "Using QR Code and NFC technologies, you'll have a digital account that can be used on all operators without the need to physically use a card or pay in cash",
                    image: Image.asset("assets/logo/logo1.png"),
                  ),
                  WalkThroughTemplate(
                    title: "Available Seats",
                    subtitle:
                        "Know what seat is free before boarding, saving you the hassle of looking for a free seat!",
                    image: Image.asset("assets/logo/logo1.png"),
                  ),
                  WalkThroughTemplate(
                    title: "Real Time Information",
                    subtitle:
                        "Get real time information on your stop and know when the next service is due",
                    image: Image.asset("assets/logo/logo1.png"),
                  ),
                  WalkThroughTemplate(
                    title: "Journey Planner",
                    subtitle:
                        "Plan your journey and explore more of your area today!",
                    image: Image.asset("assets/logo/logo1.png"),
                  )
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: <Widget>[
                  // Progress Indicator to indicated how far the user is in the walkthrough
                  Expanded(
                    child: WalkthroughProgressIndicator(
                        controller: _pageViewController),
                  ),

                  // Button to proceed to the next screen
                  ClipOval(
                    child: Container(
                      color: Theme.of(context).primaryColor,
                      child: IconButton(
                        icon: const Icon(
                          Icons.trending_flat,
                          color: Colors.white,
                        ),

                        //  If the user reaches the last page, they will be redirected to the Landing Page to either sign in or sign up
                        onPressed: () async {
                          if (_pageViewController.page! >= 3) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const LandingPage(),
                              ),
                            );
                            return;
                          }
                          _pageViewController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        padding: const EdgeInsets.all(13.0),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
