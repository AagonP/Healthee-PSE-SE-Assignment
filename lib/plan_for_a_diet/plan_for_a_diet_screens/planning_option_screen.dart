import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:progress_dialog/progress_dialog.dart';

import '../plan_for_a_diet_providers/diet_plan_data.dart';

import '../plan_for_a_diet_providers/user_health_data.dart';

class PlanningOptionScreen extends StatelessWidget {
  void _clickFAP(BuildContext context, UserHealthData userHealthData,
      DietPlanData dietPlanData, ProgressDialog pr) async {
    //print('${userHealthData.userHeight}\n${userHealthData.userAge}');
    pr.show();
    try {
      var isFirstPlan = await dietPlanData.getDietPlan();
      if (isFirstPlan == true) {
        await dietPlanData.setWholePlan(userHealthData.userDailyCalory);
      }

      pr.hide().whenComplete(() => Navigator.of(context).pushNamed(
            '/diet-timetable-screen',
            arguments: {'dietPlanData': dietPlanData},
          ));
    } catch (e) {
      print(e);
    }
  }

  /*void _handleNotFirstLogin(BuildContext context) {
    showDialog(
      context: context,
      child: Center(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Card(
            elevation: 15.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Text(
                    'Your previous health data is:',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handleClickFAP(
    BuildContext context,
    UserHealthData userHealthData,
  ) async {
    await userHealthData.getUserHealthData();
    if (userHealthData.userAge != 0) {
      _handleNotFirstLogin(context);
    } else {}
  }*/

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final userHealthData = Provider.of<UserHealthData>(context);
    final dietPlanData = Provider.of<DietPlanData>(context);

    ProgressDialog pr = ProgressDialog(
      context,
      type: ProgressDialogType.Normal,
      isDismissible: true,
    );
    pr.style(
      message: 'Generating Plan...',
      elevation: 5.0,
      backgroundColor: Colors.white,
      messageTextStyle: TextStyle(
        fontFamily: 'Montserrat',
        fontWeight: FontWeight.bold,
      ),
    );

    // TODO: implement screen to ask user for planing option
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Plan For A Diet',
          style: TextStyle(
            fontSize: 30,
            letterSpacing: 2.0,
            fontFamily: 'Pacifico',
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            width: screenWidth,
            child: Image.network(
              'https://www.hindustantimes.com/rf/image_size_960x540/HT/p2/2018/07/05/Pictures/_a021f0b0-8046-11e8-8bd0-affd130bd192.jpg',
            ),
          ),
          SizedBox(
            height: screenHeight / 12,
          ),
          GestureDetector(
            onTap: () {
              _clickFAP(context, userHealthData, dietPlanData, pr);
            },
            /*() async {
              _handleClickFAP(context, userHealthData);
            },*/
            child: Container(
              height: screenHeight / 10,
              width: screenWidth / (3 / 2.5),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.grid_on),
                    Text(
                      'Follow Available Plan',
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: screenHeight / 28,
          ),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: screenHeight / 10,
              width: screenWidth / (3 / 2.5),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.mode_edit),
                    Text(
                      'Make Your Own Plan',
                      style: TextStyle(
                        fontSize: 20,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
