import 'package:flutter/material.dart';
import 'daily_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class DietPlanData with ChangeNotifier {
  double _userCalory;
  List<DailyData> _dailyList = List(30);

  ///////////////////////
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  void checkDay(int index) async {
    _dailyList[index].setChecked(true);
    var firebaseUser = await _auth.currentUser();
    Firestore.instance.collection('users').document(firebaseUser.uid).setData({
      'dietPlan': {
        '$index': {
          'isChecked': true,
        },
      }
    }, merge: true);
  }

  void uncheckDay(int index) async {
    _dailyList[index].setChecked(false);
    var firebaseUser = await _auth.currentUser();
    Firestore.instance.collection('users').document(firebaseUser.uid).setData({
      'dietPlan': {
        '$index': {
          'isChecked': false,
        },
      }
    }, merge: true);
  }

  Future<bool> getDietPlan() async {
    var firebaseUser = await _auth.currentUser();
    var value = await Firestore.instance
        .collection('users')
        .document(firebaseUser.uid)
        .get();
    Map<String, dynamic> tempMap = value.data;
    var dietPlanMap = tempMap['dietPlan'];
    if (dietPlanMap != null) {
      for (int i = 0; i < 30; i++) {
        _dailyList[i] = DailyData(i);
        _dailyList[i].setAllForDay(
          calory: dietPlanMap['$i']['calory'],
          carbohydrate: dietPlanMap['$i']['carbohydrate'],
          fat: dietPlanMap['$i']['fat'],
          protein: dietPlanMap['$i']['protein'],
          isChecked: dietPlanMap['$i']['isChecked'],
        );
        _dailyList[i].threeMeals[0].setAllForMeal(
              id: dietPlanMap['$i']['breakfast']['id'],
              title: dietPlanMap['$i']['breakfast']['title'],
              imageUrl: dietPlanMap['$i']['breakfast']['imageUrl'],
              servings: dietPlanMap['$i']['breakfast']['servings'],
              mealType: 0,
            );

        _dailyList[i].threeMeals[1].setAllForMeal(
              id: dietPlanMap['$i']['lunch']['id'],
              title: dietPlanMap['$i']['lunch']['title'],
              imageUrl: dietPlanMap['$i']['lunch']['imageUrl'],
              servings: dietPlanMap['$i']['lunch']['servings'],
              mealType: 1,
            );

        _dailyList[i].threeMeals[2].setAllForMeal(
              id: dietPlanMap['$i']['dinner']['id'],
              title: dietPlanMap['$i']['dinner']['title'],
              imageUrl: dietPlanMap['$i']['dinner']['imageUrl'],
              servings: dietPlanMap['$i']['dinner']['servings'],
              mealType: 2,
            );
      }
      return false;
    } else {
      return true;
    }
  }

  Future<void> setWholePlan(double userDailyCalory) async {
    _userCalory = userDailyCalory;
    for (int i = 0; i < 5; i++) {
      _dailyList[i] = DailyData(i);
      await _dailyList[i].setDailyPlan(_userCalory);
    }

    for (int i = 5; i < 30; i++) {
      _dailyList[i] = DailyData(i);
      _dailyList[i].setDailyPlan(_userCalory);
    }


    notifyListeners();
  }

  List<DailyData> get dailyList {
    return [..._dailyList];
  }
}
