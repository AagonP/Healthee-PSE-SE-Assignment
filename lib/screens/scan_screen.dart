import 'package:flutter/material.dart';
<<<<<<< Updated upstream
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
=======
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'scan.dart';
>>>>>>> Stashed changes

class ScanView extends StatelessWidget
{
<<<<<<< Updated upstream
  String res ="";
  String scan="";

  Future scanner() async{
    scan = await FlutterBarcodeScanner.scanBarcode("#009922", "Cancel", true,  ScanMode.DEFAULT);
    setState(() {
      res = scan;
    });
  }
=======
>>>>>>> Stashed changes
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  
}
