import 'package:flutter/material.dart';

class FilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(children: <Widget>[
        Row(children: <Widget>[
          Expanded(
            child: Card(
              color: Colors.grey,
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text('Setting applied!', style: TextStyle(fontSize: 14)),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.add_box),
            iconSize: 40,
            onPressed: () {},
          ),
        ]),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            // Generate 100 widgets that display their index in the List.
            children: List.generate(100, (index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin: EdgeInsets.symmetric(vertical:10,horizontal:20),
                child: Text(
                  'Item $index',
                  style: Theme.of(context).textTheme.headline5,
                ),
              );
            }),
          ),
        ),
      ]),
    );
  }
}
