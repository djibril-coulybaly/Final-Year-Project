import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:journey_planner/models/user.dart';
import 'package:journey_planner/pages/firebase_wrapper.dart';
import 'package:journey_planner/services/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value(
      catchError: (context, error) => null,
      value: FAS().user,
      initialData: null,
      child: const MaterialApp(
        home: WrapperForFirebase(),
      ),
    );
  }
}
