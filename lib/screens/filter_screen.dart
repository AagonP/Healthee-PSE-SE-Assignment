import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:multiselect_formfield/multiselect_formfield.dart';

import '../widgets/food_list_view.dart';
import '../providers/products.dart';
// import '../models/product.dart';

class FilterScreen extends StatelessWidget {
  bool isFilterOn  = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: Card(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search product..',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            // Filter  function call here
            IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                if (!isFilterOn) {
                  isFilterOn = true;
                  Provider.of<Products>(context).products.forEach((element) {
                    Provider.of<Products>(context)
                        .doFilter(Provider.of<UserInput>(context), element);
                    print('Filter activated');
                  });
                } else {
                  isFilterOn = false;
                  Provider.of<Products>(context).products.forEach((element) {
                    Provider.of<Products>(context)
                        .updateProductHealthValid(element, true);
                    print('Filter deactivated');
                  });
                }
              },
            ),
          ],
        ),
        Row(children: <Widget>[
          Expanded(
            child: Card(
              color: Colors.grey,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                    (isFilterOn == true)
                        ? 'Setting has applied!'
                        : 'Setting has not applied',
                    style: TextStyle(fontSize: 14)),
              ),
            ),
          ),
          //Input user setting
          IconButton(
            icon: Icon(Icons.add_box),
            iconSize: 40,
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextField(
                            decoration:
                                InputDecoration(hintText: 'Type of illness'),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextField(
                            decoration:
                                InputDecoration(hintText: 'Type of illness'),
                          ),
                        ),
                        Card(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextField(
                            decoration:
                                InputDecoration(hintText: 'Type of illness'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ]),
        FoodListView(),
      ]),
    );
  }
}
