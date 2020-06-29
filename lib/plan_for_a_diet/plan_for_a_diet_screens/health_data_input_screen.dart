import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../plan_for_a_diet_providers/user_health_data.dart';
import '../plan_for_a_diet_providers/diet_plan_data.dart';
import '../plan_for_a_diet_widgets/checkbox_list_widget.dart';

class HealthDataInputScreen extends StatelessWidget {
  double _userHeight = 0;
  double _userWeight = 0;
  int _userAge = 0;

  void _clickSubmit(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(
      '/diet-timetable-screen',
    );
  }

  void _handleMissingInput(BuildContext context) {
    showDialog(
      context: context,
      child: Center(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Text(
                'Please enter your health data!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    final userHealthData = Provider.of<UserHealthData>(context);
    final _dietPlanData = Provider.of<DietPlanData>(context);

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
                if (_userHeight == 0 || _userWeight == 0 || _userAge == 0) {
                  _handleMissingInput(context);
                } else {
                  userHealthData.updateHealthData(
                    _userHeight,
                    _userWeight,
                    _userAge,
                  );

                  _dietPlanData.setWholePlan(userHealthData.userDailyCalory);
                  _clickSubmit(context);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
