import 'package:flutter/material.dart';
//import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanScreen extends StatefulWidget{
  @override
  _Scan createState() => _Scan();
}

class _Scan extends State<ScanScreen>
{
  String res ="";
  String scan="";

  Future scanner() async{
    /*scan = await FlutterBarcodeScanner.scanBarcode("#009922", "Cancel", true,  ScanMode.DEFAULT);
    setState(() {
      res = scan;
    });*/
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("QR and Barcode Scan"),),
      body: Center(
        child: Column(
          children: <Widget>[
            FloatingActionButton(
              child: Text("Scan"),
              onPressed: (){scanner();},
            ),
            Text(res)
          ],
        ),
      ),
    );
  }
}
