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
        childAspectRatio: 0.85,
        crossAxisCount: 2,
        children: List.generate(_filteringProducts.length, (index) {
          // return Card(
          //   shadowColor: Colors.grey,
          //   shape: RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(20.0),
          //   ),
          //   margin: EdgeInsets.all(15),
          //   child: Column(
          //     children: <Widget>[
          //       Container(
          //         padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          //         child: GestureDetector(
          //           onTap: () {
          //             //NavigateToFoodInfoScreen()
          //             Navigator.pushNamed(context, 'FoodInfoScreen',
          //                 arguments: _filteringProducts.elementAt(index));
          //           },
          //           // slide image function here
          //           child: ClipRRect(
          //             borderRadius: BorderRadius.circular(20.0),
          //             child: (_filteringProducts.elementAt(index).photoURL !=
          //                     null)
          //                 ? Opacity(
          //                     opacity: (_filteringProducts
          //                                 .elementAt(index)
          //                                 .isHealthy ==
          //                             true)
          //                         ? 1.0
          //                         : 0.5,
          //                     child: Image.network(
          //                       _filteringProducts.elementAt(index).photoURL,
          //                       height: 80,
          //                       width: 150,
          //                       fit: BoxFit.fill,
          //                       alignment: Alignment.centerLeft,
          //                     ),
          //                   )
          //                 : Container(
          //                     height: 90.0,
          //                     color: Colors.white,
          //                   ),
          //           ),
          //         ),
          //       ),
          //       Container(
          //         width: 150,
          //         height: 30,
          //         child: AutoSizeText(
          //           _filteringProducts.elementAt(index).name,
          //           style: TextStyle(fontSize: 15.0),
          //           minFontSize: 10.0,
          //           maxLines: 2,
          //           overflow: TextOverflow.ellipsis,
          //         ),
          //       ),
          //       Expanded(
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           children: <Widget>[
          //             Container(
          //               alignment: Alignment.center,
          //               width: 50,
          //               height: 50,
          //               margin: EdgeInsets.all(1),
          //               child: Card(
          //                 elevation: 5,
          //                 shape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(10.0)),
          //                 color: Colors.white,
          //                 child: IconButton(
          //                   onPressed: () async {
          //                     if (!_filteringProducts
          //                         .elementAt(index)
          //                         .isHealthy) {
          //                       //Alert dialog here
          //                       showAlertOnSavingBlurred(
          //                           index, context, _filteringProducts);
          //                       return;
          //                     }
          //                     saveProduct(index, context, _filteringProducts);
          //                     updateUserSavedProductsToFirebase(
          //                         await UserSavedProductsDataHelper
          //                             .getCurrentUser(),
          //                         context);
          //                   },
          //                   icon: Icon(Icons.save),
          //                   iconSize: 15,
          //                 ),
          //               ),
          //             ),
          //             Container(
          //               width: 50,
          //               height: 50,
          //               margin: EdgeInsets.all(1),
          //               child: Card(
          //                 elevation: 5,
          //                 shape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.circular(10.0)),
          //                 color: Colors.white,
          //                 child: IconButton(
          //                   onPressed: () {
          //                     removeFromFilteringList(
          //                         index, context, _filteringProducts);
          //                   },
          //                   icon: Icon(Icons.remove),
          //                   iconSize: 15,
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // );
          return Container(
            margin: EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 33,
                    color: Color(0xFFD3D3D3).withOpacity(.84),
                  ),
                ],
              ),
              margin: EdgeInsets.all(5),
              child: Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, 'FoodInfoScreen',
                          arguments: _filteringProducts.elementAt(index));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
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
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                          child: AutoSizeText(
                            _filteringProducts.elementAt(index).name,
                            style: TextStyle(fontSize: 15.0),
                            minFontSize: 10.0,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(child: Container()),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            //Function goes here,
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
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Color(0xFF393939),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                              ),
                            ),
                            child: Text(
                              'Save',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            //Function goes here,
                            removeFromFilteringList(
                                index, context, _filteringProducts);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              color: Color(0xFF393939),
                              borderRadius: BorderRadius.only( bottomRight: Radius.circular(20.0),),
                            ),
                            child: Text(
                              'Del',
                              style: TextStyle(color: Colors.white),
                            ),
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
