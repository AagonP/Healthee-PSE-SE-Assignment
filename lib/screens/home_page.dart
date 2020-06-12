import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';

import '../models/product.dart';
import '../providers/products.dart';
import '../widgets/food_list_view.dart';
import '../providers/data_helper.dart';

class HomePage extends StatelessWidget {
  var _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return Card(
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Card(
                            margin: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            child: TextField(
                              decoration:
                                  InputDecoration(hintText: 'Type of illness'),
                            ),
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
        child: ListView(
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
                  'Nutrition & Diet',
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    child: Container(
                      height: 45.0,
                      child: TextField(
                        onSubmitted: (context) {
                          print(context);
                        },
                        controller: _controller,
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () => _controller.clear(),
                            icon: Icon(
                              Icons.clear,
                              color: Colors.grey,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Search product..',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          prefixIcon: Icon(Icons.search),
                        ),
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
                    icon: Icon(Icons.camera_alt),
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
                RawMaterialButton(
                  constraints: BoxConstraints.tightFor(
                    width: 50.0,
                    height: 50.0,
                  ),
                  onPressed: () {},
                  elevation: 2.0,
                  fillColor: Color(0xFFFEE1C7),
                  child: Image.asset(
                    'image/food.png',
                    fit: BoxFit.cover,
                    width: 30.0,
                    height: 30.0,
                  ),
                  shape: CircleBorder(
                    side: BorderSide(color: Colors.white),
                  ),
                ),
                RawMaterialButton(
                  constraints: BoxConstraints.tightFor(
                    width: 50.0,
                    height: 50.0,
                  ),
                  onPressed: () {},
                  elevation: 2.0,
                  fillColor: Color(0xFFFDDFFA),
                  child: Image.asset(
                    'image/flour.png',
                    fit: BoxFit.cover,
                    width: 30.0,
                    height: 30.0,
                  ),
                  shape: CircleBorder(
                    side: BorderSide(color: Colors.white),
                  ),
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
