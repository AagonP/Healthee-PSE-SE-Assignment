import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_health_data.dart';
import '../../providers/data_helper.dart';
import 'daily_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class DietPlanData with ChangeNotifier {
  double _userCalory;
  List<DailyData> _dailyList = List(30);

  ///////////////////////
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  void _postDietPlan() async {
    var firebaseUser = await _auth.currentUser();
    //Firestore.instance.collection("users").document(firebaseUser.uid).updateData(data);
    for (int i = 0; i < 1; i++) {
      Firestore.instance
          .collection('users')
          .document(firebaseUser.uid)
          .setData({
        'dietPlan': {
          '$i': {
            'calory': _dailyList[i].calory,
            'carbohydrate': _dailyList[i].carbohydrate,
            'fat': _dailyList[i].fat,
            'protein': _dailyList[i].protein,
            'breakfast': {
              'title': _dailyList[i].threeMeals[0].title,
              'imageUrl': _dailyList[i].threeMeals[0].imageUrl,
              'id': _dailyList[i].threeMeals[0].id,
            },
            'lunch': {
              'title': _dailyList[i].threeMeals[1].title,
              'imageUrl': _dailyList[i].threeMeals[1].imageUrl,
              'id': _dailyList[i].threeMeals[1].id,
            },
            'dinner': {
              'title': _dailyList[i].threeMeals[2].title,
              'imageUrl': _dailyList[i].threeMeals[2].imageUrl,
              'id': _dailyList[i].threeMeals[2].id,
            },
          }
        }
      }, merge: true);
    }
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
      for (int i = 0; i < 1; i++) {
        _dailyList[i] = DailyData(i);
        _dailyList[i].setAllForDay(
          calory: dietPlanMap['$i']['calory'],
          carbohydrate: dietPlanMap['$i']['carbohydrate'],
          fat: dietPlanMap['$i']['fat'],
          protein: dietPlanMap['$i']['protein'],
        );
        _dailyList[i].threeMeals[0].setAllForMeal(
              id: dietPlanMap['$i']['breakfast']['id'],
              title: dietPlanMap['$i']['breakfast']['title'],
              imageUrl: dietPlanMap['$i']['breakfast']['imageUrl'],
              mealType: 0,
            );

        _dailyList[i].threeMeals[1].setAllForMeal(
              id: dietPlanMap['$i']['lunch']['id'],
              title: dietPlanMap['$i']['lunch']['title'],
              imageUrl: dietPlanMap['$i']['lunch']['imageUrl'],
              mealType: 1,
            );

        _dailyList[i].threeMeals[2].setAllForMeal(
              id: dietPlanMap['$i']['dinner']['id'],
              title: dietPlanMap['$i']['dinner']['title'],
              imageUrl: dietPlanMap['$i']['dinner']['imageUrl'],
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
    for (int i = 0; i < 1; i++) {
      _dailyList[i] = DailyData(i);
      await _dailyList[i].setDailyPlan(_userCalory);
    }
    /*for (int i = 6; i < 30; i++) {
      _dailyList[i] = DailyData(i);
      _dailyList[i].setDailyPlan(_userCalory);
    }*/

    _postDietPlan();

    notifyListeners();
  }

  List<DailyData> get dailyList {
    return [..._dailyList];
  }
}
