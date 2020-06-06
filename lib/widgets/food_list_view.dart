import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';


class FoodListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final currentList = productsData.products;
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(currentList.length, (index) {
          return Card(
            shadowColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(currentList.elementAt(index).photoURL),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    currentList.elementAt(index).name,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    currentList.elementAt(index).type,
                    style: TextStyle(
                      fontSize: 14,
                    ),
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
