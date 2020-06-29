import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/product.dart';
import '../providers/products.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FoodListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Product> _currentList = Provider.of<Products>(context).products;
    Widget displayProductImage(int index) {
      if (_currentList.elementAt(index).photoURL != null)
        return Image.network(
          _currentList.elementAt(index).photoURL,
          height: 80,
          width: 80,
          fit: BoxFit.fill,
          alignment: Alignment.centerLeft,
        );
      else
        return Container(
          height: 90.0,
          color: Colors.white,
        );
    }

    void addToSelectingList(int index) {
      bool _isDuplicated = false;
      Provider.of<Products>(context).selectedProducts.forEach((element) {
        if (element.name == _currentList.elementAt(index).name)
          _isDuplicated = true;
      });
      if (!_isDuplicated)
        Provider.of<Products>(context)
            .addSelectedProducts(_currentList.elementAt(index));
    }

    void removeFromSelectingList(int index) {
      Provider.of<Products>(context)
          .removeSelectedProducts(_currentList.elementAt(index));
    }

    return GridView.count(
      padding: EdgeInsets.all(5),
      shrinkWrap: true,
      crossAxisCount: 1,
      childAspectRatio: 2.8,
      children: List.generate(_currentList.length, (index) {
        return Card(
          shadowColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          margin: EdgeInsets.all(15),
          child: Row(
            children: <Widget>[
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    child: GestureDetector(
                      onTap: () {
                        //NavigateToFoodInfoScreen()
                        Navigator.pushNamed(context, 'FoodInfoScreen',
                            arguments: _currentList.elementAt(index));
                      },
                      // slide image function here
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: displayProductImage(index),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(10),
                    width: 250,
                    child: AutoSizeText(
                      _currentList.elementAt(index).name,
                      style: TextStyle(fontSize: 15.0),
                      minFontSize: 10.0,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Card(
                          child: IconButton(
                            onPressed: () {
                              addToSelectingList(index);
                            },
                            icon: Icon(Icons.add),
                          ),
                        ),
                        Card(
                          child: IconButton(
                            onPressed: () {
                              removeFromSelectingList(index);
                            },
                            icon: Icon(Icons.remove),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
