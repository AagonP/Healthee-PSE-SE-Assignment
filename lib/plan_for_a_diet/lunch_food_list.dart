import 'package:flutter/material.dart';

class LunchFoodList extends StatelessWidget {

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
                  Icons.wb_cloudy,
                  color: Colors.lightBlueAccent,
                ),
                padding: EdgeInsets.all(3.0),
              ),
              Text('Lunch'),
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
