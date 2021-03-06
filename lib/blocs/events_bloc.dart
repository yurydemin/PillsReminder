import 'package:flutter/material.dart';
import 'package:pills_reminder/models/pills_event.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class EventsBloc {
  final _eventsStorage = BehaviorSubject<List<PillsEvent>>();
  final _time = BehaviorSubject<String>();
  final _description = BehaviorSubject<String>();
  final _isActive = BehaviorSubject<bool>();
  final _eventSaved = PublishSubject<bool>();
  final _event = BehaviorSubject<PillsEvent>();

  EventsBloc() {
    // load events from db
    // changeEvents(db.loadEvents());
    changeEvents(List<PillsEvent>());
  }

  // Getters
  Stream<List<PillsEvent>> get events => _eventsStorage.stream;
  Stream<String> get eventTime => _time.stream;
  Stream<String> get eventDescription => _description.stream;
  Stream<bool> get eventIsActive => _isActive.stream;
  Stream<bool> get isValid =>
      CombineLatestStream.combine2(eventDescription, eventTime, (a, b) => true);
  Stream<bool> get eventSaved => _eventSaved.stream;

  // Setters
  Function(List<PillsEvent>) get changeEvents => _eventsStorage.sink.add;
  Function(String) get changeEventTime => _time.sink.add;
  Function(String) get changeEventDescription => _description.sink.add;
  Function(bool) get changeEventActive => _isActive.sink.add;
  Function(PillsEvent) get changeEvent => _event.sink.add;

  // Dispose
  dispose() {
    _eventsStorage.close();
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
    var events = _eventsStorage.value;
    var ndx = events.indexWhere((element) => element.id == event.id);
    if (ndx == -1)
      events.add(event);
    else
      events[ndx] = event;
    changeEvents(events);
    _eventSaved.sink.add(true);
  }

  Future<PillsEvent> fetchEvent(String eventId) async {
    return _eventsStorage.value
        .firstWhere((element) => element.id.toString() == eventId);
  }
}
