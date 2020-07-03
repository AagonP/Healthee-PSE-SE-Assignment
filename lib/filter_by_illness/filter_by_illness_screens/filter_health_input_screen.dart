import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_input.dart';

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
  static int numbOfIllness = 10;
  static List<bool> _illnessSelections =
      List<bool>.generate(numbOfIllness, (index) => false);
  void updateIllnessSelection(bool newValue, int index) {
    Provider.of<UserInput>(context).updateUserInput(
        Provider.of<UserInput>(context).illnessTags[index], newValue, 0);
    setState(() {
      _illnessSelections[index] = newValue;
    });
  }

  void submitIllnessSelection() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set filter by illnesses'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(5)),
          Expanded(
            child: ListView.builder(
                itemCount: _illnessSelections.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    title: Text(Provider.of<UserInput>(context).illnessTags[index]),
                    value: _illnessSelections[index],
                    onChanged: (bool newValue) {
                      updateIllnessSelection(newValue, index);
                    },
                  );
                }),
          ),
          RaisedButton(
            child: Text('Compelete'),
            onPressed: () {
              submitIllnessSelection();
            },
          ),
        ],
      ),
    );
  }
}
