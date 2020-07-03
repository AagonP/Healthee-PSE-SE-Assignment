import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'package:pse_assignment/filter_by_illness/filter_by_illness_screens/saved_products_screen.dart';

import '../../models/product.dart';
import '../../providers/data_helper.dart';
import '../../widgets/filtered_food_list_view.dart';
import '../../providers/products.dart';
import '../../providers/user_input.dart';
import '../../providers/saved_products.dart';
import '../filter_by_illness_screens/saved_products_screen.dart';

class FilterScreenController {
  Future<void> updateDataFromFirebase(
      String userID, BuildContext context) async {
    List<Product> savedProducts =
        await UserSavedProductsDataHelper.fetchUserSavedProducts(userID);
    int savedProductLength = savedProducts.length;
    for (int i = 0; i < savedProductLength; i++) {
      bool _isDuplicated = false;
      Provider.of<SavedProducts>(context).savedProducts.forEach((element) {
        if (element.name == savedProducts[i].name) {
          _isDuplicated = true;
        }
      });
      if (!_isDuplicated) {
        Provider.of<SavedProducts>(context).saveProduct(savedProducts[i]);
      }
    }
  }

  void doFilterList(bool isFilterOn, BuildContext context) {
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
        Provider.of<Products>(context).updateProductHealthValid(element, true);
        print('Filter deactivated');
      });
    }
  }

  String displayFilterStatus(bool isFilterOn, BuildContext context) {
    if (isFilterOn == true) return 'Setting has applied!';
    if (Provider.of<Products>(context).selectedProducts.length == 0)
      return 'Your cart is empty!';
    return 'Setting has not applied';
  }

  Future<void> showAlertOnEmptySelectingList(BuildContext context) async {
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

  Future<void> showAlertOnSavedList(BuildContext context) async {
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
}
