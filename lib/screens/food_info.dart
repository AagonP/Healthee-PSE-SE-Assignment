import 'dart:io';

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
              Image(
                image: (product.photoURL != null)
                    ? NetworkImage(product.photoURL)
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
            GridView.count(
              childAspectRatio: 11,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 1,
              children: List.generate(product.ingredients.length, (index) {
                return Container(
                  height: 100.0,
                  margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                  child: Wrap(
                    //crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.star,
                        color: Color(0xFFEFED99),
                        size: 20.0,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      AutoSizeText(
                        product.ingredients.elementAt(index),
                        style: TextStyle(fontSize: 18.0),
                        maxLines: 2,
                      ),
                      Text(
                        ':',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      AutoSizeText(
                        product.amount.elementAt(index),
                        style: TextStyle(fontSize: 18.0),
                        maxLines: 2,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      AutoSizeText(
                        product.unit.elementAt(index),
                        style: TextStyle(fontSize: 18.0),
                        maxLines: 2,
                      ),
                    ],
                  ),
                );
              }),
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
                  'Characteristics',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Container(
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
                        'vegetarian:',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        product.vegetarian ? 'true' : 'false',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                Container(
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
                        'glutenFree:',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        product.glutenFree ? 'true' : 'false',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                Container(
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
                        'dairyFree:',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        product.dairyFree ? 'true' : 'false',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                Container(
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
                        'cheap:',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        product.cheap ? 'true' : 'false',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                Container(
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
                        'popular:',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        product.popular ? 'true' : 'false',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
                  ),
                ),
                Container(
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
                        'lowFodMap:',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        product.lowFodmap ? 'true' : 'false',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ],
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
