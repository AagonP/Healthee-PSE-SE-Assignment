import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

enum Tag {
  apple,
  avocado,
  banana,
  beef,
  bread,
  burger,
  cake,
  cheese,
  chicken,
  chocolate,
  cookie,
  crab,
  cream,
  cucumber,
  curry,
  dough,
  egg,
  fish,
  ham,
  juice,
  meat,
  mushroom,
  orange,
  pancake,
  pasta,
  pie,
  pizza,
  pork,
  potato,
  rice,
  salad,
  salmon,
  sauce,
  shrimp,
  soup,
  spinach,
  steak,
  tomato,
  tuna,
  vegetable,
}

class Ingredient {
  String _name;
  String _unit;
  double _amount;

  String get name {
    return _name;
  }

  String get unit {
    return _unit;
  }

  double get amount {
    return _amount;
  }

  void setAllForIngredient({String name, double amount, String unit}) {
    _name = name;
    _amount = amount;
    _unit = unit;
  }
}

class Meal {
  String _imageUrl;

  String _title;
  int _servings;
  int _servingSize;

  double _calory;
  double _protein;
  double _fat;
  double _carbohydrate;
  List<Ingredient> _ingredients = List();

  // mealType = 0 => Breakfast, = 1 => Lunch, = 2 => Dinner.
  int _mealType;

