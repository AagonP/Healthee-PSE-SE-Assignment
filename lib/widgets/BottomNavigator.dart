import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomBar extends StatelessWidget {
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
              title: 'Home Page',
              svgScr: 'image/sydney-opera-house.svg',
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
              press: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: BottomNavItem(
              title: 'Scan',
              svgScr: 'image/price.svg',
              press: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: BottomNavItem(
              title: 'Favorite',
              svgScr: 'image/love-and-romance.svg',
              press: () {},
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: BottomNavItem(
              title: 'Random',
              svgScr: 'image/dice.svg',
              press: () {},
            ),
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
  }
}
