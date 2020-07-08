import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/product.dart';

import '../../providers/saved_products.dart';
import '../../providers/data_helper.dart';
import '../filter_by_illness_screens/saved_products_screen.dart';

class SavedProductsScreenController {
  static void _onLoading(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
            backgroundColor: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100,
                  height: 100,
                  child: CircularProgressIndicator(),
                ),
              ],
            ));
      },
    );
  }

  static Future<void> updateDataFromFirebase(
      String userID, BuildContext context) async {
    _onLoading(context);
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
    Navigator.pop(context);
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

  void navigateToFoodInfoScreen(
      int idx, BuildContext context, List filteringProducts) {
    Navigator.pushNamed(context, 'FoodInfoScreen',
        arguments: filteringProducts.elementAt(idx));
  }

  Future<Map<String, dynamic>> mapProductToJson(BuildContext context) async {
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

  Widget getProductImage(int index, List savedProducts) {
    if (savedProducts.elementAt(index).photoURL != null)
      return Image.network(
        savedProducts.elementAt(index).photoURL,
        fit: BoxFit.fill,
        alignment: Alignment.centerLeft,
        height: 80,
        width: 150,
      );
    else
      return Container(
        height: 90.0,
        color: Colors.white,
      );
  }

  Future<void> updateUserSavedProducts(
      String userID, BuildContext context) async {
    UserSavedProductsDataHelper.postUserSavedProducts(
        await mapProductToJson(context), userID);
  }

  Future<void> removeUserSavedProduct(
      int index, BuildContext context, List savedProducts) async {
    Provider.of<SavedProducts>(context)
        .removeProduct(savedProducts.elementAt(index));
    UserSavedProductsDataHelper.removeUserSavedProduct(
        await UserSavedProductsDataHelper.getCurrentUser());
    updateUserSavedProducts(
        await UserSavedProductsDataHelper.getCurrentUser(), context);
  }
}
