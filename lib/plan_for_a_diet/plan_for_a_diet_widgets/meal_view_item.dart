import 'package:flutter/material.dart';
import '../plan_for_a_diet_providers/diet_plan.dart';
import '../plan_for_a_diet_providers/meal_search_list.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MealViewItem extends StatelessWidget {
  final MealSearchList mealSearchList;
  final int _index;
  final int _mealType;
  final DietPlan _dietPlanData;

  @override
  MealViewItem(
    this._index,
    this._mealType,
    this._dietPlanData,
    this.mealSearchList,
  );

  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: 0.85,
      crossAxisCount: 2,
      children: List.generate(mealSearchList.list.length, (index) {
        Color backgroundColor;
        String textString;
        if (mealSearchList.list[index].title ==
            _dietPlanData.dailyList[_index].dailyMealList[_mealType].title) {
          backgroundColor = Colors.blueAccent;
          textString = 'Current meal';
        } else if (mealSearchList.recommendations[index] == 0) {
          backgroundColor = Colors.grey;
          textString = 'Not recommended';
        } else {
          backgroundColor = Colors.green;
          textString = 'Recommended';
        }
        return Container(
          margin: EdgeInsets.all(15),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 33,
                  color: Color(0xFFD3D3D3).withOpacity(.84),
                ),
              ],
            ),
            margin: EdgeInsets.all(5),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/searched-meal-info-screen',
                        arguments: {
                          'index': _index,
                          'mealType': _mealType,
                          'meal': mealSearchList.list.elementAt(index),
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: (mealSearchList.list.elementAt(index).imageUrl !=
                              null)
                          ? Image.network(
                              mealSearchList.list.elementAt(index).imageUrl,
                            )
                          : Image.asset('image/wp-header-logo-21.png'),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                        child: AutoSizeText(
                          mealSearchList.list.elementAt(index).title,
                          style: TextStyle(fontSize: 15.0),
                          minFontSize: 10.0,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          //Function goes here,
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            color: backgroundColor, //Color(0xFF393939)
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20.0),
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                          child: AutoSizeText(
                            textString,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            minFontSize: 10.0,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
