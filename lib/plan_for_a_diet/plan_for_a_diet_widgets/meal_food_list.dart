import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../providers/user_health_data.dart';
import '../plan_for_a_diet_providers/diet_plan.dart';
import '../plan_for_a_diet_providers/meal_search_list.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MealFoodList extends StatelessWidget {
  final String _mealType;
  final int _index;
  final int _mealTypeIndex;
  DietPlan _dietPlanData;

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

  Future<void> _clickEdit(
    BuildContext context,
    ProgressDialog pr,
    MealSearchList mealSearchList,
    UserHealthData userHealthData,
  ) async {
    pr.show();
    try {
      await mealSearchList.getMealsFromTag(
          userHealthData,
          _mealTypeIndex,
          _mealTypeIndex == 0
              ? 'apple'
              : _mealTypeIndex == 1 ? 'beef' : 'cucumber');
      pr.hide().whenComplete(() => Navigator.of(context).pushNamed(
            '/search-food-for-plan-screen',
            arguments: {
              'index': _index - 1,
              'mealType': _mealTypeIndex,
            },
          ));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Widget mealIcon = identifyMealIcon();
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
    final mealSearchList = Provider.of<MealSearchList>(context, listen: false);
    final userHealthData = Provider.of<UserHealthData>(context, listen: false);

    // TODO: implement build
    return Container(
      margin: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
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
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 10.0),
                    child: Column(
                      children: <Widget>[
                        RawMaterialButton(
                          constraints: BoxConstraints.tightFor(
                            width: 30.0,
                            height: 30.0,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              '/meal-info-screen',
                              arguments: _dietPlanData.dailyList[_index - 1]
                                  .dailyMealList[_mealTypeIndex],
                            );
                          },
                          elevation: 1.0,
                          fillColor: Colors.white,
                          child: Image.asset(
                            'image/search.png',
                            fit: BoxFit.cover,
                            width: 20.0,
                            height: 20.0,
                          ),
                          shape: CircleBorder(
                            side: BorderSide(
                              color: Color(0xFFFCECC5),
                              width: 2.0,
                            ),
                          ),
                        ),
                        Text(
                          'View detail',
                          style: TextStyle(fontSize: 11.0),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 10.0),
                    child: Column(
                      children: <Widget>[
                        RawMaterialButton(
                          constraints: BoxConstraints.tightFor(
                            width: 30.0,
                            height: 30.0,
                          ),
                          onPressed: () async {
                            await _clickEdit(
                              context,
                              pr,
                              mealSearchList,
                              userHealthData,
                            );
                          },
                          elevation: 1.0,
                          fillColor: Colors.white,
                          child: Image.asset(
                            'image/edit.png',
                            fit: BoxFit.cover,
                            width: 20.0,
                            height: 20.0,
                          ),
                          shape: CircleBorder(
                            side: BorderSide(
                              color: Color(0xFFFCECC5),
                              width: 2.0,
                            ),
                          ),
                        ),
                        Text(
                          'Edit',
                          style: TextStyle(fontSize: 11.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            height: 20.0,
            width: double.infinity,
            child: Divider(
              thickness: 1.0,
              color: Colors.teal.shade200,
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
                              '${_dietPlanData.dailyList[_index - 1].dailyMealList[_mealTypeIndex].title}',
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
                              '${_dietPlanData.dailyList[_index - 1].dailyMealList[_mealTypeIndex].servings}',
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
                              '${_dietPlanData.dailyList[_index - 1].dailyMealList[_mealTypeIndex].calory} (calories)',
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
                              '${_dietPlanData.dailyList[_index - 1].dailyMealList[_mealTypeIndex].protein} (g)',
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
                              '${_dietPlanData.dailyList[_index - 1].dailyMealList[_mealTypeIndex].fat} (g)',
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
                              '${_dietPlanData.dailyList[_index - 1].dailyMealList[_mealTypeIndex].carbohydrate} (g)',
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
              borderRadius: BorderRadius.circular(20.0),
              child: _dietPlanData.dailyList[_index - 1]
                          .dailyMealList[_mealTypeIndex].imageUrl ==
                      null
                  ? Image.asset('image/wp-header-logo-21.png')
                  : Image.network(
                      _dietPlanData.dailyList[_index - 1]
                          .dailyMealList[_mealTypeIndex].imageUrl,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
