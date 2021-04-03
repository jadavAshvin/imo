import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

DateFormat dateFormat = DateFormat("dd-MM-yyyy");
DateFormat dateFormatUpload = DateFormat("yyyy-MM-dd");
Future<String> selectDate(BuildContext context) async {
  final DateTime picked = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2015, 8), lastDate: DateTime(2501));
  // Get.snackbar('Date Picked', dateFormat.format(picked), snackPosition: SnackPosition.BOTTOM);
  return dateFormat.format(picked);
}
