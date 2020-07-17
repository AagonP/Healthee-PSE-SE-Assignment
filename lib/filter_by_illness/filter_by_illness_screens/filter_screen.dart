import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pse_assignment/filter_by_illness/filter_by_illness_controllers/filter_screen_controller.dart';
import 'package:pse_assignment/filter_by_illness/filter_by_illness_screens/saved_products_screen.dart';
import 'package:pse_assignment/providers/data_helper.dart';

import '../filter_by_illness_screens/search_screen.dart';
import '../filter_by_illness_widgets/filtered_food_list_view.dart';
import '../../providers/products.dart';
import 'saved_products_screen.dart';
import '../filter_by_illness_controllers/saved_products_screen_controller.dart';

class FilterScreen extends StatelessWidget with FilterScreenController {
  static bool _isFilterOn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Filter By Illness',
        ),
      ),
      body: Column(children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: IconButton(
                tooltip: 'Search products',
                icon: Icon(Icons.search),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchScreen()));
                },
              ),
            ),
            // Filter  function call here
            Card(
              elevation: 5,
              child: IconButton(
                tooltip: 'Set your illnesses',
                icon: Icon(Icons.mode_edit),
                onPressed: () {
                  Navigator.pushNamed(context, 'FilterHealthInputScreen');
                },
              ),
            ),
            Card(
              elevation: 5,
              child: IconButton(
                tooltip: 'Filter the list',
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

            Card(
              elevation: 5,
              child: IconButton(
                tooltip: 'Show your saved products',
                onPressed: () async {
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
                },
                icon: Icon(Icons.account_box),
              ),
            ),
            //Input user setting
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 410,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.symmetric(
                  vertical: BorderSide(color: Colors.grey[300]),
                ),
              ),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                borderOnForeground: true,
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Text(
                    getFilterStatus(_isFilterOn, context),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 15),
              child: Text(
                'My filtering list',
                style: TextStyle(fontSize: 20, fontFamily: 'Pacifico'),
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            border: Border.symmetric(
              vertical: BorderSide(color: Colors.black),
            ),
          ),
        ),
        FilterFoodListView(),
      ]),
    );
  }
}
