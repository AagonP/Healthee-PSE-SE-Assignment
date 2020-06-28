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
        );
      else
        return Container(
          height: 90.0,
          color: Colors.white,
        );
    }

    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(_currentList.length, (index) {
        return Container(
          width: 50.0,
          child: Card(
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
                      //NavigateToFoodInfoScreen()
                      Navigator.pushNamed(context, 'FoodInfoScreen',
                          arguments: _currentList.elementAt(index));
                    },
                    // slide image function here
                    child: Slidable(
                      actionPane: SlidableDrawerActionPane(),
                      actionExtentRatio: 0.25,
                      secondaryActions: <Widget>[
                        IconSlideAction(
                          caption: 'Add',
                          color: Colors.green,
                          icon: Icons.add,
                          onTap: () {
                            bool _isDuplicated = false;
                            Provider.of<Products>(context)
                                .selectedProducts
                                .forEach((element) {
                              if (element.name ==
                                  _currentList.elementAt(index).name)
                                _isDuplicated = true;
                            });
                            if (!_isDuplicated)
                              Provider.of<Products>(context)
                                  .addSelectedProducts(
                                      _currentList.elementAt(index));
                          },
                        ),
                        IconSlideAction(
                          caption: 'Delete',
                          color: Colors.red,
                          icon: Icons.delete,
                          onTap: () {
                            Provider.of<Products>(context)
                                .removeProduct(_currentList.elementAt(index));
                          },
                        ),
                      ],
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: displayProductImage(index),
                      ),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                        child: AutoSizeText(
                          _currentList.elementAt(index).name,
                          style: TextStyle(fontSize: 15.0),
                          minFontSize: 10.0,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
