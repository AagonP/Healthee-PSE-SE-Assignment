import 'package:flutter/material.dart';

import 'meal_food_list.dart';
/*import '../../plan_for_a_diet/dinner_food_list.dart';
import '../../plan_for_a_diet/daily_total_list.dart';
import '../../plan_for_a_diet/shop_list.dart';*/

class DailyDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, int>;
    final _index = routeArgs['index'];

    // TODO: implement DailyDetailScreen build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Day ${_index}',
          style: TextStyle(
            fontSize: 30,
            letterSpacing: 2.0,
          ),
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          SizedBox(
            height: 5.0,
          ),
          MealFoodList('Breakfast'),
          MealFoodList('Lunch'),
          MealFoodList('Dinner'),
        ],
      ),
    );
  }
}
