import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../plan_for_a_diet_providers/diet_plan_data.dart';
import '../../providers/user_health_data.dart';
import 'package:provider/provider.dart';
import '../plan_for_a_diet_widgets/daily_diet_item.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DietTimetableScreen extends StatefulWidget {
  @override
  _DietTimetableScreenState createState() => _DietTimetableScreenState();
}

class _DietTimetableScreenState extends State<DietTimetableScreen> {
  bool _isLoading = false;

  final _oneMonthList = [
    1,
    2,
    3,
    4,
    5,
    6,
    7,
    8,
    9,
    10,
    11,
    12,
    13,
    14,
    15,
    16,
    17,
    18,
    19,
    20,
    21,
    22,
    23,
    24,
    25,
    26,
    27,
    28,
    29,
    30
  ];

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    final dietPlanData = Provider.of<DietPlanData>(context);
    final userHealthData = Provider.of<UserHealthData>(context);

    // TODO: implement build of DietTimetableScreen
    return ModalProgressHUD(
      progressIndicator: SpinKitDualRing(
        color: Color(0xFFFCECC5),
        size: 40.0,
      ),
      inAsyncCall: _isLoading,
      child: Scaffold(
        backgroundColor: Color(0xFFD3D3D3).withOpacity(.84),
        body: Container(
          child: Column(
            children: <Widget>[
              SafeArea(
                child: Stack(children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    decoration: BoxDecoration(
                      color: Color(0xFFFCECC5),
                    ),
                    child: Container(
                      height: screenHeight / 2.8,
                      child: Image.asset(
                        'image/30_day_picture.jpg',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-1.15, -1.0),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 30.0,
                        color: Color(0xFF07084B),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xFFFCECC5),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AutoSizeText(
                      '30-day Diet Plan',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Pacifico',
                        letterSpacing: 2.0,
                        fontSize: 33.0,
                        color: Color(0xFF07084B),
                      ),
                      minFontSize: 25.0,
                      maxLines: 2,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 10.0),
                      child: Column(
                        children: <Widget>[
                          RawMaterialButton(
                            constraints: BoxConstraints.tightFor(
                              width: 40.0,
                              height: 40.0,
                            ),
                            onPressed: () async {
                              setState(() {
                                _isLoading = true;
                              });

                              await dietPlanData.resetPlan(userHealthData);

                              setState(() {
                                _isLoading = false;
                              });
                            },
                            elevation: 1.0,
                            fillColor: Colors.white,
                            child: Image.asset(
                              'image/reset.png',
                              fit: BoxFit.cover,
                              width: 40.0,
                              height: 40.0,
                            ),
                            shape: CircleBorder(
                              side: BorderSide(
                                color: Colors.white,
                                width: 2.0,
                              ),
                            ),
                          ),
                          Text(
                            'Reset',
                            style: TextStyle(fontSize: 14.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 10.0),
                  decoration: BoxDecoration(
                    color: Color(0xFFD3D3D3).withOpacity(.84),
                  ),
                  child: GridView(
                    shrinkWrap: true,
                    children: _oneMonthList
                        .map(
                          (index) => DailyDietItem(index, dietPlanData),
                        )
                        .toList(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // padding: EdgeInsets.all(5.0),
        ),
      ),
    );
  }
}
