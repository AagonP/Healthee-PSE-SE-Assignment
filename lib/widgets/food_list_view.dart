import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/products.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../filter_by_illness/filter_by_illness_controllers/filter_screen_controller.dart';
import '../providers/saved_products.dart';
import '../providers/data_helper.dart';
import '../providers/user_health_data.dart';

class FoodListView extends StatelessWidget with FilterScreenController {
  bool isRecommended(BuildContext context, Product product) {
    UserHealthData userHealthData = Provider.of<UserHealthData>(context);
    if (userHealthData.userAge == 0) return false;
    int mealType;
    int mealIndex = mealType == 0 ? 35 : mealType == 1 ? 35 : 30;
    int servingsIndex =
        (userHealthData.userUBCalory * mealIndex / 100) ~/ product.calories;
    if ((userHealthData.userLBCalory * mealIndex / 100) <=
        product.calories * (servingsIndex)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final addProductSnackBar = SnackBar(
      content: Text('You have added a recipe!'),
      duration: Duration(milliseconds: 1000),
    );
    List<Product> _list = Provider.of<Products>(context).displayProducts;
    return GridView.count(
      childAspectRatio: 0.85,
      crossAxisCount: 2,
      children: List.generate(_list.length, (index) {
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
                        arguments: _list.elementAt(index));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
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
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        child: Icon(
                          Icons.star,
                          //color: Color(0xFFFECC4C),
                          size: 20.0,
                          color: isRecommended(context, _list.elementAt(index))
                              ? Color(0xFFFECC4C)
                              : Colors.transparent,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () async {
                          //Function goes here,
                          Scaffold.of(context).showSnackBar(addProductSnackBar);
                          Provider.of<SavedProducts>(context)
                              .saveProduct(_list.elementAt(index));
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
                              bottomRight: Radius.circular(20.0),
                            ),
                          ),
                          child: Text(
                            'Save',
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
    );
  }
}
