import 'package:flutter/material.dart';

/// Shows two dialogs to choose a date and time.
Future<DateTime?> showDateTimePicker(
  BuildContext context, {
  required DateTime initialDate,
  required DateTime currentDate,
}) async {
  final date = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime(1900),
    lastDate: DateTime.now(),
    currentDate: currentDate,
  );

  if (date == null) return null;
  if (!context.mounted) return null;

  final time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(initialDate),
    initialEntryMode: TimePickerEntryMode.input,
  );

  if (time == null) return null;

  return DateTime(
    date.year,
    date.month,
    date.day,
    time.hour,
    time.minute,
  );
}
