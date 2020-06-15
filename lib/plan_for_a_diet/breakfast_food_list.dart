import 'package:flutter/material.dart';

class BreakfastFoodList extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: Icon(
                  Icons.wb_sunny,
                  color: Colors.red,
                ),
                padding: EdgeInsets.all(3.0),
              ),
              Text('Breakfast'),
            ],
          ),
        ],
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}
