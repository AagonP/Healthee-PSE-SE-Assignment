import 'package:flutter/material.dart';
import '../plan_for_a_diet_providers/daily_data.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../providers/user_health_data.dart';
import '../plan_for_a_diet_providers/diet_plan_data.dart';
import 'package:provider/provider.dart';

class SearchedMealInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final meal = routeArgs['meal'];
    final index = routeArgs['index'];
    final mealType = routeArgs['mealType'];
    final DietPlanData dietPlanData = Provider.of<DietPlanData>(
      context,
      listen: false,
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(children: <Widget>[
                meal.imageUrl == null
                    ? Image.asset('image/wp-header-logo-21.png')
                    : Image.network(meal.imageUrl),
                Align(
                  alignment: Alignment(-1.15, -1.0),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 30.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ]),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 15.0,
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: AutoSizeText(
                    meal.title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    minFontSize: 15.0,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                height: 20.0,
                width: double.infinity,
                child: Divider(
                  color: Colors.teal.shade200,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Ingredients for ${meal.servingSize} servings',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GridView.count(
                childAspectRatio: 11,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 1,
                children: List.generate(meal.ingredients.length, (index) {
                  return Container(
                    height: 100.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                    child: Wrap(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        AutoSizeText(
                          meal.ingredients.elementAt(index).name,
                          style: TextStyle(fontSize: 18.0),
                          maxLines: 2,
                        ),
                        Text(
                          ':',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        AutoSizeText(
                          meal.ingredients
                              .elementAt(index)
                              .amount
                              .toStringAsFixed(2),
                          style: TextStyle(fontSize: 18.0),
                          maxLines: 2,
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        AutoSizeText(
                          meal.ingredients.elementAt(index).unit,
                          style: TextStyle(fontSize: 18.0),
                          maxLines: 2,
                        ),
                      ],
                    ),
                  );
                }),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                height: 20.0,
                width: double.infinity,
                child: Divider(
                  color: Colors.teal.shade200,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Nutrients per serving',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  _ContainerRefactor(
                    title: 'Calories: ',
                    amount: double.parse(meal.calory.toStringAsFixed(2)),
                    unit: ' (calories)',
                  ),
                  _ContainerRefactor(
                    title: 'Protein: ',
                    amount: double.parse(meal.protein.toStringAsFixed(2)),
                    unit: ' (g)',
                  ),
                  _ContainerRefactor(
                    title: 'Fat: ',
                    amount: double.parse(meal.fat.toStringAsFixed(2)),
                    unit: ' (g)',
                  ),
                  _ContainerRefactor(
                    title: 'Carbohydrate: ',
                    amount: double.parse(meal.carbohydrate.toStringAsFixed(2)),
                    unit: ' (g)',
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                height: 20.0,
                width: double.infinity,
                child: Divider(
                  color: Colors.teal.shade200,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Servings',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: _ServingDisplay(
                  meal,
                  dietPlanData,
                  index,
                  mealType,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ContainerRefactor extends StatelessWidget {
  final String title;
  final double amount;
  final String unit;

  _ContainerRefactor(
      {@required this.title, @required this.amount, @required this.unit});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Row(
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
              title + amount.toString() + unit,
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}

class _ServingDisplay extends StatefulWidget {
  Meal _meal;
  int _tempServings;
  DietPlanData _dietPlanData;
  IconData _icon;
  Color _iconColor;
  String _textString;
  int _index;
  int _mealType;

  _ServingDisplay(
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
  _ServingDisplayState createState() => _ServingDisplayState();
}

class _ServingDisplayState extends State<_ServingDisplay> {
  void _handleFulfilledServings(
    BuildContext context,
    DietPlanData dietPlanData,
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
              if (widget._tempServings == 0) {
                _handleMissingServings(context);
              } else {
                widget._meal.setServings(widget._tempServings);
                _handleFulfilledServings(
                  context,
                  widget._dietPlanData,
                  widget._index,
                  widget._mealType,
                  widget._meal,
                );
              }
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
