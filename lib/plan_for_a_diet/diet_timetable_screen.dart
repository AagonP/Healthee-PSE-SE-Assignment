import 'package:flutter/material.dart';

import 'daily_diet_item.dart';

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
    // TODO: implement build of DietTimetableScreen
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              child: Image.network(
                'https://media.istockphoto.com/photos/healthy-food-for-balanced-flexitarian-mediterranean-diet-concept-picture-id1159204281?b=1&k=6&m=1159204281&s=170667a&w=0&h=LISnM5xaG7Lok26Qp542LGFtrbGynJB8PRnvHCb3sQ0=',
                height: 325,
              ),
            ),
            Text(
              '30 Days Diet Plan',
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
            Row(
              children: <Widget>[
                Text(
                  'You chose to follow available plan',
                ),
                Text(
                  'Reminder icon here!',
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
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
              ),
            ),
          ],
        ),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
    );
  }
}