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
        color: Colors.yellow,
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

    // TODO: implement build
    return Card(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                mealIcon,
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  _mealType,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Pacifico',
                    letterSpacing: 2.0,
                    fontSize: 15.0,
                  ),
                ),
                Expanded(
                  child: IconButton(
                    alignment: Alignment.centerRight,
                    icon: Icon(
                      Icons.mode_edit,
                      size: 20,
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed('/search-food-for-plan-screen');
                    },
                  ),
                )
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 30,
              ),
              Icon(
                Icons.star,
                size: 18,
                color: Colors.lightBlueAccent,
              ),
              SizedBox(
                width: 2.0,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 0.0),
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Name: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              '${_dietPlanData.dailyList[_index - 1].threeMeals[_mealTypeIndex].title}',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 30,
              ),
              Icon(
                Icons.star,
                size: 18,
                color: Colors.lightBlueAccent,
              ),
              SizedBox(
                width: 2.0,
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Servings: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                        '${_dietPlanData.dailyList[_index - 1].threeMeals[_mealTypeIndex].servings}',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 30,
              ),
              Icon(
                Icons.star,
                size: 18,
                color: Colors.lightBlueAccent,
              ),
              SizedBox(
                width: 2.0,
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Nutrients per serving: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 60,
              ),
              Icon(
                Icons.star,
                size: 18,
                color: Colors.yellow,
              ),
              SizedBox(
                width: 2.0,
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Calories: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                        '${_dietPlanData.dailyList[_index - 1].threeMeals[_mealTypeIndex].calory} (calories)',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 60,
              ),
              Icon(
                Icons.star,
                size: 18,
                color: Colors.yellow,
              ),
              SizedBox(
                width: 2.0,
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Protein: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                        '${_dietPlanData.dailyList[_index - 1].threeMeals[_mealTypeIndex].protein} (g)',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 60,
              ),
              Icon(
                Icons.star,
                size: 18,
                color: Colors.yellow,
              ),
              SizedBox(
                width: 2.0,
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Fat: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                        '${_dietPlanData.dailyList[_index - 1].threeMeals[_mealTypeIndex].fat} (g)',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 60,
              ),
              Icon(
                Icons.star,
                size: 18,
                color: Colors.yellow,
              ),
              SizedBox(
                width: 2.0,
              ),
              Expanded(
                child: RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Carbohydrate: ',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text:
                        '${_dietPlanData.dailyList[_index - 1].threeMeals[_mealTypeIndex].carbohydrates} (g)',
                      ),
                    ],
                  ),
                ),
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
