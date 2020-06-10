import 'package:flutter/material.dart';
import './assets/my_flutter_app_icons.dart';

class DinnerFoodList extends StatelessWidget {

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
                  MyFlutterApp.brightness_4,
                  color: Colors.grey,
                ),
                padding: EdgeInsets.all(3.0),
              ),
              Text('Dinner'),
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
