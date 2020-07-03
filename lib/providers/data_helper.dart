import 'package:pse_assignment/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/product.dart';
import 'dart:math';
import 'user_input.dart';
import '../providers/products.dart';

const int numberOfRecipe = 20;

class DataHelper {
  Future<dynamic> fetchData(String url) async {
    final response = await http.get(
      url,
      headers: {
        'X-RapidAPI-Host':
            'spoonacular-recipe-food-nutrition-v1.p.rapidapi.com',
        'X-RapidAPI-Key': '8955002e2dmsh32a65a55912f68bp12b80cjsnc1a962733782',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(utf8.decode(response.bodyBytes));
    } else
      throw Exception('Connection failed');
  }
}

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

class UserSavedProductsDataHelper {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static Future<void> postUserSavedProducts(
      Map<String, dynamic> jsonProducts, String userID) async {
    await Firestore.instance
        .collection('users')
        .document(userID)
        .setData(jsonProducts);
  }

  static Product decodeProduct(var jsonRecipe) {
    bool vegetarian = (jsonRecipe['vegetarian'] == 'true') ? true : false;
    bool glutenFree = (jsonRecipe['glutenFree'] == 'true') ? true : false;
    bool dairyFree = (jsonRecipe['dairyFree'] == 'true') ? true : false;
    bool veryHealthy = (jsonRecipe['veryHealthy'] == 'true') ? true : false;
    bool popular = (jsonRecipe['veryPopular'] == 'true') ? true : false;
    bool cheap = (jsonRecipe['cheap'] == 'true') ? true : false;
    bool lowFodmap = (jsonRecipe['lowFodmap'] == 'true') ? true : false;
    String name = jsonRecipe['name'];
    String photoURL = jsonRecipe['photoURL'];
    List<String> ingredientList = [];
    List<String> amountList = [];
    List<String> unitList = [];
    int numberofIngredients = jsonRecipe['ingredients'].length;
    for (int j = 0; j < numberofIngredients; j++) {
      String ingredient = jsonRecipe['ingredients'][j];
      var amount = jsonRecipe['amount'][j];
      String unit = jsonRecipe['unit'][j];
      ingredientList.add(ingredient);
      amountList.add(amount);
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
      name: name,
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

  static Future<List<Product>> fetchUserSavedProducts(String userID) async {
    List<Product> savedProducts = List();
    var hold;
    var temp = await Firestore.instance
        .collection('users')
        .document(userID)
        .get()
        .then((DocumentSnapshot ds) {
      Product holder;
      for (int index = 0; index < ds.data['Products'].length; index++) {
        holder = decodeProduct(ds.data['Products'][index]);
        savedProducts.add(holder);
      }
    });
    return savedProducts;
  }

  static Future<void> removeUserSavedProduct(String userID) async {
    Firestore.instance.collection('users').document(userID).delete();
  }

  static Future<String> getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    return user.uid.toString();
  }
}
