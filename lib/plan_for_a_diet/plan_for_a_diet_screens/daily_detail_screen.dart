import 'package:flutter/material.dart';
import '../plan_for_a_diet_providers/diet_plan_data.dart';
import 'package:provider/provider.dart';
import '../plan_for_a_diet_widgets/meal_food_list.dart';

class DailyDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final index = routeArgs['index'];
    final dietPlanData = Provider.of<DietPlanData>(context);

    // TODO: implement DailyDetailScreen build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Day $index',
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
          MealFoodList(index, 0, 'Breakfast', dietPlanData),
          MealFoodList(index, 1, 'Lunch', dietPlanData),
          MealFoodList(index, 2, 'Dinner', dietPlanData),
          Card(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.format_list_bulleted,
                        color: Colors.lightBlueAccent,
                      ),
                      Text(
                        'Daily nutrients:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pacifico',
                          letterSpacing: 2.0,
                          fontSize: 15.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 30,
                    ),
                    Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 2.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Calories: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            '${dietPlanData.dailyList[index - 1].calory} (calories)'),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 30,
                    ),
                    Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 2.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Protein: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            '${dietPlanData.dailyList[index - 1].protein} (g)'),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      width: 30,
                    ),
                    Icon(
                      Icons.star,
                      size: 18,
                      color: Colors.yellow,
                    ),
                    SizedBox(
                      width: 2.0,
                    ),
                    Row(
                      children: <Widget>[
                        Text(
                          'Fat: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                            '${dietPlanData.dailyList[index - 1].fat} (g)'),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 30,
                      ),
                      Icon(
                        Icons.star,
                        size: 18,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 2.0,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            'Carbohydrates: ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                              '${dietPlanData.dailyList[index - 1].carbohydrate} (g)'),
                        ],
                      ),
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
