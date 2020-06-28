import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/product.dart';
import '../providers/products.dart';
import '../providers/filtered_saved_list.dart';

class FilterFoodListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<Product> _currentList =
        Provider.of<Products>(context).selectedProducts;
    void _saveProduct(int index) {
      bool _isDuplicated = false;
      Provider.of<FilterSavedList>(context).currentList.forEach((element) {
        if (element.name == _currentList.elementAt(index).name) {
          _isDuplicated = true;
        }
      });
      if (!_isDuplicated) {
        Provider.of<FilterSavedList>(context)
            .saveProduct(_currentList.elementAt(index));
      }
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
                      child: Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: 'Save',
                            color: Colors.green,
                            icon: Icons.save,
                            onTap: () {
                              if (!_currentList.elementAt(index).isHealthy) {
                                //Alert dialog here
                                _showAlertOnSavingBlurred(index);
                                return;
                              }
                              _saveProduct(index);
                            },
                          ),
                          IconSlideAction(
                            caption: 'Delete',
                            color: Colors.red,
                            icon: Icons.undo,
                            onTap: () {
                              Provider.of<FilterSavedList>(context)
                                  .removeProduct(_currentList.elementAt(index));
                            },
                          ),
                        ],
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child:
                              (_currentList.elementAt(index).photoURL != null)
                                  ? Opacity(
                                      opacity: (_currentList
                                                  .elementAt(index)
                                                  .isHealthy ==
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
      ),
    );
  }
}
