import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import '../widgets/drawer_view.dart';
import '../models/product.dart';
import '../providers/products.dart';
import '../widgets/food_list_view.dart';
import '../providers/food_data.dart';
import '../widgets/category.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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

  String res = "Sample code";
  String scan = "";

  Future scanner() async {
    scan = await FlutterBarcodeScanner.scanBarcode(
        "#009922", "Cancel", true, ScanMode.DEFAULT);
    setState(() {
      res = scan;
    });
  }

  var _controller = TextEditingController();
  List<String> id = List(20);
  var input;
  FoodData foodData = FoodData();

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
                    onPressed: () {
                      // Navigator.pushNamed(context, "ScanScreen");
                      scanner();
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(res),
                            );
                          });
                    },
                    icon: Icon(Icons.camera_alt),
                  ),
                ),
              ],
            ),
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
