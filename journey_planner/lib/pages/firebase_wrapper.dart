/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: firebase_wrapper.dart
  Description: Using a Provider, this file checks to see if a user is logged into the application. If they are logged in, 
               they'll be redirected to the homepage (.dart), otherwise they'll be brought to the walkthrough page (walkthough.dart).
*/

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:journey_planner/models/user.dart';
import 'package:journey_planner/pages/home/root_navigation.dart';
import 'package:journey_planner/pages/walkthrough/walkthrough.dart';
import 'package:provider/provider.dart';
// import 'package:journey_planner/pages/authentication/landing_page.dart';
// import 'package:journey_planner/pages/home/home.dart';

class WrapperForFirebase extends StatelessWidget {
  const WrapperForFirebase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    inspect(user);
    FlutterNativeSplash.remove();

    /* 
      If the user is not logged in, return to the authenticate widget,
      otherwise return to the home widget 
    */
    if (user == null) {
      // return const Authenticate();
      return Walkthrough();
      // return LandingPage();
    } else {
      return const RootNavigation();
    }
  }
}
