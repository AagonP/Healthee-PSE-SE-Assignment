import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/product.dart';
import '../providers/products.dart';
import '../providers/saved_products.dart';
import '../providers/data_helper.dart';

class FilterFoodListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<Map<String, dynamic>> mappingProductToJson() async {
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
      UserSavedProducts.postUserSavedProducts(
          await mappingProductToJson(), userID);
    }

    final List<Product> _currentList =
        Provider.of<Products>(context).selectedProducts;
    void _saveProduct(int index) {
      bool _isDuplicated = false;
      Provider.of<SavedProducts>(context).savedProducts.forEach((element) {
        if (element.name == _currentList.elementAt(index).name) {
          _isDuplicated = true;
        }
      });
      if (!_isDuplicated) {
        Provider.of<SavedProducts>(context)
            .saveProduct(_currentList.elementAt(index));
      }
    }

    void removeFromSelectingList(int index) {
      Provider.of<Products>(context)
          .removeSelectedProducts(_currentList.elementAt(index));
    }

    Future<void> _showAlertOnSavingBlurred(int index) async {
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
                  _saveProduct(index);
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

    return Expanded(
      child: GridView.count(
        physics: ScrollPhysics(),
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
              children: <Widget>[
                Container(
                  child: GestureDetector(
                    onTap: () {
                      //NavigateToFoodInfoScreen()
                      Navigator.pushNamed(context, 'FoodInfoScreen',
                          arguments: _currentList.elementAt(index));
                    },
                    // slide image function here
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: (_currentList.elementAt(index).photoURL != null)
                          ? Opacity(
                              opacity:
                                  (_currentList.elementAt(index).isHealthy ==
                                          true)
                                      ? 1.0
                                      : 0.5,
                              child: Image.network(
                                _currentList.elementAt(index).photoURL,
                                height: 80,
                                width: 150,
                                fit: BoxFit.fill,
                                alignment: Alignment.centerLeft,
                              ),
                            )
                          : Container(
                              height: 90.0,
                              color: Colors.white,
                            ),
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
                              if (!_currentList.elementAt(index).isHealthy) {
                                //Alert dialog here
                                _showAlertOnSavingBlurred(index);
                                return;
                              }
                              _saveProduct(index);
                              updateUserSavedProducts(await UserSavedProducts.getCurrentUser());
                            },
                            icon: Icon(Icons.save),
                            iconSize: 25,
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        margin: EdgeInsets.all(1),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          color: Colors.yellow[600],
                          child: IconButton(
                            onPressed: () {
                              removeFromSelectingList(index);
                            },
                            icon: Icon(Icons.remove),
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
      ),
    );
  }
}
