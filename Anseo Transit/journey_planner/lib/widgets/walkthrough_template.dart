/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: walkthrough_template.dart
  Description: This file is the template structure for each page in the walkthrough that will be displayed in walkthrough.dart
*/

import 'package:flutter/material.dart';

class WalkThroughTemplate extends StatelessWidget {
  // Declaring parameters for the class constructor "WalkThroughTemplate"
  const WalkThroughTemplate(
      {required this.title,
      required this.subtitle,
      required this.image,
      Key? key})
      : super(key: key);

  final String title;
  final String subtitle;
  final Image image;

  @override
  Widget build(BuildContext context) {
    //Using the theme colours set in main.dart
    final ThemeData _theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: <Widget>[
          /*
            Image that explains the feature of the application. It is wrapped in an expanded widget
            so that it can take up as much space as possible.
          */
          Expanded(
            child: Center(
              child: image,
            ),
          ),

          /*
            Container that has a Column widget with the title and subtitle. The Column widget is encompassed in an 
            Expanded widget so that it can take up as much space as possible.
          */
          Container(
            height: 180.0,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: _theme.textTheme.headline6,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        subtitle,
                        style: _theme.textTheme.bodyText2!.merge(
                          TextStyle(
                            color: Colors.grey[600],
                            height: 1.3,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
