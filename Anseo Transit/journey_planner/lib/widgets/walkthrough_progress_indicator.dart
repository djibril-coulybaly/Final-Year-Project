/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: walkthrough_progress_indicator.dart
  Description: This file produces the progress indicator that will be displayed in walkthrough.dart
*/
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:journey_planner/providers/walkthrough_provider.dart';

class WalkthroughProgressIndicator extends StatelessWidget {
  // Declaring parameters for the class constructor "WalkthroughProgressIndicator"
  final PageController controller;
  const WalkthroughProgressIndicator({required this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Generate a Row that contains a list of 4 progress indicator bars
    return Row(
      children: List.generate(
        4,
        (int index) {
          return Consumer(
            builder: (BuildContext context, WalkthroughProvider walkthrough,
                Widget? child) {
              // User is able to tap on each bar of the progress indicator to specify what page they'd like to go to
              return GestureDetector(
                onTap: () {
                  controller.animateToPage(index,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.ease);
                },
                child: Container(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  padding: const EdgeInsets.symmetric(vertical: 25.0),
                  child: Container(
                    height: 5.0,
                    width: 40.0,
                    // If the user is on a spceific page, that page alongside its previous pages will be highlighted in a different colour in contrast to the pages not visited yet
                    decoration: BoxDecoration(
                      color: index <= walkthrough.currentPageValue
                          ? Theme.of(context).primaryColor
                          : Colors.grey[300],
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    margin: const EdgeInsets.only(right: 5.0),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
