/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: firebase_wrapper.dart
  Description: Using a Provider, this file checks to see if a user is logged into the application. 
               If they are logged in, they'll be redirected to the home page (home.dart), 
               otherwise they'll be brought to the landing page (landing_page.dart).
*/
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:anseo_admin/models/account.dart';
import 'package:anseo_admin/pages/account/landing_page.dart';
import 'package:anseo_admin/pages/home/home.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

class WrapperForFirebase extends StatelessWidget {
  const WrapperForFirebase({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();

    final admin = Provider.of<AccountModel?>(context);
    inspect(admin);

    /* 
      If the user is not logged in, return to the landing page,
      otherwise return to the select options page 
    */
    if (admin == null) {
      return LandingPage();
    } else {
      return Home();
    }
  }
}
