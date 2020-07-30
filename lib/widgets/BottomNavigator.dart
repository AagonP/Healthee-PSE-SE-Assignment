import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pse_assignment/filter_by_illness/filter_by_illness_controllers/filter_screen_controller.dart';
import 'package:pse_assignment/providers/data_helper.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../screens/scan.dart';
import '../filter_by_illness/filter_by_illness_controllers/filter_screen_controller.dart';
import '../filter_by_illness/filter_by_illness_controllers/saved_products_screen_controller.dart';
import '../models/product.dart';
import '../providers/user_health_data.dart';
import '../filter_by_illness/filter_by_illness_screens/saved_products_screen.dart';

int selectedIndex = -1;

class BottomBar extends StatefulWidget {
  final Function callback;
  BottomBar({this.callback});
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> with FilterScreenController {
  FoodData foodData = FoodData();

  void displayRandom() async {
    Provider.of<Products>(context).clearProduct();
    await foodData.getRandomProduct(context);
  }

  void autoGenerateProduct(BuildContext context) async {
    var searchKey = 'apple';
    String key = searchKey;
    print(key);
    if (searchKey == null) return;
    FoodData foodData = FoodData();
    Provider.of<Products>(context).clearProduct();

    //Get a new random food name
    DocumentSnapshot documentSnapshot = await foodData.getEntry(key);
    List<dynamic> recipe = documentSnapshot.data['Recipe'];
    for (int i = 0; i < 10; i++) {
      Product product = await foodData.decodeProduct(recipe[i]);
      if (product.name != null)
        //check if product is approriate to user illness input
        Provider.of<Products>(context)
            .doFilter(Provider.of<UserHealthData>(context), product);
      print(product.name);
      if (product.isHealthy != false) {
        Provider.of<Products>(context).addProduct(product);
      }
    }

    Provider.of<Products>(context).updateDisplayProduct('all');
  }

  Future <void> scan() async {
    await Scan.scanner();
    print(Scan.key);
    DocumentSnapshot documentSnapshot = await getEntry(Scan.key);
    print(documentSnapshot["name"]);
    ScanProduct product = decodeProduct(documentSnapshot);
    print(product.name);
    if (Scan.key != null )
      {
        print("-100");
        Navigator.pushNamed(context, "ScanView",arguments: product);
      }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      height: 70,
      color: Colors.white,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: BottomNavItem(
              title: 'Homepage',
              svgScr: 'image/sydney-opera-house.svg',
              index: 0,
              press: () {
                Navigator.pop(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: BottomNavItem(
              title: 'Generate',
              svgScr: 'image/search.svg',
              index: 1,
              press: () {
                autoGenerateProduct(context);
                setState(() {
                  selectedIndex = 1;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: BottomNavItem(
              title: 'Scan',
              svgScr: 'image/price.svg',
              index: 2,
              press: () {
                print('called $selectedIndex');
                scan();
                setState(() {
                  selectedIndex = 2;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: BottomNavItem(
              title: 'Favorite',
              svgScr: 'image/love-and-romance.svg',
              index: 3,
              press: () async {
                // Navigate to favorite products
                await updateUserSavedProductsToFirebase(
                    UserSavedProductsDataHelper.getCurrentUser().toString(),
                    context);
                await SavedProductsScreenController.updateDataFromFirebase(
                    UserSavedProductsDataHelper.getCurrentUser().toString(),
                    context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SavedProductsScreen()));

                setState(() {
                  selectedIndex = 3;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: BottomNavItem(
              title: 'Random',
              svgScr: 'image/dice.svg',
              index: 4,
              press: () {
                widget.callback();
                selectedIndex = 4;
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String title;
  final String svgScr;
  final Function press;
  final int index;
  BottomNavItem(
      {@required this.title,
      @required this.svgScr,
      @required this.press,
      @required this.index});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          SvgPicture.asset(
            svgScr,
            color: index == selectedIndex ? Color(0xFFF1CB57) : Colors.black87,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 12.0,
                color: index == selectedIndex
                    ? Color(0xFFF1CB57)
                    : Colors.black87),
          ),
        ],
      ),
    );
  }
}
