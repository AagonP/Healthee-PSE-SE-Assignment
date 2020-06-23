import 'daily_data.dart';

class DietPlanData {
  double _userCalory;
  List<DailyData> _dailyList = List(30);

  // Constructor that gets userHealthData from the Input Screen
  DietPlanData(double userDailyCalory) {
    _userCalory = userDailyCalory;
  }

  Future<void> setWholePlan() async {
    for (int i = 0; i < 30; i++) {
      _dailyList[i] = DailyData(i);
      _dailyList[i].setDailyPlan(_userCalory);
    }
    //print(_dailyList[0].threeMeals[0].title);
  }

  List<DailyData> get dailyList {
    return [..._dailyList];
  }
}
