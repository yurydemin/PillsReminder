import 'package:pills_reminder/models/pills_event.dart';

class DatabaseService {
  // Todo replace with local db

  var _eventsStorage = List<PillsEvent>();

  Future<void> setEvent(PillsEvent event) async {
    var ndx = _eventsStorage.indexWhere((element) => element.id == event.id);
    if (ndx == -1)
      _eventsStorage.add(event);
    else
      _eventsStorage[ndx] = event;
  }

  Future<PillsEvent> fetchEvent(String eventId) async {
    return _eventsStorage
        .firstWhere((element) => element.id.toString() == eventId);
  }

  Future<List<PillsEvent>> fetchEvents() async {
    return _eventsStorage;
  }
}
