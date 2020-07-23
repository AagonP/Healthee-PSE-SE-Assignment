import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pse_assignment/providers/data_helper.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../screens/scan.dart';
int selectedIndex = -1;

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  FoodData foodData = FoodData();

  void displayRandom() async {
    Provider.of<Products>(context).clearProduct();
    await foodData.getRandomProduct(context);
  }
  Future <void> scan() async {
    await Scan.scanner();
    print(Scan.key);

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
              press: () {
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
                setState(() {
                  selectedIndex = 4;
                });
                displayRandom();
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
