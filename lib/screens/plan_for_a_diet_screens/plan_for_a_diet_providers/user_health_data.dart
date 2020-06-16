import 'package:flutter/material.dart';

class UserHealthData with ChangeNotifier {
  // Data:
  double _userHeight = 0;
  double _userWeight = 0;
  int _userAge = 0;
  String _userExerciseFre = 'Sedentary';

  double get userHeight {
    return _userHeight;
  }

  double get userWeight {
    return _userWeight;
  }

  int get userAge {
    return _userAge;
  }

  String get userExerciseFre {
    return _userExerciseFre;
  }

  void updateHealthData(
    double userHeight,
    double userWeight,
    int userAge,
  ) {
    _userHeight = userHeight;
    _userWeight = userWeight;
    _userAge = userAge;

    notifyListeners();
  }

  void updateExerciseData(
      String userExerciseFre,
      ) {
    _userExerciseFre = userExerciseFre;

    notifyListeners();
  }
}
