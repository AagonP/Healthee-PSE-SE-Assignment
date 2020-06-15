import 'package:flutter/material.dart';

class MealFoodList extends StatelessWidget {
  final String mealName;

  MealFoodList(this.mealName);

  Widget identifyMealIcon() {
    if (mealName == 'Breakfast') {
      return Icon(
      Icons.brightness_6,
      color: Colors.yellowAccent,
      );
      }

    else if (mealName == 'Lunch') {
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
                Text(mealName),
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
