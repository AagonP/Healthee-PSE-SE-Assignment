import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../providers/user_health_data.dart';
import '../plan_for_a_diet/plan_for_a_diet_providers/diet_plan_data.dart';
import '../plan_for_a_diet/plan_for_a_diet_widgets/checkbox_list_widget.dart';

class HealthDataInputScreen extends StatefulWidget {
  @override
  _HealthDataInputScreenState createState() => _HealthDataInputScreenState();
}

class _HealthDataInputScreenState extends State<HealthDataInputScreen> {
  double _userHeight = 0;

  double _userWeight = 0;

  int _userAge = 0;

  void _clickSubmit(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(
      'NavigatePage',
    );
  }

  void _handleFulfilledInput(
      BuildContext context,
      UserHealthData userHealthData,
      DietPlanData dietPlanData,
      ProgressDialog pr) async {
    userHealthData.updateHealthData(
      _userHeight,
      _userWeight,
      _userAge,
    );

    _clickSubmit(context);
    /*pr.show();

    try {
      await dietPlanData.setWholePlan(userHealthData.userDailyCalory);
      pr.hide().whenComplete(() => _clickSubmit(context));
    } catch (e) {
      print(e);
    }*/
  }

  void _handleMissingInput(BuildContext context) {
    showDialog(
      context: context,
      child: Center(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Card(
            elevation: 15.0,
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
    final dietPlanData = Provider.of<DietPlanData>(context);

    ProgressDialog _pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: true,
    );
    _pr.style(
      message: 'Generating Plan...',
      elevation: 5.0,
      backgroundColor: Colors.white,
      messageTextStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
      ),
    );

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Health Data',
          style: TextStyle(
            fontSize: 30,
            letterSpacing: 2.0,
            fontFamily: 'Pacifico',
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(15.0),
            child:
                Text('This is your first login, please input your health data'),
          ),
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
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('FilterHealthInputScreen');
            },
            child: Container(
              child: Card(
                elevation: 5.0,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Text('Press here to select your illnesses!'),
                ),
              ),
            ),
          ),
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
                  _handleFulfilledInput(
                      context, userHealthData, dietPlanData, _pr);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
