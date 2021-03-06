import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../plan_for_a_diet_providers/diet_plan.dart';
import '../../providers/user_health_data.dart';

class PADClickHandler {
  void clickFAP(
    BuildContext context,
  ) async {
    final userHealthData = Provider.of<UserHealthData>(context, listen: false);
    final dietPlanData = Provider.of<DietPlan>(context, listen: false);

    ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: false,
    );
    pr.style(
      message: 'Generating plan...',
      borderRadius: 50.0,
      elevation: 5.0,
      progressWidget: SpinKitDualRing(
        color: Color(0xFFFCECC5),
        size: 40.0,
      ),
      backgroundColor: Colors.white,
      messageTextStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
      ),
    );

    if (dietPlanData.dailyList[29] != null) {
      Navigator.of(context).pushNamed(
        '/diet-timetable-screen',
      );
    } else {
      pr.show();
      try {
        var isFirstPlan = await dietPlanData.getDietPlan();
        if (isFirstPlan == true) {
          await dietPlanData.setWholePlan(userHealthData);
        }

        pr.hide().whenComplete(() => Navigator.of(context).pushNamed(
              '/diet-timetable-screen',
            ));
      } catch (e) {
        print(e);
      }
    }
  }
}
