import 'package:flutter/material.dart';
import 'user_health_data.dart';
import 'package:provider/provider.dart';

class DietPlanData {
  UserHealthData _userData;
  // Constructor that passes Buildcontext of the Widget.
  DietPlanData(BuildContext context) {
    _userData = Provider.of<UserHealthData>(context);
  }
}