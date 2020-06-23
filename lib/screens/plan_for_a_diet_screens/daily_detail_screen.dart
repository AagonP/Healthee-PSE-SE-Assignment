import 'package:flutter/material.dart';

import 'meal_food_list.dart';

class DailyDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final _index = routeArgs['index'];
    final _dietPlanData = routeArgs['dietPlanData'];

    // TODO: implement DailyDetailScreen build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Day $_index',
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
          MealFoodList(_index, 'Breakfast', _dietPlanData),
          MealFoodList(_index, 'Lunch', _dietPlanData),
          MealFoodList(_index, 'Dinner', _dietPlanData),
        ],
      ),
    );
  }
}
