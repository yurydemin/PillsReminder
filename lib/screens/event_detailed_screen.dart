import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pills_reminder/blocs/events_bloc.dart';
import 'package:pills_reminder/models/pills_event.dart';
import 'package:provider/provider.dart';
import 'package:date_format/date_format.dart';

class EventDetailedScreen extends StatefulWidget {
  final String eventId;
  EventDetailedScreen({this.eventId});

  @override
  _EventDetailedScreenState createState() => _EventDetailedScreenState();
}

class _EventDetailedScreenState extends State<EventDetailedScreen> {
  String _hour, _minute, _time;
  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  // TextEditingController _timeController = TextEditingController();
  // TextEditingController _descriptionController = TextEditingController();

  Future<Null> _selectTime(BuildContext context) async {
    final bloc = Provider.of<EventsBloc>(context, listen: false);
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      selectedTime = picked;
      _hour = selectedTime.hour.toString();
      _minute = selectedTime.minute.toString();
      _time = _hour + ' : ' + _minute;
      bloc.changeEventTime(_time);
      setState(() {});
      // setState(() {
      //   selectedTime = picked;
      //   _hour = selectedTime.hour.toString();
      //   _minute = selectedTime.minute.toString();
      //   _time = _hour + ' : ' + _minute;
      //   _timeController.text = _time;
      //   _timeController.text = formatDate(
      //       DateTime(2021, 01, 1, selectedTime.hour, selectedTime.minute),
      //       [hh, ':', nn, " ", am]).toString();
      // });
    }
  }

  @override
  void initState() {
    final bloc = Provider.of<EventsBloc>(context, listen: false);
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
  void dispose() {
    // _timeController.dispose();
    // _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<EventsBloc>(context);
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

        var scaffoldTitle =
            (selectedEvent == null) ? 'Add new event' : 'Edit event';
        // _descriptionController.text =
        //     (selectedEvent == null) ? null : selectedEvent.description;
        // _timeController.text =
        //     (selectedEvent == null) ? null : selectedEvent.timeOfDay;

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
          body: ListView(
            children: <Widget>[
              StreamBuilder<String>(
                stream: bloc.eventDescription,
                builder: (context, snapshot) {
                  return TextFormField(
                    decoration: InputDecoration(hintText: 'Event description'),
                    keyboardType: TextInputType.text,
                    //controller: _descriptionController,
                    initialValue: snapshot.data,
                    onChanged: (value) {
                      bloc.changeEventDescription(value);
                    },
                  );
                },
              ),
              StreamBuilder<String>(
                stream: bloc.eventTime,
                builder: (context, snapshot) {
                  return InkWell(
                    onTap: () {
                      _selectTime(context);
                    },
                    child: TextFormField(
                      // onChanged: (value) {
                      //   bloc.changeEventTime(value);
                      // },
                      initialValue: snapshot.data,
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      //controller: _timeController,
                      decoration: InputDecoration(
                          disabledBorder:
                              UnderlineInputBorder(borderSide: BorderSide.none),
                          contentPadding: EdgeInsets.all(5)),
                    ),
                  );
                },
              ),
              StreamBuilder<bool>(
                stream: bloc.isValid,
                builder: (context, snapshot) {
                  return RaisedButton(
                    child: Text('Save'),
                    disabledColor: Colors.black12,
                    disabledTextColor: Colors.blueGrey,
                    onPressed: (snapshot.data == true) ? bloc.saveEvent : null,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

updateValues(EventsBloc bloc, PillsEvent event) {
  bloc.changeEvent(event);
  if (event == null) {
    bloc.changeEventTime(null);
    bloc.changeEventDescription(null);
    bloc.changeEventActive(true);
  } else {
    bloc.changeEventTime(event.timeOfDay);
    bloc.changeEventDescription(event.description);
    bloc.changeEventActive(event.isActive);
  }
}
