import 'package:flutter/material.dart';
import 'daily_plan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../providers/user_health_data.dart';

class DietPlan with ChangeNotifier {
  List<DailyPlan> _dailyList = List(30);

  static final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> resetPlan(UserHealthData userHealthData) async {
    var firebaseUser = await _auth.currentUser();
    await Firestore.instance
        .collection('users')
        .document(firebaseUser.uid)
        .updateData({'dietPlan': FieldValue.delete()});
    await setWholePlan(userHealthData);
  }

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
        _dailyList[i] = DailyPlan(i);

        _dailyList[i].setAllForDay(
          calory: dietPlanMap['$i']['calory'],
          carbohydrate: dietPlanMap['$i']['carbohydrate'],
          fat: dietPlanMap['$i']['fat'],
          protein: dietPlanMap['$i']['protein'],
          isChecked: dietPlanMap['$i']['isChecked'],
        );

        _dailyList[i].accessMealList[0].setAllForMeal(
              title: dietPlanMap['$i']['breakfast']['title'],
              imageUrl: dietPlanMap['$i']['breakfast']['imageUrl'],
              servings: dietPlanMap['$i']['breakfast']['servings'],
              mealType: 0,
              calory: dietPlanMap['$i']['breakfast']['calory'],
              protein: dietPlanMap['$i']['breakfast']['protein'],
              fat: dietPlanMap['$i']['breakfast']['fat'],
              carbohydrate: dietPlanMap['$i']['breakfast']['carbohydrate'],
              servingSize: dietPlanMap['$i']['breakfast']['servingSize'],
            );
        for (int j = 0;; j++) {
          if (dietPlanMap['$i']['breakfast']['ingredients']['$j'] == null)
            break;
          else {
            Ingredient tempIngre = Ingredient();
            tempIngre.setAllForIngredient(
              name: dietPlanMap['$i']['breakfast']['ingredients']['$j']['name'],
              amount: dietPlanMap['$i']['breakfast']['ingredients']['$j']
                  ['amount'],
              unit: dietPlanMap['$i']['breakfast']['ingredients']['$j']['unit'],
            );
            _dailyList[i].accessMealList[0].accessIngredients.add(tempIngre);
          }
        }

        _dailyList[i].accessMealList[1].setAllForMeal(
              title: dietPlanMap['$i']['lunch']['title'],
              imageUrl: dietPlanMap['$i']['lunch']['imageUrl'],
              servings: dietPlanMap['$i']['lunch']['servings'],
              mealType: 1,
              calory: dietPlanMap['$i']['lunch']['calory'],
              protein: dietPlanMap['$i']['lunch']['protein'],
              fat: dietPlanMap['$i']['lunch']['fat'],
              carbohydrate: dietPlanMap['$i']['lunch']['carbohydrate'],
              servingSize: dietPlanMap['$i']['breakfast']['servingSize'],
            );
        for (int j = 0;; j++) {
          if (dietPlanMap['$i']['lunch']['ingredients']['$j'] == null)
            break;
          else {
            Ingredient tempIngre = Ingredient();
            tempIngre.setAllForIngredient(
              name: dietPlanMap['$i']['lunch']['ingredients']['$j']['name'],
              amount: dietPlanMap['$i']['lunch']['ingredients']['$j']['amount'],
              unit: dietPlanMap['$i']['lunch']['ingredients']['$j']['unit'],
            );
            _dailyList[i].accessMealList[1].accessIngredients.add(tempIngre);
          }
        }

