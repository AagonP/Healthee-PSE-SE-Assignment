import '../../providers/data_helper.dart';
import 'dart:async';

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

  /*void setId(String id) {
    _id = id;
  }

  void setTitle(String title) {
    _title = title;
  }

  void setMealType(int mealType) {
    _mealType = mealType;
  }*/

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


  DailyData(this._index);

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

/*void setIndex(int index) {
    _index = index;
  }

  void setCalory(double calory) {
    _calory = calory;
  }

  void setProtein(double protein) {
    _protein = protein;
  }

  void setFat(double fat) {
    _fat = fat;
  }

  void setCarbohydrate(double carbohydrate) {
    _carbohydrate = carbohydrate;
  }

  void setThreeMeals(List<Meal> threeMeals) {
    _threeMeals = threeMeals;
  }*/
}
