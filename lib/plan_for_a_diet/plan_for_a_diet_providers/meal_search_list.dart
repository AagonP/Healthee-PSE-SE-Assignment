import 'package:flutter/cupertino.dart';
import '../../providers/user_health_data.dart';
import 'daily_plan.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class MealSearchList with ChangeNotifier {
  List<Meal> _mealSearchList = List();
  List<int> _recommendations = List();

  List<Meal> get list {
    return [..._mealSearchList];
  }

  List<Meal> get accessList {
    return _mealSearchList;
  }

  List<int> get recommendations {
    return [..._recommendations];
  }

  List<int> get accessRecommendations {
    return _recommendations;
  }

  Future<void> getMealsFromTag(
    UserHealthData userHealthData,
    int mealType,
    String tag,
  ) async {
    _mealSearchList.clear();
    _recommendations.clear();
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
      int mealIndex = mealType == 0 ? 35 : mealType == 1 ? 35 : 30;
      int servingsIndex = (userHealthData.userUBCalory * mealIndex / 100) ~/
          _mealSearchList[i].calory;
      if ((userHealthData.userLBCalory * mealIndex / 100) <=
          _mealSearchList[i].calory *
              (servingsIndex)) {
        _recommendations.add(servingsIndex);
        _mealSearchList[i].setServingsOnly(servingsIndex);
      }
      else {
        _recommendations.add(0);
      }
    }
    notifyListeners();
  }
}
