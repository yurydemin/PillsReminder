import 'package:pills_reminder/models/pills_event.dart';
import 'package:rxdart/subjects.dart';

class PillsBloc {
  final _events = BehaviorSubject<List<PillsEvent>>();

  final _time = BehaviorSubject<String>();
  final _description = BehaviorSubject<String>();
  final _isActive = BehaviorSubject<bool>();
  final _eventSaved = PublishSubject<bool>();
  final _event = BehaviorSubject<PillsEvent>();

  // Getters
  Stream<List<PillsEvent>> get events => _events.stream;
  Stream<String> get eventTime => _time.stream;
  Stream<String> get eventDescription => _description.stream;
  Stream<bool> get eventIsActive => _isActive.stream;
  Stream<bool> get eventSaved => _eventSaved.stream;
  //Future<PillsEvent> fetchEvent(String eventId) => db.fetchEvent(eventId);

  // Setters
  Function(List<PillsEvent>) get changeEvents => _events.sink.add;
  Function(String) get changeEventTime => _time.sink.add;
  Function(String) get changeEventDescription => _description.sink.add;
  Function(bool) get changeEventActive => _isActive.sink.add;
  Function(PillsEvent) get changeEvent => _event.sink.add;

  // Dispose
  dispose() {
    _events.close();
    _time.close();
    _description.close();
    _isActive.close();
    _eventSaved.close();
    _event.close();
  }

  // Functions
  Future<void> saveEvent() async {}
}
