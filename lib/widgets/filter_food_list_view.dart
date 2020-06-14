import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

import '../models/product.dart';
import '../providers/products.dart';

class FilterFoodListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Product> _currentList =
        Provider.of<Products>(context).selectedProducts;
    return Expanded(
      child: GridView.count(
        physics: ScrollPhysics(),
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
                        Navigator.pushNamed(context, 'FoodInfoScreen',
                            arguments: _currentList.elementAt(index));
                      },
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
                                ),
                              )
                            : Container(
                                height: 90.0,
                                color: Colors.white,
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
                      IconButton(
                        constraints: BoxConstraints(
                          maxHeight: 40.0,
                          maxWidth: 40.0,
                        ),
                        icon: Icon(
                          Icons.save,
                          size: 20.0,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
