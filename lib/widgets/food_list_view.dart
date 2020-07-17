import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pse_assignment/filter_by_illness/filter_by_illness_controllers/filter_screen_controller.dart';

import '../models/product.dart';
import '../providers/products.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../providers/data_helper.dart';
import '../providers/saved_products.dart';

class FoodListView extends StatelessWidget with FilterScreenController {
  @override
  Widget build(BuildContext context) {
    final List<Product> _filteringProducts =
        Provider.of<Products>(context).filteringProducts;
    final saveProductSnackbar = SnackBar(
      content: Text('You have saved a product!'),
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
                          caption: 'Save',
                          color: Colors.blue,
                          icon: Icons.save,
                          onTap: () async {
                            Scaffold.of(context).showSnackBar(saveProductSnackbar);
                            if (!_filteringProducts
                                .elementAt(index)
                                .isHealthy) {
                              //Alert dialog here
                              showAlertOnSavingBlurred(
                                  index, context, _filteringProducts);
                              return;
                            }
                            Provider.of<SavedProducts>(context)
                                .saveProduct(_list.elementAt(index));
                            updateUserSavedProductsToFirebase(
                                await UserSavedProductsDataHelper
                                    .getCurrentUser(),
                                context);
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
