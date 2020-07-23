import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import '../models/product.dart';
import '../providers/products.dart';
import '../widgets/food_list_view.dart';


import '../providers/data_helper.dart';
import '../widgets/category.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'scan.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pse_assignment/widgets/BottomNavigator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../widgets/delegate_search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseUser user;
  String name = '';

  String res = "Sample code";

//Text input controller
  var _controller = TextEditingController();
  var input;
  FoodData foodData = FoodData();

  @override
  void initState() {
    firstLoad();
    super.initState();
  }

//  void getListFromFireBase() async {
//    suggestion.clear();
//    QuerySnapshot querySnapshot =
//        await Firestore.instance.collection('data').getDocuments();
//    for (int i = 0; i < querySnapshot.documents.length; i++) {
//      var a = querySnapshot.documents[i];
//      suggestion.add(a.documentID);
//      print(suggestion[i]);
//    }
//  }

  void firstLoad() async {
    await foodData.getRandomProduct(context);
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

  //this function is for uploading data to firebase
//  void updateUI(String name) async {
//    var data = await foodData.getFoodData(name, 10, 10);
//    print(data);
//    foodData.uploadDataFromApiToFireBase(data, 10, name);
//  }

  void navigateToFilterScreen(BuildContext context) {
    //NavigateToFilterScreen()
    Navigator.pushNamed(context, 'FilterScreen');
  }

  void searchOnSubmitted(String name) {
    print(name);
    foodData.getRecipe(context, name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F7F8),
      bottomNavigationBar: BottomBar(),
      body: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              //height: size.height * 0.35,
              decoration: BoxDecoration(
                color: Color(0xFFFCECC5),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Recipe and Product',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF07084B),
                        fontSize: 33,
                        fontFamily: 'Pacifico',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showSearch(context: context, delegate: SearchInput());
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                          horizontal: 25,
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(29.5),
                        ),
                        height: 50,
                        width: double.infinity,
                        child: Stack(
                          children: <Widget>[
                            Align(
                              child: Icon(
                                Icons.search,
                                color: Colors.grey,
                              ),
                              alignment: Alignment.centerLeft,
                            ),
                            Center(
                              child: Text(
                                'Search...',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RoundTypeButton(
                          color: Color(0xFFFEC2C2),
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
