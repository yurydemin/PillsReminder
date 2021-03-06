import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pills_reminder/blocs/pills_bloc.dart';
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
    final bloc = Provider.of<PillsProvider>(context).bloc;
    return FutureBuilder<PillsEvent>(
      future: bloc.fetchEvent(widget.eventId),
      builder: (context, snapshot) {
        if (!snapshot.hasData && widget.eventId != null) {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        PillsEvent selectedEvent;
        if (widget.eventId == null) {
          // new event
          updateValues(bloc, null);
        } else {
          // edit event
          selectedEvent = snapshot.data;
          updateValues(bloc, selectedEvent);
        }

        return screenBody(bloc, selectedEvent, context);
      },
    );
  }
}

Scaffold screenBody(PillsBloc bloc, PillsEvent event, BuildContext context) {
  var scaffoldTitle = (event == null) ? 'Add new event' : 'Edit event';
  return Scaffold(
    appBar: AppBar(
      title: Text(scaffoldTitle),
      centerTitle: true,
      leading: GestureDetector(
        child: Icon(Icons.arrow_back),
        onTap: () {
          Navigator.of(context).pop();
        },
      ),
    ),
    //body:
  );
}

updateValues(PillsBloc bloc, PillsEvent event) {
  bloc.changeEvent(event);
  if (event == null) {
    bloc.changeEventTime(null);
    bloc.changeEventDescription(null);
    bloc.changeEventActive(false);
  } else {
    bloc.changeEventTime(event.timeOfDay);
    bloc.changeEventDescription(event.description);
    bloc.changeEventActive(event.isActive);
  }
}
