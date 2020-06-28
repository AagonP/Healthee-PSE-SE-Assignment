import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import '../widgets/drawer_view.dart';
import '../models/product.dart';
import '../providers/products.dart';
import '../widgets/food_list_view.dart';
import '../providers/data_helper.dart';
import '../widgets/category.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../screens/scan.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void updateAfterScan(var key) {
    setState(() {
      res = key.toString();
    });
  }

  void doScanning() {
    // Navigator.pushNamed(context, "ScanScreen");
    updateAfterScan(Scan.scanner());
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(Scan.key.toString()),
          );
        });
  }

  String res = "Sample code";

//Text input controller
  var _controller = TextEditingController();
  List<String> id = List(20);
  var input;
  FoodData foodData = FoodData();

//Update UI when loading product list
  void updateUI(String name) async {
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
  }

  void navigateToFilterScreen(BuildContext context) {
    //NavigateToFilterScreen()
    Navigator.pushNamed(context, 'FilterScreen');
  }

  void searchOnSubmitted(String context) {
    //onSubmittedChange(String key)
    print(context);
    input = context;
    updateUI(input);
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
              //TODO: Add user information here
              //TODO: Generate string ID for user
              //TODO: Save user info
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
            //Title "Healthee"
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
            //Second Title "Nutrion & Diet"
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
                    //Search input field
                    child: Container(
                      height: 45.0,
                      child: TextField(
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
                // Filter search
                Card(
                  child: IconButton(
                    onPressed: () {
                      navigateToFilterScreen(context);
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
                //Scan screen
                Card(
                  child: IconButton(
                    onPressed: () {
                      doScanning();
                    },
                    icon: Icon(Icons.camera_alt),
                  ),
                ),
              ],
            ),
            //Food filter
            Row(
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
            ),
            FoodListView(),
          ],
        ),
      ),
    );
  }
}
