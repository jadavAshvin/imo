import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateFormat dateFormat = DateFormat("yyyy-MM-dd");
DateFormat dateFormatshow = DateFormat("dd/MM/yyyy");
DateFormat dateFormatAlphabet = DateFormat.yMMMMd();

Future<DateTime> selectDate(BuildContext context, {DateTime? initialDate, required DateTime currentDate, DateTime? lastDate}) async {
  if (initialDate != null) {
    if (currentDate.isBefore(initialDate)) {
      currentDate = initialDate;
    }
  }
  final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: initialDate == null ? DateTime(2017) : initialDate,
      lastDate: lastDate == null ? DateTime(2501) : lastDate);
  if (picked != null) {
    return picked;
  } else {
    return currentDate;
  }
}

String reverse(String? string) {
  if (string == null) {
    throw ArgumentError.notNull('string');
  }

  if (string.length < 2) {
    return string;
  }

  final characters = Characters(string);
  return characters.toList().reversed.join();
}
