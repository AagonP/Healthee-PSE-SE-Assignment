import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../../models/product.dart';
import '../../providers/data_helper.dart';
import '../../providers/products.dart';
import '../../providers/user_input.dart';
import '../../providers/saved_products.dart';


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
      Provider.of<Products>(context).filteringProducts.forEach(
        (element) {
          Provider.of<Products>(context)
              .doFilter(Provider.of<UserInput>(context), element);
        },
      );
      return;
    }
    isFilterOn = false;
    Provider.of<Products>(context).filteringProducts.forEach(
      (element) {
        Provider.of<Products>(context).updateProductHealthValidation(element, true);
      },
    );
  }

  String getFilterStatus(bool isFilterOn, BuildContext context) {
    if (isFilterOn == true) return 'Setting has applied!';
    if (Provider.of<Products>(context).filteringProducts.length == 0)
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

  Future<Map<String, dynamic>> mapProductToJson(
      BuildContext context) async {
    int _savedProductsLength =
        Provider.of<SavedProducts>(context).savedProducts.length;
    if (_savedProductsLength == 0) return null;
    List<Map<String, dynamic>> jsonProducts = new List(_savedProductsLength);
    for (int i = 0; i < _savedProductsLength; i++) {
      jsonProducts[i] = await Provider.of<SavedProducts>(context)
          .savedProducts
          .elementAt(i)
          .toJson();
    }
    Map<String, dynamic> temp = {
      'Products': jsonProducts,
    };
    return temp;
  }

  Future<void> updateUserSavedProductsToFirebase(
      String userID, BuildContext context) async {
    UserSavedProductsDataHelper.postUserSavedProducts(
        await mapProductToJson(context), userID);
  }

  void saveProduct(int index, BuildContext context, List filteringProducts) {
    bool _isDuplicated = false;
    Provider.of<SavedProducts>(context).savedProducts.forEach((element) {
      if (element.name == filteringProducts.elementAt(index).name) {
        _isDuplicated = true;
      }
    });
    if (!_isDuplicated) {
      Provider.of<SavedProducts>(context)
          .saveProduct(filteringProducts.elementAt(index));
    }
  }

  void removeFromFilteringList(
      int index, BuildContext context, List filteringProducts) {
    Provider.of<Products>(context)
        .removeFilteringProduct(filteringProducts.elementAt(index));
  }

  Future<void> showAlertOnSavingBlurred(
      int index, BuildContext context, List filteringProducts) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Be alert!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'This product has been filtered out as unhealthy for you.'),
                Text('Are you sure still wanting to save this product?'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Proceed'),
              onPressed: () {
                Navigator.of(context).pop();
                saveProduct(index, context, filteringProducts);
              },
            ),
            FlatButton(
              child: Text('Cancel'),
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
