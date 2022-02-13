import 'package:flutter/material.dart';

class TopUpTravelCard extends StatefulWidget {
  const TopUpTravelCard({Key? key}) : super(key: key);

  @override
  State<TopUpTravelCard> createState() => _TopUpTravelCardState();
}

class _TopUpTravelCardState extends State<TopUpTravelCard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[400],
        elevation: 0.0,
        title: const Text('Top Up Travel Card'),
      ),
      body: Stack(),
    );
  }
}
