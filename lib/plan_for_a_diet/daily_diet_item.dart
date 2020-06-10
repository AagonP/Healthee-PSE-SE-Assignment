import 'package:flutter/material.dart';

class DailyDietItem extends StatelessWidget {
  final int _index;

  DailyDietItem(this._index);

  @override
  Widget build(BuildContext context) {
    // TODO: implement DailyDietItem build
    return Container(
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              height: 58.0,
              child: FlatButton(
                child: Text('Day ${_index}'),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    iconSize: 30.0,
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(Icons.check_circle),
                    iconSize: 30.0,
                    onPressed: () {},
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ],
        ),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}
