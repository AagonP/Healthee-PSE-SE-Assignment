import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:pse_assignment/screens/saved_list_screen.dart';

import '../widgets/filter_food_list_view.dart';
import '../providers/products.dart';
import '../providers/user_input.dart';
import '../providers/filtered_saved_list.dart';
import '../screens/saved_list_screen.dart';

class FilterScreen extends StatelessWidget {
  bool isFilterOn = false;

  @override
  Widget build(BuildContext context) {
    void doFilterList() {
      if (!isFilterOn) {
        isFilterOn = true;
        Provider.of<Products>(context).selectedProducts.forEach((element) {
          Provider.of<Products>(context)
              .doFilter(Provider.of<UserInput>(context), element);
          print('Filter activated');
        });
      } else {
        isFilterOn = false;
        Provider.of<Products>(context).selectedProducts.forEach((element) {
          Provider.of<Products>(context)
              .updateProductHealthValid(element, true);
          print('Filter deactivated');
        });
      }
    }

    String displayFilterStatus() {
      if (isFilterOn == true) return 'Setting has applied!';
      return 'Setting has not applied';
    }

    Future<void> _showAlertOnEmptySelectingList() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Be alert!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Your holding list is currently empty.'),
                  Text('Please press the search bar and the select a product'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Got it'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    Future<void> _showAlertOnSavedList() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Oops!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('Look like your saved product list is empty.'),
                  Text('Please save a product in you cart.'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Got it'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'My cart',
        ),
      ),
      body: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: TextField(
                  onTap: () {
                    Navigator.pushNamed(context, 'HomePage');
                  },
                  decoration: InputDecoration(
                    hintText: 'Search product..',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            // Filter  function call here
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                if (Provider.of<Products>(context).selectedProducts.length ==
                    0) {
                  _showAlertOnEmptySelectingList();
                }
                doFilterList();
              },
            ),
          ],
        ),
        Row(children: <Widget>[
          Expanded(
            child: Card(
              color: Colors.grey,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  displayFilterStatus(),
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
          Card(
            child: IconButton(
              onPressed: () {
                //saved list page
                if (Provider.of<FilterSavedList>(context).currentList.length ==
                    0) {
                  _showAlertOnSavedList();
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SavedListScreen()));
                }
              },
              icon: Badge(
                  badgeColor: Colors.white,
                  animationType: BadgeAnimationType.scale,
                  badgeContent: Text(
                      (Provider.of<FilterSavedList>(context).currentList.length)
                          .toString()),
                  child: Icon(Icons.account_box)), //filter
            ),
          ),
          //Input user setting
          IconButton(
            icon: Icon(Icons.add_box),
            iconSize: 40,
            onPressed: () {
              if (Provider.of<Products>(context).selectedProducts.length == 0) {
                _showAlertOnEmptySelectingList();
              } else {
                Navigator.pushNamed(context, 'HealthInputScreen');
              }
            },
          ),
        ]),
        FilterFoodListView(),
      ]),
    );
  }
}
