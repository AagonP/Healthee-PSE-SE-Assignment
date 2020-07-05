import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:pse_assignment/filter_by_illness/filter_by_illness_controllers/filter_screen_controller.dart';
import 'package:pse_assignment/filter_by_illness/filter_by_illness_screens/saved_products_screen.dart';

import '../../providers/data_helper.dart';
import '../filter_by_illness_widgets/filtered_food_list_view.dart';
import '../../providers/products.dart';
import '../../providers/saved_products.dart';
import 'saved_products_screen.dart';

class FilterScreen extends StatelessWidget with FilterScreenController {
  static bool _isFilterOn = false;
  @override
  Widget build(BuildContext context) {
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
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'HomePage');
                },
                child: Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      hintText: 'Search product..',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              ),
            ),
            // Filter  function call here
            Card(
              elevation: 5,
              child: IconButton(
                icon: Icon(Icons.filter_list),
                onPressed: () {
                  //onPressedFilter
                  if (Provider.of<Products>(context).filteringProducts.length ==
                      0) {
                    showAlertOnEmptySelectingList(context);
                  }
                  doFilterList(_isFilterOn, context);
                  _isFilterOn = !_isFilterOn;
                },
              ),
            ),
          ],
        ),
        Row(children: <Widget>[
          Expanded(
            child: Card(
              elevation: 5,
              color: Colors.white,
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  getFilterStatus(_isFilterOn, context),
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ),
          Card(
            elevation: 5,
            child: IconButton(
              onPressed: () async {
                updateDataFromFirebase(
                    await UserSavedProductsDataHelper.getCurrentUser(),
                    context);
                //saved list page
                if (Provider.of<SavedProducts>(context).savedProducts.length ==
                    0) {
                  showAlertOnSavedList(context);
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SavedProductsScreen()));
                }
              },
              icon: Badge(
                  badgeColor: Colors.white,
                  animationType: BadgeAnimationType.scale,
                  badgeContent: Text(
                      (Provider.of<SavedProducts>(context).savedProducts.length)
                          .toString()),
                  child: Icon(Icons.account_box)), //filter
            ),
          ),
          //Input user setting
          IconButton(
            icon: Icon(Icons.add_box),
            iconSize: 40,
            onPressed: () {
              if (Provider.of<Products>(context).filteringProducts.length == 0) {
                showAlertOnEmptySelectingList(context);
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
