import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../plan_for_a_diet_providers/diet_plan.dart';
import '../plan_for_a_diet_widgets/container_refactor.dart';
import '../plan_for_a_diet_widgets/serving_display.dart';
import 'package:provider/provider.dart';

class SearchedMealInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    final meal = routeArgs['meal'];
    final index = routeArgs['index'];
    final mealType = routeArgs['mealType'];
    final DietPlan dietPlanData = Provider.of<DietPlan>(
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
                  ContainerRefactor(
                    title: 'Calories: ',
                    amount: double.parse(meal.calory.toStringAsFixed(2)),
                    unit: ' (calories)',
                  ),
                  ContainerRefactor(
                    title: 'Protein: ',
                    amount: double.parse(meal.protein.toStringAsFixed(2)),
                    unit: ' (g)',
                  ),
                  ContainerRefactor(
                    title: 'Fat: ',
                    amount: double.parse(meal.fat.toStringAsFixed(2)),
                    unit: ' (g)',
                  ),
                  ContainerRefactor(
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
                child: ServingDisplay(
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