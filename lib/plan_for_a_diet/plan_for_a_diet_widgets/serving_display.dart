import 'package:flutter/material.dart';
import '../plan_for_a_diet_providers/daily_plan.dart';
import '../plan_for_a_diet_providers/diet_plan.dart';

class ServingDisplay extends StatefulWidget {
  Meal _meal;
  int _tempServings;
  DietPlan _dietPlanData;
  IconData _icon;
  Color _iconColor;
  String _textString;
  int _index;
  int _mealType;

  ServingDisplay(
      this._meal,
      this._dietPlanData,
      this._index,
      this._mealType,
      ) {
    _tempServings = _meal.servings;
    if (_meal.servings == 0) {
      _icon = Icons.highlight_off;
      _iconColor = Colors.grey;
      _textString = 'Not recommended';
    } else {
      _icon = Icons.highlight;
      _iconColor = Colors.green;
      _textString = 'Recommended for ${_meal.servings} servings';
    }
  }

  @override
  ServingDisplayState createState() => ServingDisplayState();
}

class ServingDisplayState extends State<ServingDisplay> {
  void _handleFulfilledServings(
      BuildContext context,
      DietPlan dietPlanData,
      int index,
      int mealType,
      Meal meal,
      ) {
    dietPlanData.setDailyMeal(index, mealType, meal);
    Navigator.popUntil(context, ModalRoute.withName('/daily-detail-screen'));
  }

  void _handleMissingServings(BuildContext context) {
    showDialog(
      context: context,
      builder: (bCtx) => AlertDialog(
        title: Row(
          children: <Widget>[
            Icon(
              Icons.warning,
              color: Colors.orange,
            ),
            SizedBox(
              width: 10.0,
            ),
            Text(
              'Missing Servings',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Please identify your number of servings!',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(bCtx).pop(),
            child: Text(
              'OK',
              style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
      barrierDismissible: true,
    );
  }

  void _clickSaveMeal() {
    if (widget._tempServings == 0) {
      _handleMissingServings(context);
    } else {
      widget._meal.setServingsOnly(widget._tempServings);
      _handleFulfilledServings(
        context,
        widget._dietPlanData,
        widget._index,
        widget._mealType,
        widget._meal,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              widget._icon,
              color: widget._iconColor,
              size: 20.0,
            ),
            SizedBox(
              width: 5.0,
            ),
            Expanded(
              child: Text(
                widget._textString,
                style: TextStyle(
                  fontSize: 18.0,
                  color: widget._iconColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Icon(
              Icons.star,
              color: Colors.yellow,
              size: 20.0,
            ),
            SizedBox(
              width: 5.0,
            ),
            Expanded(
              child: Text(
                'Your number of servings: ',
                style: TextStyle(fontSize: 18.0),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 5.0, 8.0, 0.0),
              child: IconButton(
                alignment: Alignment.topCenter,
                icon: Icon(
                  Icons.arrow_downward,
                ),
                onPressed: () {
                  setState(() {
                    widget._tempServings > 0
                        ? widget._tempServings--
                        : widget._tempServings = widget._tempServings;
                  });
                },
                iconSize: 25.0,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              child: Text(
                '${widget._tempServings}',
                style: TextStyle(fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(8.0, 5.0, 0.0, 0.0),
              child: IconButton(
                alignment: Alignment.topCenter,
                icon: Icon(
                  Icons.arrow_upward,
                ),
                onPressed: () {
                  setState(() {
                    widget._tempServings++;
                  });
                },
                iconSize: 25.0,
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 60.0),
          height: 20.0,
          width: double.infinity,
          child: Divider(
            color: Colors.teal.shade200,
          ),
        ),
        Center(
          child: RaisedButton.icon(
            onPressed: () {
              _clickSaveMeal();
            },
            icon: Icon(
              Icons.file_upload,
              color: Colors.green,
            ),
            label: Text(
              'Save This Meal',
              style: TextStyle(
                color: Colors.green,
              ),
            ),
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
        ),
      ],
    );
  }
}
