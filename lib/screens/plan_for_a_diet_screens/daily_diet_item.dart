import 'package:flutter/material.dart';
import '../plan_for_a_diet_screens/plan_for_a_diet_providers/diet_plan_data.dart';

class DailyDietItem extends StatelessWidget {
  final int _index;
  final DietPlanData _dietPlanData;

  DailyDietItem(this._index, this._dietPlanData);

  void _clickDailyItem(BuildContext context) {
    Navigator.of(context).pushNamed(
      '/daily-detail-screen',
      arguments: {
        'index': _index,
        'dietPlanData': _dietPlanData,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // TODO: implement DailyDietItem build
    return Card(
      child: GridTile(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              height: screenHeight / 15,
              child: Text('Day $_index'),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(2.0, 7.0, 2.0, 0.0),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.search),
                    iconSize: screenWidth / 17,
                    onPressed: () => _clickDailyItem(context),
                  ),
                  IconButton(
                    icon: Icon(Icons.check_circle),
                    iconSize: screenWidth / 17,
                    onPressed: () {},
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
