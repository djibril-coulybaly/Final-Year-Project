/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Admin
  File Name: main.dart
  Description: This file contains the initialization of this application
*/

// Imports utilised in this file
import 'package:anseo_admin/firebase_wrapper.dart';
import 'package:anseo_admin/models/account.dart';
import 'package:anseo_admin/services/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // FlutterNativeSplash.remove();

    return StreamProvider<AccountModel?>.value(
      catchError: (context, error) => null,
      value: FAS().admin,
      initialData: null,
      child: MaterialApp(
        home: const WrapperForFirebase(),
        theme: ThemeData(primarySwatch: Colors.deepPurple),
      ),
    );
  }
}
