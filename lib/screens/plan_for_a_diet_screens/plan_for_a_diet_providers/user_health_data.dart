import 'package:flutter/material.dart';

class UserHealthData with ChangeNotifier {
  // User's Data include:

  double _userHeight = 0;
  double _userWeight = 0;
  int _userAge = 0;
  bool _userIsMale = true;
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

  bool get userIsMale {
    return _userIsMale;
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

  void updateGenderData(
      bool userIsMale,
      ) {
    _userIsMale = userIsMale;

    notifyListeners();
  }

  void updateExerciseData(
      String userExerciseFre,
      ) {
    _userExerciseFre = userExerciseFre;

    notifyListeners();
  }
}
