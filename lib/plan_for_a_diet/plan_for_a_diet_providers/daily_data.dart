import '../../providers/data_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

class Meal {
  String _imageUrl;

  int _id;
  String _title;
  int _servings;

  // mealType = 0 => Breakfast, = 1 => Lunch, = 2 => Dinner.
  int _mealType;

  // Getters and Setters
  String get title {
    return _title;
  }

  int get id {
    return _id;
  }

  int get mealType {
    return _mealType;
  }

  String get imageUrl {
    return _imageUrl;
  }

  int get servings {
    return _servings;
  }

  void setAllForMeal(
      {int id, String title, int mealType, String imageUrl, int servings}) {
    _id = id;
    _title = title;
    _mealType = mealType;
    _imageUrl = imageUrl;
    _servings = servings;
  }
}

class DailyData {
  int _index;
  double _calory = 0;
  double _protein;
  double _fat;
  double _carbohydrate;
  List<Meal> _threeMeals = List<Meal>.generate(3, (index) => Meal());
  bool _isChecked = false;

  static final FirebaseAuth _auth = FirebaseAuth.instance;


  DailyData(this._index);

  void _postDailyPlan() async{
    var firebaseUser = await _auth.currentUser();
    Firestore.instance
        .collection('users')
        .document(firebaseUser.uid)
        .setData({
      'dietPlan': {
        '$_index': {
          'calory': _calory,
          'carbohydrate': _carbohydrate,
          'fat': _fat,
          'protein': _protein,
          'isChecked': _isChecked,
          'breakfast': {
            'title': _threeMeals[0].title,
            'imageUrl': _threeMeals[0].imageUrl,
            'id': _threeMeals[0].id,
            'servings': _threeMeals[0].servings,
          },
          'lunch': {
            'title': _threeMeals[1].title,
            'imageUrl': _threeMeals[1].imageUrl,
            'id': _threeMeals[1].id,
            'servings': _threeMeals[1].servings,
          },
          'dinner': {
            'title': _threeMeals[2].title,
            'imageUrl': _threeMeals[2].imageUrl,
            'id': _threeMeals[2].id,
            'servings': _threeMeals[2].servings,
          },
        }
      }
    }, merge: true);
  }

  void setAllForDay({
    double calory,
    double protein,
    double fat,
    double carbohydrate,
    bool isChecked = false,
  }) {
    _calory = calory;
    _protein = protein;
    _fat = fat;
    _carbohydrate = carbohydrate;
    _isChecked = isChecked;
  }

  Future<void> setDailyPlan(double wantedCalory) async {
    DataHelper dataHelper = DataHelper();
    String idUrl =
        'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/mealplans/generate?timeFrame=day&targetCalories=$wantedCalory&diet=normal&exclude=oil%252C%20fat%252C%20cheese%252C%20sugar%252C%20chocolate%252C%20cream';
    var dailyDataJson = await dataHelper.fetchData(idUrl);
    var dailyCalory = dailyDataJson['nutrients']['calories'];
    var dailyProtein = dailyDataJson['nutrients']['protein'];
    var dailyFat = dailyDataJson['nutrients']['fat'];
    var dailyCarbohydrate = dailyDataJson['nutrients']['carbohydrates'];

    setAllForDay(
      calory: dailyCalory,
      protein: dailyProtein,
      fat: dailyFat,
      carbohydrate: dailyCarbohydrate,
    );

    for (int i = 0; i < 3; i++) {
      var mealId = dailyDataJson['meals'][i]['id'];
      var mealTitle = dailyDataJson['meals'][i]['title'];
      var mealImageUrl =
          'https://spoonacular.com/recipeImages/$mealId-556x370.jpg';
      var mealServings = dailyDataJson['meals'][i]['servings'];
      _threeMeals[i].setAllForMeal(
        id: mealId,
        title: mealTitle,
        mealType: i,
        imageUrl: mealImageUrl,
        servings: mealServings,
      );
    }
    _postDailyPlan();
  }

// Getters and Setters.

  void setChecked(bool isChecked) {
    _isChecked = isChecked;
  }

  int get index {
    return _index;
  }

  double get calory {
    return _calory;
  }

  double get protein {
    return _protein;
  }

  double get fat {
    return _fat;
  }

  double get carbohydrate {
    return _carbohydrate;
  }

  List<Meal> get threeMeals {
    return [..._threeMeals];
  }

  bool get isChecked {
    return _isChecked;
  }
}
