// Mock user input for health's setting
import 'package:flutter/material.dart';

import '../models/product.dart';
import '../models/illness.dart';

class UserInput with ChangeNotifier {
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

  List<String> _illness = [
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
  List<String> get illness {
    return [..._illness];
  }

  void updateInput(String illness, bool value, int page) {
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
