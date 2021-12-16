import 'package:flutter/material.dart';

extension TimeInMinutes on TimeOfDay {
  int get inMinutes => hour * TimeOfDay.minutesPerHour + minute;

  static TimeOfDay toTimeOfDay(int minutes) => TimeOfDay(
        hour: minutes ~/ TimeOfDay.minutesPerHour,
        minute: minutes % TimeOfDay.minutesPerHour,
      );
}
