import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/plan_for_a_diet_screens/planning_option_screen.dart';

import './screens/health_input_form.dart';
import './screens/filter_screen.dart';
import './screens/home_page.dart';
import './screens/food_info.dart';
import './providers/products.dart';

import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import './providers/user_input.dart';
import './providers/filtered_saved_list.dart';
//testing
import './providers/data_helper.dart';
import './screens/scan_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.black);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserInput>(builder: (context) => UserInput()),
        ChangeNotifierProvider<Products>(builder: (context) => Products()),
        ChangeNotifierProvider<FilterSavedList>(builder: (context)=> FilterSavedList()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          fontFamily: 'Montserrat',
        ),
        home: HomePage(),
        //Setting route for pages here
        routes: {
          'HomePage': (context) => HomePage(),
          'FilterScreen': (context) => FilterScreen(),
          'HealthInputScreen': (context) => Wrapper(),
          'FoodInfoScreen': (context) => FoodInfo(),
<<<<<<< Updated upstream
          '/planning-option-screen': (context) => PlanningOptionScreen(),
           'ScanScreen': (context) => ScanScreen(),
=======

          // The following routes are for Plan For A Diet feature.
          '/health-data-input-screen': (context) => HealthDataInputScreen(),
          '/diet-timetable-screen': (context) => DietTimetableScreen(),
          '/daily-detail-screen': (context) => DailyDetailScreen(),
          '/search-food-for-plan-screen': (context) => SearchFoodForPlan(),
          '/health-data-view-screen': (context) => HealthDataViewScreen(),
          '/meal-info-screen': (context) => MealInfoScreen(),
         // 'ScanScreen': (context) => ScanScreen(),
>>>>>>> Stashed changes
          // 'HealthInput': (context) => InputText().
        },
      ),
    );
  }
}
