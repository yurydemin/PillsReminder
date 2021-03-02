import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pills_reminder/models/pills_event.dart';
import 'package:pills_reminder/providers/pills_provider.dart';
import 'package:provider/provider.dart';

class EventDetailedScreen extends StatefulWidget {
  final String eventId;
  EventDetailedScreen({this.eventId});

  @override
  _EventDetailedScreenState createState() => _EventDetailedScreenState();
}

class _EventDetailedScreenState extends State<EventDetailedScreen> {
  @override
  void initState() {
    final bloc = Provider.of<PillsProvider>(context).bloc;
    bloc.eventSaved.listen((saved) {
      if (saved != null && saved == true && context != null) {
        Fluttertoast.showToast(
          msg: 'Event saved',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.lightBlue,
          textColor: Colors.white,
          fontSize: 16.0,
        );

        Navigator.of(context).pop();
      }
    });
    super.initState();
  }

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
