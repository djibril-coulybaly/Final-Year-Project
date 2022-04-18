/*
  Student Name: Djibril Coulybaly
  Student Number: C18423664
  Date: 15/04/2022
  Application: Anseo Transit
  File Name: main.dart
  Description: This file contains the initialization of this application
*/

// Imports utilised in this file
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:journey_planner/models/user.dart';
import 'package:journey_planner/pages/firebase_wrapper.dart';
import 'package:journey_planner/pages/home/home.dart';
import 'package:journey_planner/pages/home/root_navigation.dart';
import 'package:journey_planner/pages/plan_route/plan_route.dart';
import 'package:journey_planner/pages/real_time/available_seats.dart';
import 'package:journey_planner/pages/real_time/real_time.dart';
import 'package:journey_planner/pages/walkthrough/walkthrough.dart';
import 'package:journey_planner/pages/ticket/ticket_overview.dart';
import 'package:journey_planner/providers/walkthrough_provider.dart';
import 'package:journey_planner/services/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:trufi_core/base/utils/graphql_client/hive_init.dart';

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await initHiveForFlutter();
  Stripe.publishableKey =
      "pk_test_51KSjRkBYgfObXZIJgO2iZSgjKf2mecLP7jDBPe7vcn6EiZRM581fK8c2TjYXdEvbNQhnkMzP8dKeLSPLM3HfQWei00V33ZRrau";
  await Stripe.instance.applySettings();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(
    ChangeNotifierProvider(
      create: ((context) => WalkthroughProvider()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      catchError: (context, error) => null,
      value: FAS().user,
      initialData: null,
      child: MaterialApp(
        // home: RootNavigation(),
        home: WrapperForFirebase(),
        // home: TicketOverview(),
        // home: showHome ? Home() : Walkthrough(),
        // home: Walkthrough(),
        // home: RealTime(),
        // home: PlanRoute(),
        // home: Home(),
        // home: AvailableSeats(),
        theme: ThemeData(primarySwatch: Colors.deepPurple),
      ),
    );
  }
}
