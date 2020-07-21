import 'package:flutter/material.dart';
import '../plan_for_a_diet_providers/diet_plan_data.dart';

class DailyDietItem extends StatefulWidget {
  final int _index;
  Color _itemColor = Colors.black;
  Color _backgroundColor = Colors.white;
  DietPlanData _dietPlanData;

  DailyDietItem(this._index, this._dietPlanData) {
    if (_dietPlanData.dailyList[_index - 1].isChecked == true) {
      _itemColor = Colors.green[600];
      _backgroundColor = Colors.green[100];
    } else {
      _itemColor = Colors.black;
      _backgroundColor = Colors.white;
    }
  }

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

    // TODO: implement DailyDietItem build
    return Container(
      decoration: BoxDecoration(
        color: widget._backgroundColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 10),
            blurRadius: 33,
            color: Color(0xFFD3D3D3).withOpacity(.84),
          ),
        ],
      ),
      child: GridTile(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(5.0),
              alignment: Alignment.center,
              child: Text(
                'Day ${widget._index}',
                style: TextStyle(
                  color: widget._itemColor,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: Divider(
                thickness: 1.0,
                color: widget._itemColor,
              ),
            ),
            Row(
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.search),
                  color: widget._itemColor,
                  onPressed: () => _clickDailyItem(context),
                ),
                IconButton(
                  icon: Icon(Icons.check_circle),
                  color: widget._itemColor,
                  onPressed: () {
                    setState(() {
                      if (widget._backgroundColor == Colors.white) {
                        widget._backgroundColor = Colors.green[100];
                        widget._itemColor = Colors.green[600];
                        widget._dietPlanData.checkDay(widget._index - 1);
                      } else {
                        widget._backgroundColor = Colors.white;
                        widget._itemColor = Colors.black;
                        widget._dietPlanData.uncheckDay(widget._index - 1);
                      }
                    });
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
