import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'user_health_data.dart';
import '../../../providers/data_helper.dart';
import 'daily_data.dart';

class DietPlanData with ChangeNotifier{
  double _userCalory;
  List<DailyData> _dailyList = List(30);

  // Constructor that gets userHealthData from the Input Screen

  Future <void> setWholePlan(double userDailyCalory) async {
    _userCalory = userDailyCalory;
    for (int i = 0; i < 30; i++) {
      _dailyList[i] = DailyData(i);
      _dailyList[i].setDailyPlan(_userCalory);
    }

    notifyListeners();
  }

  List<DailyData> get dailyList {
    return [..._dailyList];
  }
}
