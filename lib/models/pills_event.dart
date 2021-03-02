import 'package:flutter/material.dart';

class PillsEvent {
  final UniqueKey id;
  final TimeOfDay time;
  final String description;
  bool isActive;

  PillsEvent({this.id, this.time, this.description, this.isActive});

  activate() {
    isActive = !isActive;
  }
}
