import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../plan_for_a_diet_widgets/meal_food_list.dart';
import '../plan_for_a_diet_providers/diet_plan_data.dart';

class DailyDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    var screenWidth = MediaQuery.of(context).size.width;
    final _index = routeArgs['index'];
    final _dietPlanData = Provider.of<DietPlanData>(context);

    // TODO: implement DailyDetailScreen build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Day $_index',
          style: TextStyle(
            fontFamily: 'Pacifico',
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
          MealFoodList(_index, 0, 'Breakfast', _dietPlanData),
          MealFoodList(_index, 1, 'Lunch', _dietPlanData),
          MealFoodList(_index, 2, 'Dinner', _dietPlanData),
          Card(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.format_list_bulleted,
                        color: Colors.lightBlueAccent,
                      ),
                      Text('Daily Nutrients:'),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 30,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellowAccent,
                      ),
                      Text('Calories: ${_dietPlanData.dailyList[_index - 1].calory}'),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 30,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellowAccent,
                      ),
                      Text('Protein: ${_dietPlanData.dailyList[_index - 1].protein}'),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 30,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellowAccent,
                      ),
                      Text('Fat: ${_dietPlanData.dailyList[_index - 1].fat}'),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 30,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellowAccent,
                      ),
                      Text('Carbohydrates: ${_dietPlanData.dailyList[_index - 1].carbohydrate}'),
                    ],
                  ),
                ),
              ],
            ),
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          )
        ],
      ),
    );
  }
}
