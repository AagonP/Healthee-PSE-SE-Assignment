import 'package:pse_assignment/models/product.dart';

import 'data_helper.dart';
import '../models/product.dart';

class FoodData {
  List<int> id = List(20);
  List<dynamic> foodRecipeJson = List(20);
  List<Product> foodData = List(20);
  Future<dynamic> getFoodData(String name) async {
    DataHelper dataHelper = DataHelper();
    int numberOfRecipe = 20;
    String idUrl =
        'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/search?number=20&offset=0&query=$name';
    var foodIdJson = await dataHelper.fetchData(idUrl);
    return foodIdJson;

  }
}

//for (int i = 0; i < 20; i++) {
//var foodId = foodIdJson['results'][i]['id'];
//id[i] = foodId.toInt();
//}
//for (int i = 0; i < 20; i) {
//String _id = id[i].toString();
//String recipeUrl =
//'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/$_id/information';
//foodRecipeJson[i] = await dataHelper.fetchData(recipeUrl);
//bool vegetarian = foodRecipeJson[i]['vegetarian'];
//bool glutenFree = foodRecipeJson[i]['glutenFree'];
//bool dairyFree = foodRecipeJson[i]['dairyFree'];
//bool veryHealthy = foodRecipeJson[i]['veryHealthy'];
//bool popular = foodRecipeJson[i]['veryPopular'];
//bool cheap = foodRecipeJson[i]['cheap'];
//bool lowFodmap = foodRecipeJson[i]['lowFodmap'];
//String title = foodRecipeJson[i]['title'];
//String photoURL = foodRecipeJson[i]['image'];
//Product product = Product(
//vegetarian: vegetarian,
//glutenFree: glutenFree,
//dairyFree: dairyFree,
//veryHealthy: veryHealthy,
//popular: popular,
//cheap: cheap,
//lowFodmap: lowFodmap,
//name: title,
//photoURL: photoURL,
//);
//foodData[i] = product;
//}
//return foodData;