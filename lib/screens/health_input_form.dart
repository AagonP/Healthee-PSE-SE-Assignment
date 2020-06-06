import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (ctx) => UserInput(),
      child: ShowHealthInputForm(),
    );
  }
}

class ShowHealthInputForm extends StatelessWidget {
  int _counter = 0;
  List<bool> _isSelected = List<bool>.generate(5, (index) => false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(5)),
          Expanded(
            child: ListView.builder(
                itemCount: _isSelected.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(Provider.of<UserInput>(context).illness[index]),
                    value: _isSelected[index],
                    onChanged: (bool newValue) {
                      Provider.of<UserInput>(context).updateInput(index, newValue);
                      _isSelected[index] = newValue;
                    },
                  );
                }),
          ),
          RaisedButton(
            child: Text('Compelete'),
            onPressed: () {
              Navigator.pushNamed(context, 'HomePage');
            },
          ),
        ],
      ),
    );
  }
}