  // Getters and Setters
  String get title {
    return _title;
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

  int get servingSize {
    return _servingSize;
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

  List<Ingredient> get ingredients {
    return [..._ingredients];
  }

  List<Ingredient> get accessIngredients {
    return _ingredients;
  }

  void setServingsOnly(int servings) {
    _servings = servings;
  }

  void setAllForMeal({
    String title,
    int mealType,
    String imageUrl,
    int servings,
    double calory,
    double protein,
    double fat,
    double carbohydrate,
    int servingSize,
  }) {
    _title = title;
    _mealType = mealType;
    _imageUrl = imageUrl;
    _servings = servings;
    _calory = calory;
    _protein = protein;
    _fat = fat;
    _carbohydrate = carbohydrate;
    _servingSize = servingSize;
  }

}

class DailyPlan {
  int _index;
  double _calory = 0;
  double _protein = 0;
  double _fat = 0;
  double _carbohydrate = 0;
  List<Meal> _dailyMealList = List<Meal>.generate(3, (index) => Meal());
  bool _isChecked = false;

  DailyPlan(this._index);

  void postDailyMeal(String userOnlineId, int mealType) {
    String mealTypeName =
        mealType == 0 ? 'breakfast' : mealType == 1 ? 'lunch' : 'dinner';
    Map<String, dynamic> mealIngredients = Map();
    for (int i = 0; i < _dailyMealList[mealType]._ingredients.length; i++) {
      mealIngredients['$i'] = {
        'name': _dailyMealList[mealType]._ingredients[i].name,
        'amount': _dailyMealList[mealType]._ingredients[i].amount,
        'unit': _dailyMealList[mealType]._ingredients[i].unit,
      };
    }

    Firestore.instance.collection('users').document(userOnlineId).setData({
      'dietPlan': {
        '$_index': {
          'calory': _calory,
          'carbohydrate': _carbohydrate,
          'fat': _fat,
          'protein': _protein,
          'isChecked': _isChecked,
          mealTypeName: {
            'title': _dailyMealList[mealType]._title,
            'imageUrl': _dailyMealList[mealType]._imageUrl,
            'servings': _dailyMealList[mealType]._servings,
            'servingSize': _dailyMealList[mealType]._servingSize,
            'calory': _dailyMealList[mealType]._calory,
            'carbohydrate': _dailyMealList[mealType]._carbohydrate,
            'fat': _dailyMealList[mealType]._fat,
            'protein': _dailyMealList[mealType]._protein,
            'ingredients': mealIngredients,
          },
        }
      }
    }, merge: true);
  }

  void _postDailyPlan(String userOnlineId) {
    Map<String, dynamic> breakfastIngredients = Map();
    for (int i = 0; i < _dailyMealList[0]._ingredients.length; i++) {
      breakfastIngredients['$i'] = {
        'name': _dailyMealList[0]._ingredients[i].name,
        'amount': _dailyMealList[0]._ingredients[i].amount,
        'unit': _dailyMealList[0]._ingredients[i].unit,
      };
    }
    Map<String, dynamic> lunchIngredients = Map();
    for (int i = 0; i < _dailyMealList[1]._ingredients.length; i++) {
      lunchIngredients['$i'] = {
        'name': _dailyMealList[1]._ingredients[i].name,
        'amount': _dailyMealList[1]._ingredients[i].amount,
        'unit': _dailyMealList[1]._ingredients[i].unit,
      };
    }
    Map<String, dynamic> dinnerIngredients = Map();
    for (int i = 0; i < _dailyMealList[2]._ingredients.length; i++) {
      dinnerIngredients['$i'] = {
        'name': _dailyMealList[2]._ingredients[i].name,
        'amount': _dailyMealList[2]._ingredients[i].amount,
        'unit': _dailyMealList[2]._ingredients[i].unit,
      };
    }
    Firestore.instance.collection('users').document(userOnlineId).setData({
      'dietPlan': {
        '$_index': {
          'calory': _calory,
          'carbohydrate': _carbohydrate,
          'fat': _fat,
          'protein': _protein,
          'isChecked': _isChecked,
          'breakfast': {
            'title': _dailyMealList[0]._title,
            'imageUrl': _dailyMealList[0]._imageUrl,
            'servings': _dailyMealList[0]._servings,
            'servingSize': _dailyMealList[0]._servingSize,
            'calory': _dailyMealList[0]._calory,
            'carbohydrate': _dailyMealList[0]._carbohydrate,
            'fat': _dailyMealList[0]._fat,
            'protein': _dailyMealList[0]._protein,
            'ingredients': breakfastIngredients,
          },
          'lunch': {
            'title': _dailyMealList[1]._title,
            'imageUrl': _dailyMealList[1]._imageUrl,
            'servings': _dailyMealList[1]._servings,
            'servingSize': _dailyMealList[1]._servingSize,
            'calory': _dailyMealList[1]._calory,
            'carbohydrate': _dailyMealList[1]._carbohydrate,
            'fat': _dailyMealList[1]._fat,
            'protein': _dailyMealList[1]._protein,
            'ingredients': lunchIngredients,
          },
          'dinner': {
            'title': _dailyMealList[2]._title,
            'imageUrl': _dailyMealList[2]._imageUrl,
            'servings': _dailyMealList[2]._servings,
            'servingSize': _dailyMealList[2]._servingSize,
            'calory': _dailyMealList[2]._calory,
            'carbohydrate': _dailyMealList[2]._carbohydrate,
            'fat': _dailyMealList[2]._fat,
            'protein': _dailyMealList[2]._protein,
            'ingredients': dinnerIngredients,
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

  void setBreakfast(
    List<DocumentSnapshot> documents,
    List<int> breakfastTagSizeList,
    int sumBreakfastRecipes,
    double breakfastLBCal,
    double breakfastUBCal,
  ) {
    //TODO: Breakfasts should have: apple, banana, egg, cheese, orange, potato, bread, avocado, juice.

    while (true) {
      var randFactor = Random();
      int tagIndex = 0;
      int recipeIndex = 0;
      int randIndex = randFactor.nextInt(sumBreakfastRecipes);
      for (int i = 0; i < breakfastTagSizeList.length; i++) {
        if (randIndex < breakfastTagSizeList[i]) {
          switch (i) {
            case 0:
              {
                tagIndex = Tag.apple.index;
              }
              break;

            case 1:
              {
                tagIndex = Tag.avocado.index;
              }
              break;

            case 2:
              {
                tagIndex = Tag.banana.index;
              }
              break;

            case 3:
              {
                tagIndex = Tag.bread.index;
              }
              break;

            case 4:
              {
                tagIndex = Tag.cheese.index;
              }
              break;

            case 5:
              {
                tagIndex = Tag.egg.index;
              }
              break;

            case 6:
              {
                tagIndex = Tag.juice.index;
              }
              break;

            case 7:
              {
                tagIndex = Tag.orange.index;
              }
              break;

            case 8:
              {
                tagIndex = Tag.potato.index;
              }
              break;
          }
          recipeIndex = randIndex;
          break;
        }
        randIndex -= breakfastTagSizeList[i];
      }

      var recipeJson = documents[tagIndex].data['Recipe'][recipeIndex];
      double mealCalory = recipeJson['nutrition']['nutrients'][0]['amount'];

      if (breakfastLBCal <= mealCalory * (breakfastUBCal ~/ mealCalory)) {
        _dailyMealList[0].setAllForMeal(
          title: recipeJson['title'],
          mealType: 0,
          imageUrl: recipeJson['image'],
          servings: (breakfastUBCal ~/ mealCalory),
          calory: mealCalory,
          fat: recipeJson['nutrition']['nutrients'][1]['amount'],
          carbohydrate: recipeJson['nutrition']['nutrients'][3]['amount'],
          protein: recipeJson['nutrition']['nutrients'][6]['amount'],
          servingSize: recipeJson['servings'],
        );

        for (int i = 0; i < recipeJson['extendedIngredients'].length; i++) {
          Ingredient tempIngre = Ingredient();
          tempIngre.setAllForIngredient(
            name: recipeJson['extendedIngredients'][i]['name'],
            amount: recipeJson['extendedIngredients'][i]['amount'],
            unit: recipeJson['extendedIngredients'][i]['unit'],
          );
          _dailyMealList[0]._ingredients.add(tempIngre);
        }
        break;
      }
    }
  }

  void setLunch(
    List<DocumentSnapshot> documents,
    List<int> lunchTagSizeList,
    int sumLunchRecipes,
    double lunchLBCal,
    double lunchUBCal,
  ) {
    //TODO: Lunches should have: beef, chicken, crab, ham, meat, pasta, pork, shrimp, steak.

    while (true) {
      var randFactor = Random();
      int tagIndex = 0;
      int recipeIndex = 0;
      int randIndex = randFactor.nextInt(sumLunchRecipes);
      for (int i = 0; i < lunchTagSizeList.length; i++) {
        if (randIndex < lunchTagSizeList[i]) {
          switch (i) {
            case 0:
              {
                tagIndex = Tag.beef.index;
              }
              break;

            case 1:
              {
                tagIndex = Tag.chicken.index;
              }
              break;

            case 2:
              {
                tagIndex = Tag.crab.index;
              }
              break;

            case 3:
              {
                tagIndex = Tag.ham.index;
              }
              break;

            case 4:
              {
                tagIndex = Tag.meat.index;
              }
              break;

            case 5:
              {
                tagIndex = Tag.pasta.index;
              }
              break;

            case 6:
              {
                tagIndex = Tag.pork.index;
              }
              break;

            case 7:
              {
                tagIndex = Tag.shrimp.index;
              }
              break;

            case 8:
              {
                tagIndex = Tag.steak.index;
              }
              break;
          }
          recipeIndex = randIndex;
          break;
        }
        randIndex -= lunchTagSizeList[i];
      }

      var recipeJson = documents[tagIndex].data['Recipe'][recipeIndex];
      double mealCalory = recipeJson['nutrition']['nutrients'][0]['amount'];

      if (lunchLBCal <= mealCalory * (lunchUBCal ~/ mealCalory)) {
        _dailyMealList[1].setAllForMeal(
          title: recipeJson['title'],
          mealType: 1,
          imageUrl: recipeJson['image'],
          servings: (lunchUBCal ~/ mealCalory),
          calory: mealCalory,
          fat: recipeJson['nutrition']['nutrients'][1]['amount'],
          carbohydrate: recipeJson['nutrition']['nutrients'][3]['amount'],
          protein: recipeJson['nutrition']['nutrients'][6]['amount'],
          servingSize: recipeJson['servings'],
        );

        for (int i = 0; i < recipeJson['extendedIngredients'].length; i++) {
          Ingredient tempIngre = Ingredient();
          tempIngre.setAllForIngredient(
            name: recipeJson['extendedIngredients'][i]['name'],
            amount: recipeJson['extendedIngredients'][i]['amount'],
            unit: recipeJson['extendedIngredients'][i]['unit'],
          );
          _dailyMealList[1]._ingredients.add(tempIngre);
        }
        break;
      }
    }
  }

  void setDinner(
    List<DocumentSnapshot> documents,
    List<int> dinnerTagSizeList,
    int sumDinnerRecipes,
    double dinnerLBCal,
    double dinnerUBCal,
  ) {
    //TODO: Dinners should have: cucumber, fish, mushroom, salad, salmon, sauce, soup,
    //TODO: spinach, tomato, tuna, vegetable.

    while (true) {
      var randFactor = Random();
      int tagIndex = 0;
      int recipeIndex = 0;
      int randIndex = randFactor.nextInt(sumDinnerRecipes);
      for (int i = 0; i < dinnerTagSizeList.length; i++) {
        if (randIndex < dinnerTagSizeList[i]) {
          switch (i) {
            case 0:
              {
                tagIndex = Tag.cucumber.index;
              }
              break;

            case 1:
              {
                tagIndex = Tag.fish.index;
              }
              break;

            case 2:
              {
                tagIndex = Tag.mushroom.index;
              }
              break;

            case 3:
              {
                tagIndex = Tag.salad.index;
              }
              break;

            case 4:
              {
                tagIndex = Tag.salmon.index;
              }
              break;

            case 5:
              {
                tagIndex = Tag.sauce.index;
              }
              break;

            case 6:
              {
                tagIndex = Tag.soup.index;
              }
              break;

            case 7:
              {
                tagIndex = Tag.spinach.index;
              }
              break;

            case 8:
              {
                tagIndex = Tag.tomato.index;
              }
              break;

            case 9:
              {
                tagIndex = Tag.tuna.index;
              }
              break;

            case 10:
              {
                tagIndex = Tag.vegetable.index;
              }
              break;
          }
          recipeIndex = randIndex;
          break;
        }
        randIndex -= dinnerTagSizeList[i];
      }

      var recipeJson = documents[tagIndex].data['Recipe'][recipeIndex];
      double mealCalory = recipeJson['nutrition']['nutrients'][0]['amount'];

      if (dinnerLBCal <= mealCalory * (dinnerUBCal ~/ mealCalory)) {
        _dailyMealList[2].setAllForMeal(
          title: recipeJson['title'],
          mealType: 2,
          imageUrl: recipeJson['image'],
          servings: (dinnerUBCal ~/ mealCalory),
          calory: mealCalory,
          fat: recipeJson['nutrition']['nutrients'][1]['amount'],
          carbohydrate: recipeJson['nutrition']['nutrients'][3]['amount'],
          protein: recipeJson['nutrition']['nutrients'][6]['amount'],
          servingSize: recipeJson['servings'],
        );

        for (int i = 0; i < recipeJson['extendedIngredients'].length; i++) {
          Ingredient tempIngre = Ingredient();
          tempIngre.setAllForIngredient(
            name: recipeJson['extendedIngredients'][i]['name'],
            amount: recipeJson['extendedIngredients'][i]['amount'],
            unit: recipeJson['extendedIngredients'][i]['unit'],
          );
          _dailyMealList[2]._ingredients.add(tempIngre);
        }
        break;
      }
    }
  }

  void setDailyPlan(
    String userOnlineId,
    List<DocumentSnapshot> documents,
    List<int> breakfastTagSizeList,
    int sumBreakfastRecipes,
    List<int> lunchTagSizeList,
    int sumLunchRecipes,
    List<int> dinnerTagSizeList,
    int sumDinnerRecipes,
    double userLBCalory,
    double userUBCalory,
  ) {
    //TODO: Breakfasts should have: apple, banana, egg, cheese, potato, bread, avocado.
    //TODO: Lunches should have: beef, chicken, curry, meat, pizza, pork, pasta.
    //TODO: Dinners should have: salad, sauce, soup, fish, vegetable, mushroom, tomato.
    setBreakfast(
      documents,
      breakfastTagSizeList,
      sumBreakfastRecipes,
      double.parse((userLBCalory * 35 / 100).toStringAsFixed(2)),
      double.parse((userUBCalory * 35 / 100).toStringAsFixed(2)),
    );

    setLunch(
      documents,
      lunchTagSizeList,
      sumLunchRecipes,
      double.parse((userLBCalory * 35 / 100).toStringAsFixed(2)),
      double.parse((userUBCalory * 35 / 100).toStringAsFixed(2)),
    );

    setDinner(
      documents,
      dinnerTagSizeList,
      sumDinnerRecipes,
      double.parse((userLBCalory * 30 / 100).toStringAsFixed(2)),
      double.parse((userUBCalory * 30 / 100).toStringAsFixed(2)),
    );

    for (int i = 0; i < 3; i++) {
      int servings = _dailyMealList[i]._servings;
      _calory += _dailyMealList[i]._calory * servings;
      _fat += _dailyMealList[i]._fat * servings;
      _carbohydrate += _dailyMealList[i]._carbohydrate * servings;
      _protein += _dailyMealList[i]._protein * servings;
    }
    _calory = double.parse(_calory.toStringAsFixed(2));
    _fat = double.parse(_fat.toStringAsFixed(2));
    _carbohydrate = double.parse(_carbohydrate.toStringAsFixed(2));
    _protein = double.parse(_protein.toStringAsFixed(2));
    _postDailyPlan(userOnlineId);
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

  set setCalory(double value) {
    _calory += value;
    _calory = double.parse(_calory.toStringAsFixed(2));
  }

  double get protein {
    return _protein;
  }

  set setProtein(double value) {
    _protein += value;
    _protein = double.parse(_protein.toStringAsFixed(2));
  }

  double get fat {
    return _fat;
  }

  set setFat(double value) {
    _fat += value;
    _fat = double.parse(_fat.toStringAsFixed(2));
  }

  double get carbohydrate {
    return _carbohydrate;
  }

  set setCarbohydrate(double value) {
    _carbohydrate += value;
    _carbohydrate = double.parse(_carbohydrate.toStringAsFixed(2));
  }

  List<Meal> get dailyMealList {
    return [..._dailyMealList];
  }

  bool get isChecked {
    return _isChecked;
  }

  List<Meal> get accessMealList {
    return _dailyMealList;
  }
}
