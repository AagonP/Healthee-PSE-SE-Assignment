import 'package:flutter/material.dart';

import 'breakfast_food_list.dart';
import 'lunch_food_list.dart';
import 'dinner_food_list.dart';
import 'daily_total_list.dart';
import 'shop_list.dart';

class DailyDetailScreen extends StatelessWidget {
  final int _index;

  @override
  Widget build(BuildContext context) {
    // TODO: implement DailyDetailScreen build
    return Scaffold(
      appBar: AppBar(
        title: Text('Day ${_index}'),
      ),
      body: ListView(
        children: <Widget>[
          BreakfastFoodList(),
          LunchFoodList(),
          DinnerFoodList(),
          DailyTotalList(),
          ShopList(),
        ],
      ),
    );
  }
}
