import 'package:flutter/material.dart';
import 'package:pse_assignment/models/product.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FoodInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(children: <Widget>[
              Image(image: NetworkImage(product.photoURL)),
              Align(
                alignment: Alignment(-1.15, -1.0),
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    size: 30.0,
                  ),
                ),
              ),
            ]),
            SizedBox(
              height: 10.0,
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
            Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ingredients',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}

class Ingredients extends StatelessWidget {
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
        ],
      ),
    );
  }
}
