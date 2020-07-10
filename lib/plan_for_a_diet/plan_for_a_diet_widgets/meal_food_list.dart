import 'package:flutter/material.dart';

import '../plan_for_a_diet_providers/diet_plan_data.dart';

class MealFoodList extends StatelessWidget {
  final String _mealType;
  final int _index;
  final int _mealTypeIndex;
  DietPlanData _dietPlanData;

  MealFoodList(
      this._index, this._mealTypeIndex, this._mealType, this._dietPlanData);

  Widget identifyMealIcon() {
    if (_mealType == 'Breakfast') {
      return Icon(
        Icons.brightness_6,
        color: Colors.yellowAccent,
      );
    } else if (_mealType == 'Lunch') {
      return Icon(
        Icons.brightness_5,
        color: Colors.redAccent,
      );
    } else {
      return Icon(
        Icons.brightness_4,
        color: Colors.blueGrey,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget mealIcon = identifyMealIcon();
    var screenWidth = MediaQuery.of(context).size.width;

    // TODO: implement build
    return Card(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
            child: Row(
              children: <Widget>[
                mealIcon,
                Text(_mealType),
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
                color: Colors.lightBlueAccent,
              ),
              Text(
                '${_dietPlanData.dailyList[_index - 1].threeMeals[_mealTypeIndex].title}',
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 15.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.network(
                _dietPlanData
                    .dailyList[_index - 1].threeMeals[_mealTypeIndex].imageUrl,
              ),
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
