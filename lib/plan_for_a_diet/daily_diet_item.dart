import 'package:flutter/material.dart';

class DailyDietItem extends StatelessWidget {
  final int _index;

  DailyDietItem(this._index);

  @override
  Widget build(BuildContext context) {
    // TODO: implement DailyDietItem build
    return Card(
      child: GridTile(
        child: Container(
          child: Text('Day ${_index}'),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(Icons.search),
            iconSize: 30.0,
            onPressed: () {},
          ),
          trailing: IconButton(
            icon: Icon(Icons.check_circle),
            iconSize: 30.0,
            onPressed: () {},
          ),
        ),
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}

/*return Card(
      child: Column(
        children: <Widget>[
          Container(
            height: 58.0,
            child: Container(
              child: Text('Day ${_index}'),
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
      ),*/
