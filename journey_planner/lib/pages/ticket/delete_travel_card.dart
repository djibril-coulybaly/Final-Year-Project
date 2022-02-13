import 'package:flutter/material.dart';

class DeleteTravelCard extends StatefulWidget {
  DeleteTravelCard({Key? key}) : super(key: key);

  @override
  State<DeleteTravelCard> createState() => _DeleteTravelCardState();
}

class _DeleteTravelCardState extends State<DeleteTravelCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[400],
        elevation: 0.0,
        title: const Text('Delete Travel Card'),
      ),
      body: Stack(),
    );
  }
}
