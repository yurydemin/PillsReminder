import 'package:pills_reminder/models/pills_event.dart';
import 'package:rxdart/subjects.dart';

class PillsBloc {
  final _events = BehaviorSubject<List<PillsEvent>>();

  // Getters
  Stream<List<PillsEvent>> get events => _events.stream;

  // Setters
  Function(List<PillsEvent>) get changeEvents => _events.sink.add;

  // Dispose
  dispose() {
    _events.close();
  }
}
