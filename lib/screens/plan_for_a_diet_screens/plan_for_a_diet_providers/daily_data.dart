import '../../../providers/data_helper.dart';

class Meal {
  String _id;
  String _title;

  // mealType = 0 => Breakfast, = 1 => Lunch, = 2 => Dinner.
  int _mealType;

  // Getters and Setters
  String get title {
    return _title;
  }

  String get id {
    return _id;
  }

  int get mealType {
    return _mealType;
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

  void setAllForMeal({String id, String title, int mealType}) {
    _id = id;
    _title = title;
    _mealType = mealType;
  }
}

class DailyData {
  int _index;
  double _calory;
  double _protein;
  double _fat;
  double _carbohydrate;
  List<Meal> _threeMeals = List(3);
  List<dynamic> dailyRecipeJson = List(3);

  DailyData(this._index);

  void setAllForDay(
      {double calory, double protein, double fat, double carbohydrate}) {
    _calory = calory;
    _protein = protein;
    _fat = fat;
    _carbohydrate = carbohydrate;
  }

  Future<void> setDailyPlan(double wantedCalory) async {
    DataHelper dataHelper = DataHelper();
    String idUrl =
        'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/mealplans/generate?timeFrame=day&targetCalories=$wantedCalory&diet=normal&exclude=butter%252C%20lard%252C%20cake';
    var dailyDataJson = await dataHelper.fetchData(idUrl);
    var dailyCalory = dailyDataJson['nutrients']['calories'];
    var dailyProtein = dailyDataJson['nutrients']['protein'];
    var dailyFat = dailyDataJson['nutrients']['fat'];
    var dailyCarbohydrate = dailyDataJson['nutrients']['carbohydrates'];

    setAllForDay(
        calory: dailyCalory,
        protein: dailyProtein,
        fat: dailyFat,
        carbohydrate: dailyCarbohydrate);

    for (int i = 0; i < 3; i++) {
      var mealId = dailyDataJson['meals'][i]['id'];
      var mealTitle = dailyDataJson['meals'][i]['title'];
      print(mealTitle);
      _threeMeals[i]
          .setAllForMeal(id: mealId.toString(), title: mealTitle, mealType: i);
    }
  }

// Getters and Setters.

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
