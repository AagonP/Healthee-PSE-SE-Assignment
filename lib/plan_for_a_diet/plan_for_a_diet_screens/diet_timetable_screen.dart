import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../plan_for_a_diet_providers/diet_plan_data.dart';
import 'package:provider/provider.dart';
import '../plan_for_a_diet_widgets/daily_diet_item.dart';

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
    final dietPlanData = Provider.of<DietPlanData>(context);

    // TODO: implement build of DietTimetableScreen
    return Scaffold(
      backgroundColor: Color(0xFFD3D3D3).withOpacity(.84),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight / 3.1),
        child: Stack(
          children: <Widget>[
            Container(
              height: screenHeight / 2.8,
              child: Image.asset(
                'image/30_day_picture.jpg',
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
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xFFFCECC5),
              ),
              child: Text(
                '30-Day Diet Plan',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Pacifico',
                  letterSpacing: 2.0,
                  fontSize: 33.0,
                  color: Color(0xFF07084B),
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Color(0xFFD3D3D3).withOpacity(.84),
                ),
                child: GridView(
                  shrinkWrap: true,
                  children: _oneMonthList
                      .map(
                        (index) => DailyDietItem(index, dietPlanData),
                      )
                      .toList(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
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
