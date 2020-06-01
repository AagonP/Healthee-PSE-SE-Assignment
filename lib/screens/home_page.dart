import 'package:flutter/material.dart';

import './filter_screen.dart';

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
                    onPressed: () {},
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
                children: List.generate(100, (index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    margin: EdgeInsets.all(20),
                    child: Text(
                      'Item $index',
                      style: Theme.of(context).textTheme.headline5,
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
