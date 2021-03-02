import 'package:flutter/material.dart';

class PillsEvent {
  final UniqueKey id;
  final String timeOfDay;
  final String description;
  bool isActive;

  PillsEvent({
    @required this.id,
    @required this.timeOfDay,
    @required this.description,
    @required this.isActive,
  });

  activate() {
    isActive = !isActive;
  }
}
