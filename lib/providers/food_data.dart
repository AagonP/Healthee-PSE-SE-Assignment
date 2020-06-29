import 'package:pse_assignment/models/product.dart';

import 'data_helper.dart';
import '../models/product.dart';
import 'dart:math';
import '../providers/user_input.dart';

const int numberOfRecipe = 20;

class FoodData {
  DataHelper dataHelper = DataHelper();
  List<int> id = List(numberOfRecipe);
  List<dynamic> foodRecipeJson = List(numberOfRecipe);
  List<Product> foodData = List(numberOfRecipe);
  Random random = Random();
  Future<dynamic> getFoodData(String name) async {
    DataHelper dataHelper = DataHelper();
    int offset = random.nextInt(50);
    String idUrl =
        'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/search?number=${numberOfRecipe.toString()}&offset=${offset.toString()}&query=$name';
    var foodIdJson = await dataHelper.fetchData(idUrl);
    return foodIdJson;
  }

  Future<Product> decodeProduct(String id) async {
    String recipeUrl =
        'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/$id/information';
    dynamic jsonRecipe = await dataHelper.fetchData(recipeUrl);
    bool vegetarian = jsonRecipe['vegetarian'];
    bool glutenFree = jsonRecipe['glutenFree'];
    bool dairyFree = jsonRecipe['dairyFree'];
    bool veryHealthy = jsonRecipe['veryHealthy'];
    bool popular = jsonRecipe['veryPopular'];
    bool cheap = jsonRecipe['cheap'];
    bool lowFodmap = jsonRecipe['lowFodmap'];
    String title = jsonRecipe['title'];
    String photoURL = jsonRecipe['image'];
    List<String> ingredientList = [];
    List<String> amountList = [];
    List<String> unitList = [];
    int numberofIngredients = jsonRecipe['extendedIngredients'].length;
    for (int j = 0; j < numberofIngredients; j++) {
      String ingredient = jsonRecipe['extendedIngredients'][j]['name'];
      var amount = jsonRecipe['extendedIngredients'][j]['amount'];
      String unit = jsonRecipe['extendedIngredients'][j]['unit'];
      ingredientList.add(ingredient);
      amountList.add(amount.toStringAsFixed(2));
      unitList.add(unit);
    }
    Product product = Product(
      vegetarian: vegetarian,
      glutenFree: glutenFree,
      dairyFree: dairyFree,
      veryHealthy: veryHealthy,
      popular: popular,
      cheap: cheap,
      lowFodmap: lowFodmap,
      name: title,
      photoURL: photoURL,
      type: 'food',
      barCode: '1',
      qrCode: '1',
      description: 'sth',
      ingredients: ingredientList,
      amount: amountList,
      unit: unitList,
      illness:
          setIllnessBasedOnAPI(vegetarian, glutenFree, dairyFree, lowFodmap),
    );
    return product;
  }
}
