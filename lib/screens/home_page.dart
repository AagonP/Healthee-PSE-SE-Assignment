import 'package:flutter/material.dart';

import './filter_screen.dart';
import '../models/product.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {},
                    iconSize: 30,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 150),
                  ),
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
                                    decoration: InputDecoration(
                                        hintText: 'Type of illness'),
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: 'Type of illness'),
                                  ),
                                ),
                                Card(
                                  margin: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  child: TextField(
                                    decoration: InputDecoration(
                                        hintText: 'Type of illness'),
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
            ),
            Text(
              'Healthee',
              style: TextStyle(fontSize: 50),
            ),
            Text(
              'Nutrtion & Diet',
              style: TextStyle(fontSize: 30),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FilterScreen()),
                      );
                    },
                    icon: Icon(Icons.filter_list), //filter
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
                  onPressed: () {},
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
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                // Generate 100 widgets that display their index in the List.
                children: List.generate(products.length, (index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    margin: EdgeInsets.all(20),
                    child: Expanded(
                      child: Column(
                        children: <Widget>[
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            margin: EdgeInsets.fromLTRB(5, 5, 5, 10),
                            child: Image(
                              image: NetworkImage(
                                  products.elementAt(index).photoURL),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 2, horizontal: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              products.elementAt(index).name,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 0, horizontal: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              products.elementAt(index).type,
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
