import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/saved_products.dart';
import '../../providers/data_helper.dart';

class SavedProductsScreenController {
  void navigateToFoodInfoScreen(
      int idx, BuildContext context, List filteringProducts) {
    Navigator.pushNamed(context, 'FoodInfoScreen',
        arguments: filteringProducts.elementAt(idx));
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

  Future<void> removeUserSavedProduct(int index,BuildContext context, List savedProducts) async {
    Provider.of<SavedProducts>(context)
        .removeProduct(savedProducts.elementAt(index));
    UserSavedProductsDataHelper.removeUserSavedProduct(
        await UserSavedProductsDataHelper.getCurrentUser());
    updateUserSavedProducts(
        await UserSavedProductsDataHelper.getCurrentUser(), context);
  }
}
