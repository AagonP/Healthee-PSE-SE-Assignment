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

    return Scaffold(
      appBar: AppBar(
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
                    Navigator.pop(context);
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SavedListScreen()));
              },
              icon: Badge(
                  badgeColor: Colors.white,
                  animationType: BadgeAnimationType.scale,
                  badgeContent: Text(
                      (Provider.of<FilterSavedList>(context).currentList.length)
                          .toString()),
                  child: Icon(Icons.edit)), //filter
            ),
          ),
          //Input user setting
          IconButton(
            icon: Icon(Icons.add_box),
            iconSize: 40,
            onPressed: () {
              Navigator.pushNamed(context, 'HealthInputScreen');
            },
          ),
        ]),
        FilterFoodListView(),
      ]),
    );
  }
}
