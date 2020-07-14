import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_health_data.dart';

class UserExerciseCheckbox extends StatefulWidget {

  @override
  _UserExerciseCheckboxState createState() => _UserExerciseCheckboxState();
}


class _UserExerciseCheckboxState extends State<UserExerciseCheckbox> {

  String _userExercise = 'Sedentary';
  String _userGender = 'Male';
  bool _userIsMale = true;

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    final userHealthData = Provider.of<UserHealthData>(context);

    return Column(
      children: <Widget>[
        Container(
          width: screenWidth,
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Please choose your gender:',
                  style: TextStyle(color: Colors.black54),
                ),
                DropdownButton<String>(
                  value: _userGender,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 15,
                  elevation: 10,
                  underline: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  onChanged: (String chosenOption) {
                    setState(() {
                      _userGender = chosenOption;
                      _userIsMale = _userGender == 'Male' ? true : false;
                      userHealthData.updateGenderData(_userIsMale);
                    });
                  },
                  items: <String>[
                    'Male',
                    'Female'
                  ].map<DropdownMenuItem<String>>((String option) {
                    return DropdownMenuItem<String>(
                        value: option, child: Text(option));
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
        // The above asks for User's gender, the below asks for Exercise Frequency.
        Container(
          width: screenWidth,
          child: Card(
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Please choose your exercise frequency:',
                  style: TextStyle(color: Colors.black54),
                ),
                DropdownButton<String>(
                  value: _userExercise,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 15,
                  elevation: 10,
                  underline: Container(
                    height: 2,
                    color: Colors.black,
                  ),
                  onChanged: (String chosenOption) {
                    setState(() {
                      _userExercise = chosenOption;
                      userHealthData.updateExerciseData(_userExercise);
                    });
                  },
                  items: <String>[
                    'Sedentary',
                    'Mild activity',
                    'Moderate activity',
                    'Heavy activity',
                    'Extremely heavy activity'
                  ].map<DropdownMenuItem<String>>((String option) {
                    return DropdownMenuItem<String>(
                        value: option, child: Text(option));
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
