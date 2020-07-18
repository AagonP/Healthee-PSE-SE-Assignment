import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/illness.dart';

class UserHealthData with ChangeNotifier {
  // User's Data include:

  double _userHeight = 0;
  double _userWeight = 0;
  int _userAge = 0;
  bool _userIsMale = true;
  String _userExerciseFre = 'Sedentary';
  double _userDailyCalory = 0;
  double _userLBCalory = 0;
  double _userUBCalory = 0;

  ///////////////////////
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // This is the function used to estimate Calories needed for a day,
  // using Harris Benedict equation.

  void _postUserHealthData() async {
    var firebaseUser = await _auth.currentUser();
    //Firestore.instance.collection("users").document(firebaseUser.uid).updateData(data);
    await Firestore.instance
        .collection('users')
        .document(firebaseUser.uid)
        .setData({
      'userHealthData': {
        'userHeight': _userHeight,
        'userWeight': _userWeight,
        'userAge': _userAge,
        'userIsMale': _userIsMale,
        'userExerciseFreq': _userExerciseFre,
      }
    }, merge: true);
  }

  Future<bool> getUserHealthData() async {
    var firebaseUser = await _auth.currentUser();
    var value = await Firestore.instance
        .collection('users')
        .document(firebaseUser.uid)
        .get();
    Map<String, dynamic> tempMap = value.data;
    if (tempMap['userHealthData'] != null) {
      _userHeight = tempMap['userHealthData']['userHeight'];
      _userWeight = tempMap['userHealthData']['userWeight'];
      _userAge = tempMap['userHealthData']['userAge'];
      _userIsMale = tempMap['userHealthData']['userIsMale'];
      _userExerciseFre = tempMap['userHealthData']['userExerciseFreq'];

      _estimateCalory();
      _userDailyCalory = double.parse(_userDailyCalory.toStringAsFixed(4));
      notifyListeners();

      return false;
    } else {
      return true;
    }
  }

  void _estimateCalory() {
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
    _userDailyCalory = double.parse(_userDailyCalory.toStringAsFixed(2));

    _userLBCalory = _userDailyCalory * 92.5 / 100;
    _userLBCalory = double.parse(_userLBCalory.toStringAsFixed(2));
    _userUBCalory = _userDailyCalory * 107.5 / 100;
    _userUBCalory = double.parse(_userUBCalory.toStringAsFixed(2));
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

  double get userUBCalory {
    return _userUBCalory;
  }

  double get userLBCalory {
    return _userLBCalory;
  }

  void updateHealthData(
    double userHeight,
    double userWeight,
    int userAge,
  ) {
    _userHeight = userHeight;
    _userWeight = userWeight;
    _userAge = userAge;

    _estimateCalory();
    notifyListeners();
    _postUserHealthData();
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
  // User's illnesses selection
   int _numberOfIllness = 10;
  int get numberOfIllness {
    return _numberOfIllness;
  }

  static List<Illness> _healthInput = [
    Illness(
      obesity: false,
      highBloodPressure: false,
      headache: false,
      stomache: false,
      celiac: false,
      digestion: false,
      glutenSensitivity: false,
      heartDisease: false,
      peripheralVascular: false,
      stroke: false,
    )
  ];
  List<Illness> get healthInput {
    return [..._healthInput];
  }

  List<String> _illnessTags = [
    'Obesity',
    'High Blood Pressure',
    'Headache',
    'Stomache',
    'Celiac',
    'Digestion',
    'Gluten Sensitivity',
    'Heart disease',
    'PeripheralVascular',
    'Stroke',
  ];
  List<String> get illnessTags {
    return [..._illnessTags];
  }

  void updateUserInput(String illness, bool value, int page) {
    page = 0;
    switch (illness) {
      case 'Obesity':
        {
          _healthInput[page].obesity = value;
        }
        break;
      case 'High Blood Pressure':
        {
          _healthInput[page].highBloodPressure = value;
        }
        break;
      case 'Headache':
        {
          _healthInput[page].headache = value;
        }
        break;
      case 'Stomache':
        {
          _healthInput[page].stomache = value;
        }
        break;
      case 'Celiac':
        {
          _healthInput[page].celiac = value;
        }
        break;
      case 'Digestion':
        {
          _healthInput[page].digestion = value;
        }
        break;
      case 'Gluten Sensitivity':
        {
          _healthInput[page].glutenSensitivity = value;
        }
        break;
      case 'Heart disease':
        {
          _healthInput[page].heartDisease = value;
        }
        break;
      case 'PeripheralVascular':
        {
          _healthInput[page].peripheralVascular = value;
        }
        break;
      case 'Stroke':
        {
          _healthInput[page].stroke = value;
        }
        break;
      default:
        {
          print('Error');
          break;
        }
    }
    notifyListeners();
  }
}

Illness setIllnessBasedOnAPI(
    bool vegetarian, bool glutenFree, bool dairyFree, bool lowFodmap) {
  Illness illness = Illness(
    obesity: (!lowFodmap) ? true : false,
    celiac: (dairyFree) ? true : false,
    digestion: (vegetarian) ? true : false,
    glutenSensitivity: (glutenFree) ? true : false,
    headache: (vegetarian) ? true : false,
    heartDisease: (lowFodmap && dairyFree) ? true : false,
    highBloodPressure: (!lowFodmap) ? true : false,
    peripheralVascular: (!lowFodmap) ? true : false,
    stomache: (vegetarian) ? true : false,
    stroke: (lowFodmap) ? true : false,
  );
  return illness;
}
