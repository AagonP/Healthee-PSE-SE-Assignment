import 'package:flutter/material.dart';
import '../plan_for_a_diet_providers/daily_data.dart';
import 'package:auto_size_text/auto_size_text.dart';

class MealInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Meal meal = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(children: <Widget>[
                Image.network(meal.imageUrl),
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
                        'Number of servings: ${meal.servings}',
                        style: TextStyle(fontSize: 18.0),
                      ),
                    ),
                  ],
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