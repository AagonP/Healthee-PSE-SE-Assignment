import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

import '../widgets/drawer_view.dart';
import '../models/product.dart';
import '../providers/products.dart';
import '../widgets/food_list_view.dart';
import '../providers/data_helper.dart';
import '../providers/food_data.dart';
import '../providers/user_input.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _controller = TextEditingController();
  List<String> id = List(20);
  List<dynamic> foodRecipeJson = List(20);
  DataHelper dataHelper = DataHelper();
  var input;

  FoodData foodData = FoodData();

  void updateUI(String name) async {
    Provider.of<Products>(context).clearProduct();
    var data = await foodData.getFoodData(name);
    for (int i = 0; i < 20; i++) {
      var foodId = data['results'][i]['id'];
      id[i] = foodId.toString();
    }
    //int id = data['results'][0]['id'];
    for (int i = 0; i < 20; i++) {
      String recipeUrl =
          'https://spoonacular-recipe-food-nutrition-v1.p.rapidapi.com/recipes/${id[i]}/information';
      foodRecipeJson[i] = await dataHelper.fetchData(recipeUrl);
      bool vegetarian = foodRecipeJson[i]['vegetarian'];
      bool glutenFree = foodRecipeJson[i]['glutenFree'];
      bool dairyFree = foodRecipeJson[i]['dairyFree'];
      bool veryHealthy = foodRecipeJson[i]['veryHealthy'];
      bool popular = foodRecipeJson[i]['veryPopular'];
      bool cheap = foodRecipeJson[i]['cheap'];
      bool lowFodmap = foodRecipeJson[i]['lowFodmap'];
      String title = foodRecipeJson[i]['title'];
      String photoURL = foodRecipeJson[i]['image'];
      List<String> Ingredients = [];
      List<String> Amount = [];
      List<String> Unit = [];
      int numberofIngredients = foodRecipeJson[i]['extendedIngredients'].length;
      for (int j = 0; j < numberofIngredients; j++) {
        String ingredient = foodRecipeJson[i]['extendedIngredients'][j]['name'];
        var amount = foodRecipeJson[i]['extendedIngredients'][j]['amount'];
        String unit = foodRecipeJson[i]['extendedIngredients'][j]['unit'];
        Ingredients.add(ingredient);
        Amount.add(amount.toStringAsFixed(2));
        Unit.add(unit);
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
        ingredients: Ingredients,
        amount: Amount,
        unit: Unit,
        illness:
            setIllnessBasedOnAPI(vegetarian, glutenFree, dairyFree, lowFodmap),
      );
      if (product.name != null)
        Provider.of<Products>(context).addProduct(product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: TextField(
                              decoration:
                                  InputDecoration(hintText: 'Type of illness'),
                            ),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextField(
                            decoration:
                                InputDecoration(hintText: 'Type of illness'),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextField(
                            decoration:
                                InputDecoration(hintText: 'Type of illness'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            icon: Icon(Icons.account_circle),
            iconSize: 30,
          ),
        ],
      ),
      //Drawer here
      drawer: DrawerView(),
      body: Container(
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Healthee',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 50,
                    fontFamily: 'Pacifico',
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nutrition & Diet',
                  style: TextStyle(
                    fontSize: 30,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Container(
                      height: 45.0,
                      child: TextField(
                        onSubmitted: (context) {
                          print(context);
                          input = context;
                          updateUI(input);
                        },
                        controller: _controller,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () => _controller.clear(),
                            icon: Icon(
                              Icons.clear,
                              color: Colors.grey,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Search product..',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'FilterScreen');
                      print(Provider.of<UserInput>(context)
                          .healthInput[0]
                          .obesity);
                    },
                    icon: Badge(
                        badgeColor: Colors.white,
                        animationType: BadgeAnimationType.scale,
                        badgeContent: Text((Provider.of<Products>(context)
                                .selectedProducts
                                .length)
                            .toString()),
                        child: Icon(Icons.shopping_cart)), //filter
                  ),
                ),
                Card(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.camera_alt),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    //First button
                  },
                  icon: Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () {
                    //Second button
                  },
                  icon: Icon(Icons.add),
                ),
                RawMaterialButton(
                  constraints: BoxConstraints.tightFor(
                    width: 50.0,
                    height: 50.0,
                  ),
                  onPressed: () {},
                  elevation: 2.0,
                  fillColor: Color(0xFFFEE1C7),
                  child: Image.asset(
                    'image/food.png',
                    fit: BoxFit.cover,
                    width: 30.0,
                    height: 30.0,
                  ),
                  shape: CircleBorder(
                    side: BorderSide(color: Colors.white),
                  ),
                ),
                RawMaterialButton(
                  constraints: BoxConstraints.tightFor(
                    width: 50.0,
                    height: 50.0,
                  ),
                  onPressed: () {},
                  elevation: 2.0,
                  fillColor: Color(0xFFFDDFFA),
                  child: Image.asset(
                    'image/flour.png',
                    fit: BoxFit.cover,
                    width: 30.0,
                    height: 30.0,
                  ),
                  shape: CircleBorder(
                    side: BorderSide(color: Colors.white),
                  ),
                ),
              ],
            ),
            FoodListView(),
          ],
        ),
      ),
    );
  }
}

//for (int i = 0; i < 20; i++) {
//var foodId = data['results'][i]['id'];
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
