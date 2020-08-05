import 'package:flutter/material.dart';
import 'package:pse_assignment/models/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/product.dart';
import 'dart:math';
import 'user_health_data.dart';
import 'list_of_entry.dart';
import 'package:pse_assignment/models/product.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

const int numberOfRecipe = 1;

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
  Future<Map> getFoodData(String name, int num, int off) async {
    DataHelper dataHelper = DataHelper();
    //int offset = random.nextInt(1);
    String idUrl =
        'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/search?number=${num.toString()}&offset=${off.toString()}&query=$name';
    Map foodIdJson = await dataHelper.fetchData(idUrl);
    return foodIdJson;
  }

  Product decodeProduct(dynamic jsonRecipe) {
    bool vegetarian = jsonRecipe['vegetarian'];
    bool glutenFree = jsonRecipe['glutenFree'];
    bool dairyFree = jsonRecipe['dairyFree'];
    bool veryHealthy = jsonRecipe['veryHealthy'];
    bool popular = jsonRecipe['veryPopular'];
    bool cheap = jsonRecipe['cheap'];
    bool lowFodmap = jsonRecipe['lowFodmap'];
    String title = jsonRecipe['title'];
    String photoURL = jsonRecipe['image'];
    double calory = jsonRecipe['nutrition']['nutrients'][0]['amount'];
    double fat = jsonRecipe['nutrition']['nutrients'][1]['amount'];
    double carbohydrate = jsonRecipe['nutrition']['nutrients'][3]['amount'];
    double protein = jsonRecipe['nutrition']['nutrients'][6]['amount'];
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
      calories: calory,
      protein: protein,
      fat: fat,
      carbohydrate: carbohydrate,
      illness:
          setIllnessBasedOnAPI(vegetarian, glutenFree, dairyFree, lowFodmap),
    );
    return product;
  }

  Future<void> getRandomProduct(BuildContext context) async {
    List<dynamic> randomJson = [];
    Random random = Random();
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection('data').getDocuments();
    Provider.of<Products>(context).clearProduct();
    for (int i = 0; i < 10; i++) {
      DocumentSnapshot documentSnapshot = querySnapshot
          .documents[random.nextInt(querySnapshot.documents.length)];
      randomJson.add(documentSnapshot.data['Recipe']
          [random.nextInt(documentSnapshot.data['Recipe'].length)]);
    }
    for (int i = 0; i < 10; i++) {
      Product product = decodeProduct(randomJson[i]);
      Provider.of<Products>(context).addProduct(product);
    }
    Provider.of<Products>(context).updateDisplayProduct('all');
  }

  Future<void> uploadProduct(Map<String, dynamic> json) async {
    await Firestore.instance
        .collection('data')
        .document('Product')
        .setData(json, merge: true);
  }

  void addRecipeToList(Map json, String entry) {
    Firestore.instance.collection('data').document(entry).updateData({
      "Recipe": FieldValue.arrayUnion([json])
    });
  }

  Future<void> getRecipe(BuildContext context, String name) async {
    Provider.of<Products>(context).clearProduct();
    DocumentSnapshot documentSnapshot = await getEntry(name);
    List<dynamic> recipe = documentSnapshot.data['Recipe'];
    for (int i = 0; i < 10; i++) {
      Product product = decodeProduct(recipe[i]);
      Provider.of<Products>(context).addProduct(product);
    }
    Provider.of<Products>(context).updateDisplayProduct('all');
  }

  Future<QuerySnapshot> getQuery() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection('data').getDocuments();
    return querySnapshot;
  }

  Future<DocumentSnapshot> getEntry(String name) async {
    DocumentSnapshot documentSnapshot =
        await Firestore.instance.collection('data').document(name).get();
    return documentSnapshot;
  }

//  void uploadDataFromApiToFireBase(dynamic data, int num, String name) async {
//    List<String> id = List(num);
//    id.forEach((element) {});
//    DataHelper dataHelper = DataHelper();
//    for (int i = 0; i < num; i++) {
//      var foodId = data['results'][i]['id'];
//      id[i] = foodId.toString();
//      String recipeUrl =
//          'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/${id[i]}/information?includeNutrition=true';
//      Map jsonRecipe = await dataHelper.fetchData(recipeUrl);
//      jsonRecipe.removeWhere((key, value) => removeEntry.contains(key));
//      jsonRecipe['nutrition'].remove('ingredients');
//      jsonRecipe['nutrition']['nutrients']
//          .removeWhere((value) => !keepNutrient.contains(value['title']));
//      jsonRecipe['extendedIngredients'].forEach((element) {
//        element.removeWhere((key, value) => !keepIngredientValue.contains(key));
//      });
//      addRecipeToList(jsonRecipe, name);
//    }
//  }
//
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

  static Product decodeProductFromJson(var jsonData) {
    bool vegetarian = (jsonData['vegetarian'] == 'true') ? true : false;
    bool glutenFree = (jsonData['glutenFree'] == 'true') ? true : false;
    bool dairyFree = (jsonData['dairyFree'] == 'true') ? true : false;
    bool veryHealthy = (jsonData['veryHealthy'] == 'true') ? true : false;
    bool popular = (jsonData['veryPopular'] == 'true') ? true : false;
    bool cheap = (jsonData['cheap'] == 'true') ? true : false;
    bool lowFodmap = (jsonData['lowFodmap'] == 'true') ? true : false;
    String name = jsonData['name'];
    String photoURL = jsonData['photoURL'];
    List<String> ingredientList = [];
    List<String> amountList = [];
    List<String> unitList = [];
    int numberofIngredients = jsonData['ingredients'].length;
    double calory = jsonData['calories'];
    double fat = jsonData['fat'];
    double carbohydrate = jsonData['carbohydrate'];
    double protein = jsonData['protein'];
    for (int j = 0; j < numberofIngredients; j++) {
      String ingredient = jsonData['ingredients'][j];
      var amount = jsonData['amount'][j];
      String unit = jsonData['unit'][j];
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
      calories: calory,
      fat: fat,
      carbohydrate: carbohydrate,
      protein: protein,
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
        holder = decodeProductFromJson(ds.data['Products'][index]);
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
