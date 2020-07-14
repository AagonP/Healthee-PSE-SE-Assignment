import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SearchFoodForPlan extends StatefulWidget {
  @override
  _SearchFoodForPlanState createState() => _SearchFoodForPlanState();
}

class _SearchFoodForPlanState extends State<SearchFoodForPlan> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser user;
  String name = '';
  @override
  void initState() {
    super.initState();

    getUser();
  }

  void getUser() async {
    user = await _auth.currentUser();
    setState(() {
      if (user != null) {
        name = user.displayName;
      } else
        name = '';
    });
  }

  String res = "Sample code";

//Text input controller
  var _controller = TextEditingController();
  List<String> id = List(20);
  var input;
  //FoodData foodData = FoodData();

//Update UI when loading product list
  /*void updateUI(String name) async {
    Provider.of<Products>(context).clearProduct();
    var data = await foodData.getFoodData(name);
    for (int i = 0; i < 20; i++) {
      var foodId = data['results'][i]['id'];
      id[i] = foodId.toString();
    }
    for (int i = 0; i < 20; i++) {
      Product product = await foodData.decodeProduct(id[i]);
      if (product.name != null)
        Provider.of<Products>(context).addProduct(product);
    }
    Provider.of<Products>(context).updateDisplayProduct('all');
  }*/

  void navigateToFilterScreen(BuildContext context) {
    //NavigateToFilterScreen()
    Navigator.pushNamed(context, 'FilterScreen');
  }

  void searchOnSubmitted(String context) {
    //onSubmittedChange(String key)
    print(context);
    input = context;
    //updateUI(input);
  }

  @override
  Widget build(BuildContext context) {
    //List<Product> displayList = Provider.of<Products>(context).products;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
      ),
      //Drawer here

      body: Column(
        children: <Widget>[
          //Title "Healthee"
          Container(
            margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'Breakfast',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'Pacifico',
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
                  //Search input field
                  child: Container(
                    height: 45.0,
                    child: TextField(
                      autofocus: false,
                      onSubmitted: (context) {
                        searchOnSubmitted(context);
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
                        hintText: 'Search meal...',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
              ),
              // Filter search
              /*Card(
                child: IconButton(
                  onPressed: () {
                    navigateToFilterScreen(context);
                  },
                  icon: Badge(
                      badgeColor: Colors.white,
                      animationType: BadgeAnimationType.scale,
                      badgeContent: Text((Provider.of<Products>(context)
                              .filteringProducts
                              .length)
                          .toString()),
                      child: Icon(Icons.shopping_cart)), //filter
                ),
              ),*/
              //Scan screen
              /*Card(
                child: IconButton(
                  onPressed: () {
                  },
                  icon: Icon(Icons.camera_alt),
                ),
              ),*/
            ],
          ),
          //Food filter
          /*Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RoundTypeButton(
                color: Color(0xFFF7F6C5),
                image: 'image/food.png',
                title: 'Vegan',
              ),
              RoundTypeButton(
                color: Color(0xFFCEFFC0),
                image: 'image/dairy.png',
                title: 'DairyFree',
              ),
              RoundTypeButton(
                color: Color(0xFFFEE1C7),
                image: 'image/fruit.png',
                title: 'LowFodMap',
              ),
              RoundTypeButton(
                color: Color(0xFFFDDFFA),
                image: 'image/coin.png',
                title: 'Cheap',
              ),
            ],
          ),*/
          Padding(
            padding: EdgeInsets.all(10),
          ),
          /*Expanded(
            child: FoodListView(),
          ),*/
        ],
      ),
    );
  }
}
