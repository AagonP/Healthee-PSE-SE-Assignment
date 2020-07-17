import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'screens/search_product_screen.dart';
import './screens/food_info.dart';
import './providers/products.dart';
import 'filter_by_illness/filter_by_illness_screens/filter_screen.dart';
import 'filter_by_illness/filter_by_illness_screens/filter_health_input_screen.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'providers/saved_products.dart';
import './screens/scan_screen.dart';
import './screens/welcome_screen.dart';
import 'screens/home_screen.dart';
import './screens/login/login_option_screen.dart';
import './screens/login/Register_screen.dart';
import './screens/login/Login_screen.dart';

// The following are all the files supporting for Plan For A Diet.
import 'screens/health_data_input_screen.dart';
import 'screens/health_data_view_screen.dart';
import './plan_for_a_diet/plan_for_a_diet_providers/diet_plan_data.dart';
import './plan_for_a_diet/plan_for_a_diet_screens/daily_detail_screen.dart';
import './plan_for_a_diet/plan_for_a_diet_screens/diet_timetable_screen.dart';
import './plan_for_a_diet/plan_for_a_diet_screens/search_food_for_plan_screen.dart';
import 'providers/user_health_data.dart';

void main() {
  runApp(MyApp());
  
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    FlutterStatusbarcolor.setStatusBarColor(Colors.white);
//    FlutterStatusbarcolor.setNavigationBarColor(Colors.black);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Products>(builder: (context) => Products()),
        ChangeNotifierProvider<SavedProducts>(
            builder: (context) => SavedProducts()),
        // The following UserHealthData is of the User to set Diet Plan
        // including: Height, Weight, Age, and Exercise Frequency.
        ChangeNotifierProvider<UserHealthData>(
          builder: (context) => UserHealthData(),
        ),
        ChangeNotifierProvider<DietPlanData>(
          builder: (context) => DietPlanData(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.white,
          fontFamily: 'Montserrat',
        ),
        home: WelcomePage(),
        //Setting route for pages here
        routes: {
          'LoginPage': (context) => LoginPage(),
          'RegisterPage': (context) => RegisterPage(),
          'LoginRegisterPage': (context) => LoginRegisterPage(),
          'NavigatePage': (context) => NavigatePage(),
          'WelcomePage': (context) => WelcomePage(),
          'HomePage': (context) => HomePage(),
          'FilterScreen': (context) => FilterScreen(),
          'FilterHealthInputScreen': (context) => Wrapper(),
          'FoodInfoScreen': (context) => FoodInfo(),

          // The following routes are for Plan For A Diet feature.
          '/health-data-input-screen': (context) => HealthDataInputScreen(),
          '/diet-timetable-screen': (context) => DietTimetableScreen(),
          '/daily-detail-screen': (context) => DailyDetailScreen(),
          '/search-food-for-plan-screen': (context) => SearchFoodForPlan(),
          '/health-data-view-screen': (context) => HealthDataViewScreen(),
          'ScanScreen': (context) => ScanScreen(),
          // 'HealthInput': (context) => InputText().
        },
      ),
    );
  }
}
