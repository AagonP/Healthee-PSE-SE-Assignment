import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/user_input.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (ctx) => UserInput(),
      child: ShowHealthInputForm(),
    );
  }
}

class ShowHealthInputForm extends StatefulWidget {
  @override
  _ShowHealthInputFormState createState() => _ShowHealthInputFormState();
}

class _ShowHealthInputFormState extends State<ShowHealthInputForm> {
  static List<bool> _isSelected = List<bool>.generate(10, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                      Provider.of<UserInput>(context).updateInput(
                          Provider.of<UserInput>(context).illness[index],
                          newValue,
                          0);
                      setState(() {
                        _isSelected[index] = newValue;
                      });

                      // print(Provider.of<UserInput>(context).healthInput[0].obesity);
                    },
                  );
                }),
          ),
          RaisedButton(
            child: Text('Compelete'),
            onPressed: () {
              Navigator.pop(context);
              print(Provider.of<UserInput>(context).healthInput[0].obesity);
            },
          ),
        ],
      ),
    );
  }
}
