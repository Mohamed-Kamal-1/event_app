import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateExtensions on DateTime {
  String format() {
    final DateFormat customFormatter = DateFormat('yyyy/MM/dd');
    return customFormatter.format(this);
  }

  String formatMonth() {
    final DateFormat customFormatter = DateFormat('MMM');
    return customFormatter.format(this);
  }
}

extension DateTimeExtensions on TimeOfDay? {
  DateTime? changeTimeToDateTime(
    DateTime? selectedDate,
    TimeOfDay? selectedTime,
  ) {
    return DateTime(
      selectedDate!.year,
      selectedDate.month,
      selectedDate.day,
      selectedTime!.hour,
      selectedTime.minute,
    );
  }
}
