import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../providers/products.dart';

class FilterFoodListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Product> _currentList = Provider.of<Products>(context).selectedProducts;
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(_currentList.length, (index) {
          return Card(
            shadowColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.all(5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Opacity(
                      opacity:
                          (_currentList[index].isHealthy == true) ? 1 : 0.3,
                      child: Image.network(
                        _currentList.elementAt(index).photoURL,
                      ),
                    ),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          child: Text(
                            _currentList.elementAt(index).name,
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          child: Text(
                            _currentList.elementAt(index).type,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.save,
                        size: 20,
                      ),
                      onPressed: () {
                        //Save item here
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
