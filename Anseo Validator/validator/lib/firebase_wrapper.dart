/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Validator
  File Name: firebase_wrapper.dart
  Description: Using a Provider, this file checks to see if a user is logged into the application. 
               If they are logged in, they'll be redirected to the home page (home.dart), 
               otherwise they'll be brought to the landing page (landing_page.dart).
*/
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:validator/models/account.dart';
import 'package:validator/pages/account/landing_page.dart';
import 'package:provider/provider.dart';
import 'package:validator/pages/select_option_for_driver.dart';

class WrapperForFirebase extends StatelessWidget {
  const WrapperForFirebase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    final user = Provider.of<AccountModel?>(context);
    inspect(user);

    /* 
      If the user is not logged in, return to the landing page,
      otherwise return to the select options page 
    */
    if (user == null) {
      return LandingPage();
    } else {
      return SelectOptionForDriver(user.uid);
    }

    // if (user == null && showHome == false) {
    //   // return const Authenticate();
    //   return SplashScreenWalkthrough();
    //   // return LandingPage();
    // } else if (user == null && showHome == true) {
    //   return LandingPage();
    // } else {
    //   return Home();
    // }
  }
}
