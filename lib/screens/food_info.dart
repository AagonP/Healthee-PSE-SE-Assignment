import 'package:flutter/material.dart';
import 'package:pse_assignment/models/product.dart';
import 'package:auto_size_text/auto_size_text.dart';

class FoodInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(children: <Widget>[
                Image(
                  image: (product.photoURL != null)
                      ? NetworkImage(product.photoURL)
                      : AssetImage('image/wp-header-logo-21.png'),
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
                    product.name,
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
                    'Ingredients',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              GridView.count(
                childAspectRatio: 11,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 1,
                children: List.generate(product.ingredients.length, (index) {
                  return Container(
                    height: 100.0,
                    margin:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                    child: Wrap(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(
                          Icons.star,
                          color: Color(0xFFEFED99),
                          size: 20.0,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        AutoSizeText(
                          product.ingredients.elementAt(index),
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
                          product.amount.elementAt(index),
                          style: TextStyle(fontSize: 18.0),
                          maxLines: 2,
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        AutoSizeText(
                          product.unit.elementAt(index),
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
                    'Characteristics',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  ContainerRefactor(
                    title: 'vegetarian: ',
                    value: product.vegetarian ? 'true' : 'false',
                  ),
                  ContainerRefactor(
                    title: 'glutenFree: ',
                    value: product.glutenFree ? 'true' : 'false',
                  ),
                  ContainerRefactor(
                    title: 'dairyFree: ',
                    value: product.dairyFree ? 'true' : 'false',
                  ),
                  ContainerRefactor(
                    title: 'cheap: ',
                    value: product.cheap ? 'true' : 'false',
                  ),
                  ContainerRefactor(
                    title: 'popular: ',
                    value: product.popular ? 'true' : 'false',
                  ),
                  ContainerRefactor(
                    title: 'lowFodMap: ',
                    value: product.lowFodmap ? 'true' : 'false',
                  ),
                  ContainerRefactor(
                    title: 'veryHealthy: ',
                    value: product.veryHealthy ? 'true' : 'false',
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
                    'Nutrition',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  ContainerRefactor(
                      title: 'Calories: ',
                      value: double.parse(product.calories.toStringAsFixed(2))
                          .toString()),
                  ContainerRefactor(
                    title: 'Protein: ',
                    value: double.parse(product.protein.toStringAsFixed(2))
                            .toString() +
                        ' (g)',
                  ),
                  ContainerRefactor(
                    title: 'Fat: ',
                    value: double.parse(product.fat.toStringAsFixed(2))
                            .toString() +
                        ' (g)',
                  ),
                  ContainerRefactor(
                    title: 'Carbohydrate: ',
                    value: double.parse(product.carbohydrate.toStringAsFixed(2))
                            .toString() +
                        ' (g)',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerRefactor extends StatelessWidget {
  final String title;
  final String value;

  ContainerRefactor({@required this.title, @required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.star,
            color: Color(0xFFEFED99),
            size: 20.0,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            title,
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
