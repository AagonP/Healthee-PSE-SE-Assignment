import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_health_data.dart';
import '../widgets/checkbox_list_widget.dart';

class HealthDataViewScreen extends StatelessWidget {
  double _userHeight = 0;

  double _userWeight = 0;

  int _userAge = 0;

  void _handleFulfilledInput(
    BuildContext context,
    UserHealthData userHealthData,
  ) async {
    userHealthData.updateHealthData(
      _userHeight,
      _userWeight,
      _userAge,
    );
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

  void _clickEditData(BuildContext context, UserHealthData userHealthData) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(15.0),
            topRight: const Radius.circular(15.0),
          ),
        ),
        context: context,
        builder: (bCtx) {
          return ListView(
            children: <Widget>[
              Text(
                'New Health Data',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 25,
                ),
              ),
              Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: TextField(
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  onChanged: (heightValue) =>
                      this._userHeight = double.parse(heightValue),
                  decoration: InputDecoration(
                      hintText: 'Your new height here!',
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
                      hintText: 'Your new weight here!',
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
                      hintText: 'Your new age here!',
                      labelText: 'Please input your age (years):'),
                ),
              ),
              UserExerciseCheckbox(),
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
                      Navigator.of(bCtx).pop();
                    }
                  },
                  icon: Icon(Icons.file_upload),
                  label: Text('Save Change'),
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
              ),
            ],
          );
        });
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
          Image.asset(
            'image/health_data_picture.jpg',
            fit: BoxFit.fitHeight,
          ),
          Card(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.account_box,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Expanded(
                        child: Text(
                          'Your current health data is:',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 30.0,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Expanded(
                        child: Text(
                          'Height: ${userHealthData.userHeight} (cm)',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 30.0,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Expanded(
                        child: Text(
                          'Weight: ${userHealthData.userWeight} (kg)',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 30.0,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Expanded(
                        child: Text(
                          'Age: ${userHealthData.userAge} (years)',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 30.0,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Expanded(
                        child: Text(
                          'Gender: ${userHealthData.userIsMale ? 'Male' : 'Female'}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 30.0,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Expanded(
                        child: Text(
                          'Daily exercise frequency: ${userHealthData.userExerciseFre}',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            elevation: 5,
          ),
          Card(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.assignment,
                        color: Colors.blue,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Expanded(
                        child: Text(
                          'On average, your body needs:',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 30.0,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Expanded(
                        child: Text(
                          '${userHealthData.userLBCalory} - ${userHealthData.userUBCalory} (calories/day)',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 30.0,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Expanded(
                        child: Text(
                          '${userHealthData.userLBProtein} - ${userHealthData.userUBProtein} (g protein/day)',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 30.0,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Expanded(
                        child: Text(
                          '${userHealthData.userLBFat} - ${userHealthData.userUBFat} (g fat/day)',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(2.0, 2.0, 2.0, 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 30.0,
                      ),
                      Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Expanded(
                        child: Text(
                          '${userHealthData.userLBCarbohydrate} - ${userHealthData.userUBCarbohydrate} (g carbohydrates/day)',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            elevation: 5,
          ),
          Center(
            child: RaisedButton.icon(
              onPressed: () {
                _clickEditData(
                  context,
                  userHealthData,
                );
              },
              icon: Icon(Icons.edit),
              label: Text('Edit Data'),
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
