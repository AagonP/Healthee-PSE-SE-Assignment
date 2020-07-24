import 'package:pse_assignment/models/product.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'scan.dart';

class ScanView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ScanProduct product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(children: <Widget>[
                Image(
                  image: (product.image != null)
                      ? NetworkImage(product.image)
                      : AssetImage('image/wp-header-logo-21.png'),
                ),
                Align(
                  alignment: Alignment(-1.15, -1.0),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 30.0,
                      color: Colors.white,
                    ),
                ))]
              ),
            SizedBox(
              height: 10.0
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 15.0,
              ),
              child: Align(
                alignment: Alignment.center,
                child: AutoSizeText(
                  product.name,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                ),
                  minFontSize: 15.0,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
              ),
            ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0),
              height: 20.0,
              width: double.infinity,
              child: Divider(
                color: Colors.teal.shade200,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15.0),
              child: Align(
              alignment: Alignment.centerLeft,
                 child: Text(
                'Nutrition Facts',
                style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),

        ],

          ),
        ),
      ),
    );
  }
}

class ContainerRefactor extends StatelessWidget {
  final String title;
  final String value;
  ContainerRefactor({@required this.title, @required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Color(0xFFEFED99),
            size: 20.0,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}



