import 'package:flutter/material.dart';


class DailyDietItem extends StatefulWidget {
  final int _index;
  Color _itemColor = Colors.black;
  Color _backgroundColor = Colors.white;

  DailyDietItem(this._index);

  @override
  _DailyDietItemState createState() => _DailyDietItemState();
}

class _DailyDietItemState extends State<DailyDietItem> {
  void _clickDailyItem(BuildContext context) {
    Navigator.of(context).pushNamed(
      '/daily-detail-screen',
      arguments: {
        'index': widget._index,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // TODO: implement DailyDietItem build
    return Card(
      color: widget._backgroundColor,
      child: GridTile(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: screenHeight / 15,
              child: Text(
                'Day ${widget._index}',
                style: TextStyle(
                  color: widget._itemColor,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(2.0, 7.0, 2.0, 0.0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: widget._itemColor,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    color: widget._itemColor,
                    iconSize: screenWidth / 17,
                    onPressed: () => _clickDailyItem(context),
                  ),
                  IconButton(
                    icon: Icon(Icons.check_circle),
                    color: widget._itemColor,
                    iconSize: screenWidth / 17,
                    onPressed: () {
                      setState(() {
                        if (widget._backgroundColor == Colors.white) {
                          widget._backgroundColor = Colors.green[100];
                          widget._itemColor = Colors.green[600];
                        } else {
                          widget._backgroundColor = Colors.white;
                          widget._itemColor = Colors.black;
                        }
                      });
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ],
        ),
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}