        _dailyList[i].accessMealList[2].setAllForMeal(
              title: dietPlanMap['$i']['dinner']['title'],
              imageUrl: dietPlanMap['$i']['dinner']['imageUrl'],
              servings: dietPlanMap['$i']['dinner']['servings'],
              mealType: 2,
              calory: dietPlanMap['$i']['dinner']['calory'],
              protein: dietPlanMap['$i']['dinner']['protein'],
              fat: dietPlanMap['$i']['dinner']['fat'],
              carbohydrate: dietPlanMap['$i']['dinner']['carbohydrate'],
              servingSize: dietPlanMap['$i']['breakfast']['servingSize'],
            );
        for (int j = 0;; j++) {
          if (dietPlanMap['$i']['dinner']['ingredients']['$j'] == null)
            break;
          else {
            Ingredient tempIngre = Ingredient();
            tempIngre.setAllForIngredient(
              name: dietPlanMap['$i']['dinner']['ingredients']['$j']['name'],
              amount: dietPlanMap['$i']['dinner']['ingredients']['$j']
                  ['amount'],
              unit: dietPlanMap['$i']['dinner']['ingredients']['$j']['unit'],
            );
            _dailyList[i].accessMealList[2].accessIngredients.add(tempIngre);
          }
        }
      }
      return false;
    } else {
      return true;
    }
  }

  Future<void> setWholePlan(UserHealthData userHealthData) async {
    var queryValue = await Firestore.instance.collection('data').getDocuments();
    var firebaseUser = await _auth.currentUser();

    var documents = queryValue.documents;

    //TODO: Breakfasts should have: apple, juice, banana, egg, cheese, potato, bread, avocado.
    List<int> breakfastTagSizeList = [
      documents[Tag.apple.index].data['Recipe'].length,
      documents[Tag.avocado.index].data['Recipe'].length,
      documents[Tag.banana.index].data['Recipe'].length,
      documents[Tag.bread.index].data['Recipe'].length,
      documents[Tag.cheese.index].data['Recipe'].length,
      documents[Tag.egg.index].data['Recipe'].length,
      documents[Tag.juice.index].data['Recipe'].length,
      documents[Tag.potato.index].data['Recipe'].length,
    ];
    int sumBreakfastRecipes = 0;
    for (int i = 0; i < breakfastTagSizeList.length; i++) {
      sumBreakfastRecipes += breakfastTagSizeList[i];
    }

    //TODO: Lunches should have: beef, chicken, crab, meat, pasta, pork, shrimp, steak.
    List<int> lunchTagSizeList = [
      documents[Tag.beef.index].data['Recipe'].length,
      documents[Tag.chicken.index].data['Recipe'].length,
      documents[Tag.crab.index].data['Recipe'].length,
      documents[Tag.meat.index].data['Recipe'].length,
      documents[Tag.pasta.index].data['Recipe'].length,
      documents[Tag.pork.index].data['Recipe'].length,
      documents[Tag.shrimp.index].data['Recipe'].length,
      documents[Tag.steak.index].data['Recipe'].length,
    ];

    int sumLunchRecipes = 0;
    for (int i = 0; i < lunchTagSizeList.length; i++) {
      sumLunchRecipes += lunchTagSizeList[i];
    }

    //TODO: Dinners should have: cucumber, fish, mushroom, salad, salmon, sauce, soup,
    //TODO: spinach, tomato, tuna, vegetable.
    List<int> dinnerTagSizeList = [
      documents[Tag.cucumber.index].data['Recipe'].length,
      documents[Tag.fish.index].data['Recipe'].length,
      documents[Tag.mushroom.index].data['Recipe'].length,
      documents[Tag.salad.index].data['Recipe'].length,
      documents[Tag.salmon.index].data['Recipe'].length,
      documents[Tag.sauce.index].data['Recipe'].length,
      documents[Tag.soup.index].data['Recipe'].length,
      documents[Tag.spinach.index].data['Recipe'].length,
      documents[Tag.tomato.index].data['Recipe'].length,
      documents[Tag.tuna.index].data['Recipe'].length,
      documents[Tag.vegetable.index].data['Recipe'].length,
    ];

    int sumDinnerRecipes = 0;
    for (int i = 0; i < dinnerTagSizeList.length; i++) {
      sumDinnerRecipes += dinnerTagSizeList[i];
    }

    String userOnlineId = firebaseUser.uid;
    for (int i = 0; i < 30; i++) {
      _dailyList[i] = DailyPlan(i);
      _dailyList[i].setDailyPlan(
        userOnlineId,
        documents,
        breakfastTagSizeList,
        sumBreakfastRecipes,
        lunchTagSizeList,
        sumLunchRecipes,
        dinnerTagSizeList,
        sumDinnerRecipes,
        userHealthData.userLBCalory,
        userHealthData.userUBCalory,
      );
    }

    notifyListeners();
  }

  void setDailyMeal(
    int index,
    int mealType,
    Meal meal,
  ) async {
    int servingIndex = _dailyList[index].accessMealList[mealType].servings;
    _dailyList[index].setCalory =
        -(_dailyList[index].accessMealList[mealType].calory * servingIndex);
    _dailyList[index].setProtein =
        -(_dailyList[index].accessMealList[mealType].protein * servingIndex);
    _dailyList[index].setFat =
        -(_dailyList[index].accessMealList[mealType].fat * servingIndex);
    _dailyList[index].setCarbohydrate =
        -(_dailyList[index].accessMealList[mealType].carbohydrate * servingIndex);

    _dailyList[index].accessMealList[mealType].accessIngredients.clear();
    _dailyList[index].accessMealList[mealType].setAllForMeal(
          title: meal.title,
          imageUrl: meal.imageUrl,
          servings: meal.servings,
          mealType: mealType,
          calory: meal.calory,
          protein: meal.protein,
          fat: meal.fat,
          carbohydrate: meal.carbohydrate,
          servingSize: meal.servingSize,
        );

    servingIndex = _dailyList[index].accessMealList[mealType].servings;
    _dailyList[index].setCalory =
        (_dailyList[index].accessMealList[mealType].calory * servingIndex);
    _dailyList[index].setProtein =
        (_dailyList[index].accessMealList[mealType].protein * servingIndex);
    _dailyList[index].setFat =
        (_dailyList[index].accessMealList[mealType].fat * servingIndex);
    _dailyList[index].setCarbohydrate =
        (_dailyList[index].accessMealList[mealType].carbohydrate * servingIndex);

    for (int i = 0; i < meal.ingredients.length; i++) {
      Ingredient tempIngre = Ingredient();
      tempIngre.setAllForIngredient(
        name: meal.ingredients[i].name,
        amount: meal.ingredients[i].amount,
        unit: meal.ingredients[i].unit,
      );
      _dailyList[index].accessMealList[mealType].accessIngredients.add(tempIngre);
    }

    var firebaseUser = await _auth.currentUser();
    _dailyList[index].postDailyMeal(firebaseUser.uid, mealType);
    notifyListeners();
  }

  List<DailyPlan> get dailyList {
    return [..._dailyList];
  }
}
