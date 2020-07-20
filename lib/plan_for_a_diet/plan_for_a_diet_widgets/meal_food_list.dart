import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../plan_for_a_diet_providers/diet_plan_data.dart';
import '../plan_for_a_diet_providers/meal_search_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
        size: 20.0,
      );
    } else if (_mealType == 'Lunch') {
      return Icon(
        Icons.brightness_5,
        color: Colors.redAccent,
        size: 20.0,
      );
    } else {
      return Icon(
        Icons.brightness_4,
        color: Colors.blueGrey,
        size: 20.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget mealIcon = identifyMealIcon();

    final mealSearchList = Provider.of<MealSearchList>(context, listen: false);
    ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );
    pr.style(
      message: 'Initializing screen...',
      borderRadius: 50.0,
      elevation: 5.0,
      progressWidget: SpinKitDualRing(
        color: Color(0xFFFCECC5),
        size: 40.0,
      ),
      backgroundColor: Colors.white,
      messageTextStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
      ),
    );

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
                    fontSize: 18.0,
                  ),
                ),
                Expanded(
                  child: IconButton(
                    alignment: Alignment.centerLeft,
                    icon: Icon(
                      Icons.search,
                      size: 20.0,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                        '/meal-info-screen',
                        arguments: _dietPlanData
                            .dailyList[_index - 1].threeMeals[_mealTypeIndex],
                      );
                    },
                  ),
                ),
                Expanded(
                  child: IconButton(
                    alignment: Alignment.centerRight,
                    icon: Icon(
                      Icons.mode_edit,
                      size: 20.0,
                    ),
                    onPressed: () async {
                      pr.show();
                      try {
                        await mealSearchList.getMealsFromTag(_mealTypeIndex == 0
                            ? 'apple'
                            : _mealTypeIndex == 1 ? 'beef' : 'cucumber');
                        pr
                            .hide()
                            .whenComplete(() => Navigator.of(context).pushNamed(
                                  '/search-food-for-plan-screen',
                                  arguments: {
                                    'index': _index - 1,
                                    'mealType': _mealTypeIndex,
                                  },
                                ));
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                ),
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
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text:
                              '${_dietPlanData.dailyList[_index - 1].threeMeals[_mealTypeIndex].title}',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 0.0),
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Servings: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text:
                              '${_dietPlanData.dailyList[_index - 1].threeMeals[_mealTypeIndex].servings}',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 0.0),
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Nutrients per serving: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 0.0),
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Calories: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text:
                              '${_dietPlanData.dailyList[_index - 1].threeMeals[_mealTypeIndex].calory} (calories)',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 0.0),
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Protein: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text:
                              '${_dietPlanData.dailyList[_index - 1].threeMeals[_mealTypeIndex].protein} (g)',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 0.0),
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Fat: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text:
                              '${_dietPlanData.dailyList[_index - 1].threeMeals[_mealTypeIndex].fat} (g)',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 4.0, 0.0),
                  child: RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Carbohydrate: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                        TextSpan(
                          text:
                              '${_dietPlanData.dailyList[_index - 1].threeMeals[_mealTypeIndex].carbohydrate} (g)',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
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
