import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/product.dart';
import '../providers/products.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FoodListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addProductToFilteringListSnackBar = SnackBar(
      content: Text('You have added a product to filtering list!'),
      duration: Duration(milliseconds: 500),
    );
    List<Product> _list = Provider.of<Products>(context).displayProducts;
    return GridView.count(
      //physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      children: List.generate(_list.length, (index) {
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
                      Navigator.pushNamed(context, 'FoodInfoScreen',
                          arguments: _list.elementAt(index));
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
                                .filteringProducts
                                .forEach((element) {
                              if (element.name == _list.elementAt(index).name)
                                _isDuplicated = true;
                            });
                            if (!_isDuplicated) {
                              Scaffold.of(context).showSnackBar(
                                  addProductToFilteringListSnackBar);
                              Provider.of<Products>(context)
                                  .addFilteringProduct(_list.elementAt(index));
                            }
                          },
                        ),
                      ],
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: (_list.elementAt(index).photoURL != null)
                            ? Image.network(
                                _list.elementAt(index).photoURL,
                              )
                            : Container(
                                height: 90.0,
                                color: Colors.white,
                              ),
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
                          _list.elementAt(index).name,
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
