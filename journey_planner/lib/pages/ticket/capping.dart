import 'package:flutter/material.dart';

class Capping extends StatefulWidget {
  const Capping({Key? key}) : super(key: key);

  @override
  State<Capping> createState() => _CappingState();
}

class _CappingState extends State<Capping> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[400],
        elevation: 0.0,
        title: const Text('Capping'),
      ),
      body: Stack(),
    );
  }
}
