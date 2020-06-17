import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './plan_for_a_diet_providers/user_health_data.dart';

import './plan_for_a_diet_widgets/checkbox_list_widget.dart';

class HealthDataInputScreen extends StatelessWidget {
  double _userHeight;
  double _userWeight;
  int _userAge;

  void _clickSubmit(BuildContext context) {
    Navigator.of(context).pushNamed('/planning-option-screen');
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    final userHealthData = Provider.of<UserHealthData>(context);

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Health Data',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (heightValue) =>
                  this._userHeight = double.parse(heightValue),
              decoration: InputDecoration(
                  hintText: 'Your height here!',
                  labelText: 'Please input your height:'),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (weightValue) =>
                  this._userWeight = double.parse(weightValue),
              decoration: InputDecoration(
                  hintText: 'Your weight here!',
                  labelText: 'Please input your weight:'),
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextField(
              keyboardType: TextInputType.numberWithOptions(),
              onChanged: (ageValue) {
                this._userAge = int.parse(ageValue);
              },
              decoration: InputDecoration(
                  hintText: 'Your age here!',
                  labelText: 'Please input your age:'),
            ),
          ),
          UserExerciseCheckbox(),
          Center(
            child: GestureDetector(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Submit',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: () {
                userHealthData.updateHealthData(
                  _userHeight,
                  _userWeight,
                  _userAge,
                );

                _clickSubmit(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
