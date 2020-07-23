import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class Scan {
  static String key;
  static Future <void> scanner() async {
    key = await FlutterBarcodeScanner.scanBarcode(
        "#009922", "Cancel", true, ScanMode.DEFAULT);
  }
}
