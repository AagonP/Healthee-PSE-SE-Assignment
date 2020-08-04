import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pse_assignment/filter_by_illness/filter_by_illness_controllers/saved_products_screen_controller.dart';
import 'package:pse_assignment/providers/data_helper.dart';
import '../../models/product.dart';
import '../../providers/saved_products.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SavedProductsScreen extends StatefulWidget {
  @override
  _SavedProductsScreenState createState() => _SavedProductsScreenState();
}

class _SavedProductsScreenState extends State<SavedProductsScreen>
    with SavedProductsScreenController {
  bool _isLoadingDataFromFirebase = true;

  @override
  Widget build(BuildContext context) {
    final removeFromSavedProducts = SnackBar(
      content: Text('You have removed the product from saved list!'),
      duration: Duration(milliseconds: 500),
    );
    final List<Product> _savedProducts =
        Provider.of<SavedProducts>(context).savedProducts.toSet().toList();

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('My saved products'),
        ),
        body: GridView.count(
          childAspectRatio: 0.85,
          crossAxisCount: 2,
          children: List.generate(
            _savedProducts.length,
            (index) {
              // return Card(
              //   shadowColor: Colors.grey,
              //   shape: RoundedRectangleBorder(
              //     borderRadius: BorderRadius.circular(20.0),
              //   ),
              //   margin: EdgeInsets.all(15),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.stretch,
              //     children: <Widget>[
              //       Container(
              //         padding: EdgeInsets.all(5),
              //         child: GestureDetector(
              //           onTap: () {
              //             navigateToFoodInfoScreen(
              //                 index, context, _savedProducts);
              //           },
              //           // slide image function here
              //           child: ClipRRect(
              //             borderRadius: BorderRadius.circular(20.0),
              //             child: getProductImage(index, _savedProducts),
              //           ),
              //         ),
              //       ),
              //       Container(
              //         margin: EdgeInsets.symmetric(horizontal: 5),
              //         width: 150,
              //         height: 35,
              //         child: AutoSizeText(
              //           _savedProducts.elementAt(index).name,
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
              //               width: 50,
              //               height: 50,
              //               margin: EdgeInsets.all(1),
              //               child: Card(
              //                 elevation: 5,
              //                 shape: RoundedRectangleBorder(
              //                     borderRadius: BorderRadius.circular(10.0)),
              //                 color: Colors.white,
              //                 child: Builder(
              //                   builder: (context) => IconButton(
              //                     iconSize: 15,
              //                     onPressed: () {
              //                       Scaffold.of(context)
              //                           .showSnackBar(removeFromSavedProducts);
              //                       removeUserSavedProduct(
              //                           index, context, _savedProducts);
              //                     },
              //                     icon: Icon(Icons.delete),
              //                   ),
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
                              arguments: _savedProducts.elementAt(index));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: (_savedProducts.elementAt(index).photoURL !=
                                    null)
                                ? Image.network(
                                    _savedProducts.elementAt(index).photoURL,
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
                              padding: EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 5),
                              child: AutoSizeText(
                                _savedProducts.elementAt(index).name,
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
                            child: Builder(
                              builder: (context) => GestureDetector(
                                onTap: () async {
                                  //Function goes here,
                                  Scaffold.of(context)
                                      .showSnackBar(removeFromSavedProducts);
                                  removeUserSavedProduct(
                                      index, context, _savedProducts);
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                    color: Color(0xFF393939),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20.0),
                                      bottomRight: Radius.circular(20.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Del',
                                    style: TextStyle(color: Colors.white),
                                  ),
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
            },
          ),
        ));
  }
}
