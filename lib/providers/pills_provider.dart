import 'package:flutter/material.dart';
import 'package:pills_reminder/blocs/events_bloc.dart';

class PillsProvider with ChangeNotifier {
  EventsBloc _bloc;
  EventsBloc get bloc => _bloc;

  PillsProvider() {
    _bloc = EventsBloc();
  }
}
