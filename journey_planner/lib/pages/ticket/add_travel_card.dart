import 'package:flutter/material.dart';

class AddTravelCard extends StatefulWidget {
  AddTravelCard({Key? key}) : super(key: key);

  @override
  State<AddTravelCard> createState() => _AddTravelCardState();
}

class _AddTravelCardState extends State<AddTravelCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[400],
        elevation: 0.0,
        title: const Text('Add Travel Card'),
      ),
      body: Stack(),
    );
  }
}
