import 'package:flutter/material.dart';
import 'package:pills_reminder/blocs/pills_bloc.dart';

class PillsProvider with ChangeNotifier {
  PillsBloc _bloc;
  PillsBloc get bloc => _bloc;

  PillsProvider() {
    _bloc = PillsBloc();
  }
}
