import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:pse_assignment/filter_by_illness/filter_by_illness_controllers/filter_screen_controller.dart';

import '../../models/product.dart';
import '../../providers/products.dart';
import '../../providers/data_helper.dart';

class FilterFoodListView extends StatelessWidget with FilterScreenController {
  @override
  Widget build(BuildContext context) {
    final List<Product> _filteringProducts =
        Provider.of<Products>(context).filteringProducts;

    return Expanded(
      child: GridView.count(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 2,
        children: List.generate(_filteringProducts.length, (index) {
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
                          arguments: _filteringProducts.elementAt(index));
                    },
                    // slide image function here
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: (_filteringProducts.elementAt(index).photoURL !=
                              null)
                          ? Opacity(
                              opacity: (_filteringProducts
                                          .elementAt(index)
                                          .isHealthy ==
                                      true)
                                  ? 1.0
                                  : 0.5,
                              child: Image.network(
                                _filteringProducts.elementAt(index).photoURL,
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
                  height: 30,
                  child: AutoSizeText(
                    _filteringProducts.elementAt(index).name,
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
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          color: Colors.white,
                          child: IconButton(
                            onPressed: () async {
                              if (!_filteringProducts
                                  .elementAt(index)
                                  .isHealthy) {
                                //Alert dialog here
                                showAlertOnSavingBlurred(
                                    index, context, _filteringProducts);
                                return;
                              }
                              saveProduct(index, context, _filteringProducts);
                              updateUserSavedProductsToFirebase(
                                  await UserSavedProductsDataHelper
                                      .getCurrentUser(),
                                  context);
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
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                          color: Colors.white,
                          child: IconButton(
                            onPressed: () {
                              removeFromFilteringList(
                                  index, context, _filteringProducts);
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
