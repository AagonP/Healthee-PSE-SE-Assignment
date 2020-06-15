import 'package:flutter/material.dart';

class PlanningOptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement screen to ask user for planing option
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Plan For A Diet',
          style: TextStyle(
            fontSize: 30,
            letterSpacing: 2.0,
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50,
            child: Image.network(
                'https://www.hindustantimes.com/rf/image_size_960x540/HT/p2/2018/07/05/Pictures/_a021f0b0-8046-11e8-8bd0-affd130bd192.jpg'),
          ),
          Card(
            elevation: 5,
            child: Row(
              children: <Widget>[
                Icon(Icons.grid_on),
                Text(
                  'Follow Available Plan',
                  style: TextStyle(
                    fontSize: 27,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
          ),
          Card(
            elevation: 5,
            child: Row(
              children: <Widget>[
                Icon(Icons.mode_edit),
                Text(
                  'Make Your Own Plan',
                  style: TextStyle(
                    fontSize: 27,
                    letterSpacing: 2.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
