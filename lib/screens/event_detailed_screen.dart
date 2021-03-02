import 'package:flutter/material.dart';
import 'package:pills_reminder/models/pills_event.dart';

class EventDetailedScreen extends StatelessWidget {
  final PillsEvent event;

  const EventDetailedScreen({@required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add new Event'),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
