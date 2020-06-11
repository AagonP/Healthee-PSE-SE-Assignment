import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

import '../models/product.dart';
import '../providers/products.dart';
import '../widgets/food_list_view.dart';
import '../providers/data_helper.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
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
            icon: Icon(Icons.account_circle),
            iconSize: 30,
          ),
        ],
      ),
      //Drawer here
      drawer: Drawer(),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Healthee',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 50,
                    fontFamily: 'Pacifico',
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Nutrtion & Diet',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Search product..',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                ),
                Card(
                  child: IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'FilterScreen');
                      print(Provider.of<UserInput>(context)
                          .healthInput[0]
                          .obesity);
                    },
                    icon: Badge(
                        badgeColor: Colors.white,
                        animationType: BadgeAnimationType.scale,
                        badgeContent: Text((Provider.of<Products>(context)
                                .selectedProducts
                                .length)
                            .toString()),
                        child: Icon(Icons.shopping_cart)), //filter
                  ),
                ),
                Card(
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.scanner),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    print(
                        Provider.of<UserInput>(context).healthInput[0].obesity);
                    //Testing add method with listeners
                    Product product1 = Product(
                      barCode: '1',
                      name: 'Hamburger',
                      description: 'Hamburger',
                      photoURL:
                          'https://www.foodiesfeed.com/wp-content/uploads/2016/08/tiny-pickles-on-top-of-burger-1-413x275.jpg',
                      qrCode: '1',
                      type: 'Food',
                      tags: ['Obesity', 'High Blood Pressure'],
                      illnesss: Illness(
                        obesity: true,
                        highBloodPressure: true,
                        headache: false,
                        stomache: false,
                        covid19: false,
                      ),
                    );
                    Provider.of<Products>(context).addProduct(product1);
                  },
                  icon: Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () {
                    //Testing remove method with listeners
                    Provider.of<Products>(context).removeProduct();
                  },
                  icon: Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            FoodListView(),
          ],
        ),
      ),
    );
  }
}
