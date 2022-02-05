import 'package:flutter/material.dart';
import 'package:journey_planner/services/firebase_auth.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  final FAS _auth = FAS();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        title: const Text('Home Dashboard'),
        backgroundColor: Colors.lightBlue[400],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            icon: const Icon(Icons.person),
            label: const Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}
