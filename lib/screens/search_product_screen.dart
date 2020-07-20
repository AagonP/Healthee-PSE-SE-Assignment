import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';
import '../providers/products.dart';
import '../widgets/food_list_view.dart';
import '../providers/data_helper.dart';
import '../widgets/category.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'scan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser user;
  String name = '';
  @override
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
  //List<String> id = List(20);
  var input;
  FoodData foodData = FoodData();

  //this function is for uploading data to firebase
  void uploadData(String name) async {
    var data = await foodData.getFoodData(name, 10, 0);
    print(data);
    foodData.uploadDataFromApiToFireBase(data, 10, name);
  }

  //Update UI when loading product list
  void updateUI(String name) async {
    Provider.of<Products>(context).clearProduct();
    DocumentSnapshot documentSnapshot = await foodData.getEntry(name);
    List<dynamic> recipe = documentSnapshot.data['Recipe'];

    for (int i = 0; i < 10; i++) {
      Product product = await foodData.decodeProduct(recipe[i]);
      if (product.name != null)
        Provider.of<Products>(context).addProduct(product);
    }
    Provider.of<Products>(context).updateDisplayProduct('all');
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      bottomNavigationBar: BottomBar(),
      body: Column(
        children: <Widget>[
          //Title "Healthee"
          SafeArea(
            child: Container(
              //height: size.height * 0.4,
              decoration: BoxDecoration(
                color: Color(0xFFFDF4DE),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Recipe and Product',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF07084B),
                        fontSize: 30,
                        fontFamily: 'Pacifico',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 7,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29.5),
                      ),
                      child: TextField(
                        controller: _controller,
                        autofocus: false,
                        onSubmitted: (context) {
                          searchOnSubmitted(context);
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () => _controller.clear(),
                            icon: Icon(
                              Icons.clear,
                              color: Colors.grey,
                            ),
                          ),
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          icon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                      ),
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
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ),

          Expanded(
            child: FoodListView(),
          ),
        ],
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 70,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BottomNavItem(
            title: 'Generate',
            svgScr: 'image/search.svg',
            press: () {},
          ),
          BottomNavItem(
            title: 'Scan',
            svgScr: 'image/price.svg',
            press: () {},
          ),
          BottomNavItem(
            title: 'Favorite',
            svgScr: 'image/love-and-romance.svg',
            press: () {},
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatefulWidget {
  final String title;
  final String svgScr;
  final Function press;
  bool isActive = false;
  BottomNavItem(
      {@required this.title, @required this.svgScr, @required this.press});
  @override
  _BottomNavItemState createState() => _BottomNavItemState();
}

class _BottomNavItemState extends State<BottomNavItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.isActive = !widget.isActive;
        });
        widget.press();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SvgPicture.asset(
            widget.svgScr,
            color: widget.isActive ? Color(0xFFF1CB57) : Colors.black87,
          ),
          Text(
            widget.title,
            style: TextStyle(
                fontSize: 12.0,
                color: widget.isActive ? Color(0xFFF1CB57) : Colors.black87),
          ),
        ],
      ),
    );
    ;
  }
}

//
//Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Expanded(
//                child: Card(
//                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                  //Search input field
//                  child: Container(
//                    height: 45.0,
//                    child: TextField(
//                      autofocus: false,
//                      onSubmitted: (context) {
//                        searchOnSubmitted(context);
//                      },
//                      controller: _controller,
//                      decoration: InputDecoration(
//                        suffixIcon: IconButton(
//                          onPressed: () => _controller.clear(),
//                          icon: Icon(
//                            Icons.clear,
//                            color: Colors.grey,
//                          ),
//                        ),
//                        border: OutlineInputBorder(
//                          borderSide: BorderSide.none,
//                        ),
//                        hintText: 'Search product..',
//                        hintStyle: TextStyle(
//                          color: Colors.grey,
//                        ),
//                        prefixIcon: Icon(Icons.search),
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//              // Filter search
//              Card(
//                child: IconButton(
//                  onPressed: () {
//                    navigateToFilterScreen(context);
//                  },
//                  icon: Badge(
//                      badgeColor: Colors.white,
//                      animationType: BadgeAnimationType.scale,
//                      badgeContent: Text((Provider.of<Products>(context)
//                              .filteringProducts
//                              .length)
//                          .toString()),
//                      child: Icon(Icons.shopping_cart)), //filter
//                ),
//              ),
//              //Scan screen
//              Card(
//                child: IconButton(
//                  onPressed: () {
//                    doScanning();
//                  },
//                  icon: Icon(Icons.camera_alt),
//                ),
//              ),
//            ],
//          ),
//          //Food filter
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            children: <Widget>[
//              RoundTypeButton(
//                color: Color(0xFFF7F6C5),
//                image: 'image/food.png',
//                title: 'Vegan',
//              ),
//              RoundTypeButton(
//                color: Color(0xFFCEFFC0),
//                image: 'image/dairy.png',
//                title: 'DairyFree',
//              ),
//              RoundTypeButton(
//                color: Color(0xFFFEE1C7),
//                image: 'image/fruit.png',
//                title: 'LowFodMap',
//              ),
//              RoundTypeButton(
//                color: Color(0xFFFDDFFA),
//                image: 'image/coin.png',
//                title: 'Cheap',
//              ),
//            ],
//          ),
//          Padding(
//            padding: EdgeInsets.all(10),
//          ),
//          Expanded(
//            child: FoodListView(),
//          ),
