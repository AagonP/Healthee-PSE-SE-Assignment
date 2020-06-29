import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/daily_diet_item.dart';

class DietTimetableScreen extends StatelessWidget {
  final _oneMonthList = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30
  ];

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;


    // TODO: implement build of DietTimetableScreen
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight / 3.1),
        child: Stack(
          children: <Widget>[
            Container(
              height: screenHeight / 2.8,
              child: Image.network(
                'https://resources.healthydirections.com/resources/web/articles/hd/hd-what-is-the-best-heart-healthy-diet-plan-hd-cover.jpg',
                fit: BoxFit.fitHeight,
              ),
            ),
            AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text(''),
            ),
          ],
        ),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                  ),
                ),
              ),
              child: Text(
                '30 Days Diet Plan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 33.0,
                  //decoration: TextDecoration.underline,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Card(
                  child: IconButton(
                    icon: Icon(Icons.timer),
                    onPressed: () {},
                  ),
                  color: Colors.white60,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ],
            ),
            Expanded(
              child: GridView(
                shrinkWrap: true,
                children: _oneMonthList
                    .map(
                      (index) => DailyDietItem(index),
                    )
                    .toList(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
              ),
            ),
          ],
        ),
        // padding: EdgeInsets.all(5.0),
      ),
    );
  }
}
