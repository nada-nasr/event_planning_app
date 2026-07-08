import 'package:flutter/material.dart';

import '../model/event.dart';

class EventProvider with ChangeNotifier {
  Event? selectedEvent;

  void setSelectedEvent(Event event) {
    selectedEvent = event;
    notifyListeners();
  }
}
