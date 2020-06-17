import 'package:flutter/material.dart';

import '../plan_for_a_diet_screens/plan_for_a_diet_providers/diet_plan_data.dart';
class MealFoodList extends StatelessWidget {
  final String _mealType;
  final int _index;
  DietPlanData _dietPlanData;

  MealFoodList(this._index, this._mealType, this._dietPlanData);

  Widget identifyMealIcon() {
    if (_mealType == 'Breakfast') {
      return Icon(
      Icons.brightness_6,
      color: Colors.yellowAccent,
      );
      }

    else if (_mealType == 'Lunch') {
          return Icon(
            Icons.brightness_5,
            color: Colors.redAccent,
          );
      }

    else {
        return Icon(
          Icons.brightness_4,
          color: Colors.blueGrey,
        );
    }
  }



  @override
  Widget build(BuildContext context) {
    final Widget mealIcon = identifyMealIcon();

    // TODO: implement build
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(5.0),
            child: Row(
              children: <Widget>[
                mealIcon,
                Text(_dietPlanData.dailyList[_index].calory.toString()),
              ],
            ),
          ),
        ],
      ),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }
}
