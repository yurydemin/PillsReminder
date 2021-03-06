import 'package:flutter/material.dart';
import 'package:pills_reminder/models/pills_event.dart';
import 'package:pills_reminder/services/database_service.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class EventsBloc {
  final db = DatabaseService();

  final _time = BehaviorSubject<String>();
  final _description = BehaviorSubject<String>();
  final _isActive = BehaviorSubject<bool>();
  final _eventSaved = PublishSubject<bool>();
  final _event = BehaviorSubject<PillsEvent>();

  // Getters
  Stream<List<PillsEvent>> get events => db.fetchEvents().asStream();
  Stream<String> get eventTime => _time.stream;
  Stream<String> get eventDescription => _description.stream;
  Stream<bool> get eventIsActive => _isActive.stream;
  Stream<bool> get isValid =>
      CombineLatestStream.combine2(eventDescription, eventTime, (a, b) => true);
  Stream<bool> get eventSaved => _eventSaved.stream;
  // Future<PillsEvent> fetchEvent(String eventId) => events.first.then((mylist) =>
  //     mylist.firstWhere((element) => element.id.toString() == eventId));
  Future<PillsEvent> fetchEvent(String eventId) => db.fetchEvent(eventId);

  // Setters
  //Function(List<PillsEvent>) get changeEvents => _events.sink.add;
  Function(String) get changeEventTime => _time.sink.add;
  Function(String) get changeEventDescription => _description.sink.add;
  Function(bool) get changeEventActive => _isActive.sink.add;
  Function(PillsEvent) get changeEvent => _event.sink.add;

  // Dispose
  dispose() {
    //_events.close();
    _time.close();
    _description.close();
    _isActive.close();
    _eventSaved.close();
    _event.close();
  }

  // Functions
  Future<void> saveEvent() async {
    var event = PillsEvent(
      id: (_event.value == null) ? UniqueKey() : _event.value.id,
      timeOfDay: _time.value,
      description: _description.value,
      isActive: (_event.value == null) ? true : _event.value.isActive,
    );
    //_events.value.add(event);
    return db
        .setEvent(event)
        .then((value) => _eventSaved.sink.add(true))
        .catchError((error) => _eventSaved.sink.add(false));
  }
}
