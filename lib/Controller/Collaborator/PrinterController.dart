import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrinterController extends GetxController {
  final FocusNode focus = FocusNode();
  var selectedPrinter = "HP Wireless Printer".obs;
  List printer = ["HP Wireless Printer", "Canon Printer", "Canon Printer 2", "XYZ Printer"];
}
