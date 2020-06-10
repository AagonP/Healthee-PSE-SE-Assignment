import 'package:flutter/material.dart';

import 'breakfast_food_list.dart';
import 'lunch_food_list.dart';
import 'dinner_food_list.dart';
import 'daily_total_list.dart';
import 'shop_list.dart';

class DailyFoodListScreen extends StatelessWidget {
  final int _index;

  @override
  Widget build(BuildContext context) {
    // TODO: implement DailyFoodListScreen build
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day ${_index}'),
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
