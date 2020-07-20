import 'package:flutter/cupertino.dart';
import 'daily_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class MealSearchList with ChangeNotifier {
  List<Meal> _mealSearchList = List();

  List<Meal> get list {
    return [..._mealSearchList];
  }

  List<Meal> get accessList {
    return _mealSearchList;
  }

  Future<void> getMealsFromTag(String tag) async {
    _mealSearchList.clear();
    var queryValue =
        await Firestore.instance.collection('data').document(tag).get();
    var mealListJson = queryValue.data['Recipe'];
    for (int i = 0; i < mealListJson.length; i++) {
      var mealJson = mealListJson[i];

      Meal tempMeal = Meal();
      tempMeal.setAllForMeal(
        title: mealJson['title'],
        mealType: 2,
        imageUrl: mealJson['image'],
        servings: 0,
        calory: mealJson['nutrition']['nutrients'][0]['amount'],
        fat: mealJson['nutrition']['nutrients'][1]['amount'],
        carbohydrate: mealJson['nutrition']['nutrients'][3]['amount'],
        protein: mealJson['nutrition']['nutrients'][6]['amount'],
        servingSize: mealJson['servings'],
      );
      _mealSearchList.add(tempMeal);
      for (int j = 0; j < mealJson['extendedIngredients'].length; j++) {
        Ingredient tempIngre = Ingredient();
        tempIngre.setAllForIngredient(
          name: mealJson['extendedIngredients'][j]['name'],
          amount: mealJson['extendedIngredients'][j]['amount'],
          unit: mealJson['extendedIngredients'][j]['unit'],
        );
        _mealSearchList[i].accessIngredients.add(tempIngre);
      }
    }
    notifyListeners();
  }
}
