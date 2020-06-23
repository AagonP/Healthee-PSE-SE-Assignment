import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import '../widgets/drawer_view.dart';
import '../models/product.dart';
import '../providers/products.dart';
import '../widgets/food_list_view.dart';
import '../providers/food_data.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
                      Navigator.pushNamed(context, 'ScanScreen');
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

class RoundTypeButton extends StatefulWidget {
  final Color color;
  final String image;
  final String title;
  RoundTypeButton(
      {@required this.color, @required this.image, @required this.title});

  @override
  _RoundTypeButtonState createState() => _RoundTypeButtonState();
}

class _RoundTypeButtonState extends State<RoundTypeButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        RawMaterialButton(
          constraints: BoxConstraints.tightFor(
            width: 50.0,
            height: 50.0,
          ),
          onPressed: () {
            setState(() {
              List<Product> currentList =
                  Provider.of<Products>(context).products;
              for (int i = 0; i < currentList.length; i++) {
                switch (widget.title) {
                  case 'Vegan':
                    if (!currentList.elementAt(i).vegetarian)
                      Provider.of<Products>(context).clearProduct();
                    break;
                  case 'DairyFree':
                    if (!currentList.elementAt(i).dairyFree)
                      Provider.of<Products>(context)
                          .removeProduct(currentList.elementAt(i));
                    break;
                  case 'LowFodMap':
                    if (!currentList.elementAt(i).dairyFree)
                      Provider.of<Products>(context)
                          .removeProduct(currentList.elementAt(i));
                    break;
                }
              }
            });
          },
          elevation: 2.0,
          fillColor: widget.color,
          child: Image.asset(
            widget.image,
            fit: BoxFit.cover,
            width: 30.0,
            height: 30.0,
          ),
          shape: CircleBorder(
            side: BorderSide(color: Colors.white),
          ),
        ),
        Text(
          widget.title,
          style: TextStyle(fontSize: 11.0),
        ),
      ],
    );
  }
}
