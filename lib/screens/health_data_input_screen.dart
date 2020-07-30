import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_health_data.dart';
import '../widgets/checkbox_list_widget.dart';

class HealthDataInputScreen extends StatelessWidget {
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
  ) async {
    userHealthData.setHealthData(
      _userHeight,
      _userWeight,
      _userAge,
    );

    _clickSubmit(context);
  }

  void _handleMissingInput(BuildContext context) {
    showDialog(
      context: context,
      builder: (bCtx) => AlertDialog(
        title: Row(
          children: <Widget>[
            Icon(
              Icons.warning,
              color: Colors.orange,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              'Missing Data Input',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Please fulfill all fields of your health data!',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(bCtx).pop(),
            child: Text(
              'OK',
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      barrierDismissible: true,
    );
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
            letterSpacing: 2.0,
            fontFamily: 'Pacifico',
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 0.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.notification_important,
                  color: Colors.red,
                ),
                Expanded(
                  child: Text(
                    'This is your first login, please input your health data!',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
          Card(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (heightValue) =>
                  this._userHeight = double.parse(heightValue),
              decoration: InputDecoration(
                  hintText: 'Your height here!',
                  labelText: 'Please input your height (cm):'),
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
                  labelText: 'Please input your weight (kg):'),
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
                  labelText: 'Please input your age (years):'),
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
            child: RaisedButton.icon(
              onPressed: () {
                if (_userHeight <= 0 || _userWeight <= 0 || _userAge <= 0) {
                  _handleMissingInput(context);
                } else {
                  _handleFulfilledInput(
                    context,
                    userHealthData,
                  );
                }
              },
              icon: Icon(Icons.file_upload),
              label: Text('Save Data'),
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
