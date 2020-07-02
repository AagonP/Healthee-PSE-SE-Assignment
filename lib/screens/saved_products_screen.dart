import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/saved_products.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../providers/data_helper.dart';

class SavedListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> mapping() async {
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

    Future<void> updateUserSavedProducts(String userID) async {
      UserSavedProducts.postUserSavedProducts(await mapping(), userID);
    }

    final List<Product> _currentList =
        Provider.of<SavedProducts>(context).savedProducts;
    void navigateToFoodInfoScreen(int idx) {
      Navigator.pushNamed(context, 'FoodInfoScreen',
          arguments: _currentList.elementAt(idx));
    }

    Widget displayProductImage(int index) {
      if (_currentList.elementAt(index).photoURL != null)
        return Image.network(
          _currentList.elementAt(index).photoURL,
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

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('My saved products'),
        ),
        body: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          children: List.generate(_currentList.length, (index) {
            return Card(
              shadowColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              margin: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(5),
                    child: GestureDetector(
                      onTap: () {
                        navigateToFoodInfoScreen(index);
                      },
                      // slide image function here
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: displayProductImage(index),
                      ),
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 20,
                    child: AutoSizeText(
                      _currentList.elementAt(index).name,
                      style: TextStyle(fontSize: 15.0),
                      minFontSize: 10.0,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          margin: EdgeInsets.all(1),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            color: Colors.yellow[600],
                            child: IconButton(
                              onPressed: () async {
                                Provider.of<SavedProducts>(context)
                                    .removeProduct(
                                        _currentList.elementAt(index));
                                UserSavedProducts.removeUserSavedProduct(
                                    await UserSavedProducts.getCurrentUser());
                                updateUserSavedProducts(
                                    await UserSavedProducts.getCurrentUser());
                              },
                              icon: Icon(Icons.delete),
                              iconSize: 25,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ));
  }
}
