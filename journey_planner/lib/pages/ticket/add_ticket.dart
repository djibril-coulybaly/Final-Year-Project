import 'package:flutter/material.dart';

class AddTicket extends StatefulWidget {
  AddTicket({Key? key}) : super(key: key);

  @override
  State<AddTicket> createState() => _AddTicketState();
}

class _AddTicketState extends State<AddTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[400],
        elevation: 0.0,
        title: const Text('Add Ticket'),
      ),
      body: Stack(),
    );
  }
}
