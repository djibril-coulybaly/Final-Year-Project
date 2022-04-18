/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Validator
  File Name: main.dart
  Description: This file contains the initialization of this application
*/

// Imports utilised in this file
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:validator/firebase_wrapper.dart';
import 'package:validator/models/account.dart';
// import 'package:validator/pages/account/landing_page.dart';
// import 'package:validator/pages/select_option.dart';
import 'package:validator/services/firebase_auth.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is thse root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AccountModel?>.value(
      catchError: (context, error) => null,
      value: FAS().user,
      initialData: null,
      child: MaterialApp(
        // home: LandingPage(),
        home: const WrapperForFirebase(),
        // home: SelectOption(),
        theme: ThemeData(primarySwatch: Colors.deepPurple),
      ),
    );
  }
}
