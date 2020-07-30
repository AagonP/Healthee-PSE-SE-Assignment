import 'package:flutter/material.dart';

class ContainerRefactor extends StatelessWidget {
  final String title;
  final double amount;
  final String unit;

  ContainerRefactor(
      {@required this.title, @required this.amount, @required this.unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.star,
            color: Colors.yellow,
            size: 20.0,
          ),
          SizedBox(
            width: 5.0,
          ),
          Expanded(
            child: Text(
              title + amount.toString() + unit,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
