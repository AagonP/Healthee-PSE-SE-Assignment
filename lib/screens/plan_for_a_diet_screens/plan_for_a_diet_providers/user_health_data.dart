import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserHealthData with ChangeNotifier {
  // User's Data include:

  double _userHeight = 0;
  double _userWeight = 0;
  int _userAge = 0;
  bool _userIsMale = true;
  String _userExerciseFre = 'Sedentary';
  double _userDailyCalory = 0;

  // This is the function used to estimate Calories needed for a day,
  // using Harris Benedict equation.
  void estimateCalory() {
    double temp;
    if (_userIsMale == true) {
      temp = 88.362 +
          (13.397 * _userWeight) +
          (4.799 * _userHeight) -
          (5.677 * _userAge);
    } else {
      temp = 447.593 +
          (9.247 * _userWeight) +
          (3.098 * _userHeight) -
          (4.330 * _userAge);
    }

    if (_userExerciseFre == 'Sedentary') {
      _userDailyCalory = temp * 1.2;
    } else if (_userExerciseFre == 'Mild activity') {
      _userDailyCalory = temp * 1.375;
    } else if (_userExerciseFre == 'Moderate activity') {
      _userDailyCalory = temp * 1.55;
    } else if (_userExerciseFre == 'Heavy activity') {
      _userDailyCalory = temp * 1.7;
    } else {
      _userDailyCalory = temp * 1.9;
    }
  }

  double get userHeight {
    return _userHeight;
  }

  double get userWeight {
    return _userWeight;
  }

  int get userAge {
    return _userAge;
  }

  bool get userIsMale {
    return _userIsMale;
  }

  String get userExerciseFre {
    return _userExerciseFre;
  }

  double get userDailyCalory {
    return _userDailyCalory;
  }

  void updateHealthData(
    double userHeight,
    double userWeight,
    int userAge,
  ) {
    _userHeight = userHeight;
    _userWeight = userWeight;
    _userAge = userAge;

    estimateCalory();
    _userDailyCalory = double.parse(_userDailyCalory.toStringAsFixed(4));
    notifyListeners();
  }

  void updateGenderData(
    bool userIsMale,
  ) {
    _userIsMale = userIsMale;

    estimateCalory();
    notifyListeners();
  }

  void updateExerciseData(
    String userExerciseFre,
  ) {
    _userExerciseFre = userExerciseFre;

    estimateCalory();
    notifyListeners();
  }
}
