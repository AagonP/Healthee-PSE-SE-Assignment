import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:pse_assignment/plan_for_a_diet/plan_for_a_diet_widgets/meal_view_item.dart';
import 'package:provider/provider.dart';
import '../plan_for_a_diet_providers/meal_search_list.dart';
/*import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import '../models/product.dart';
import '../providers/products.dart';
import '../widgets/food_list_view.dart';
import '../providers/data_helper.dart';
import '../widgets/category.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pse_assignment/widgets/BottomNavigator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../widgets/delegate_search.dart';*/

class SearchFoodForPlanScreen extends StatefulWidget {
  @override
  _SearchFoodForPlanScreenState createState() =>
      _SearchFoodForPlanScreenState();
}

class _SearchFoodForPlanScreenState extends State<SearchFoodForPlanScreen> {
  String _chosenSearchTag;
  int _mealType;
  int _index;
  bool _isInit = true;
  bool _isLoading = false;
  MealSearchList _mealSearchList = MealSearchList();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final routeArgs =
      ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
      _index = routeArgs['index'];
      _mealType = routeArgs['mealType'];
      _chosenSearchTag =
      _mealType == 0 ? 'apple' : _mealType == 1 ? 'beef' : 'cucumber';
    }
    _mealSearchList = Provider.of<MealSearchList>(context);
    _isInit = false;

    super.didChangeDependencies();
  }

/* FirebaseUser user;
  String name = '';

  String res = "Sample code";

//Text input controller
  var _controller = TextEditingController();
  var input;
  FoodData foodData = FoodData();

  @override
  void initState() {
    firstLoad();
    super.initState();
  }

//  void getListFromFireBase() async {
//    suggestion.clear();
//    QuerySnapshot querySnapshot =
//        await Firestore.instance.collection('data').getDocuments();
//    for (int i = 0; i < querySnapshot.documents.length; i++) {
//      var a = querySnapshot.documents[i];
//      suggestion.add(a.documentID);
//      print(suggestion[i]);
//    }
//  }

  void firstLoad() async {
    await foodData.getRandomProduct(context);
  }

  void updateAfterScan(var key) {
    setState(() {
      res = key.toString();
    });
  }

  void doScanning() {
    // Navigator.pushNamed(context, "ScanScreen");
    updateAfterScan(Scan.scanner());
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(Scan.key.toString()),
          );
        });
  }

  //this function is for uploading data to firebase
//  void updateUI(String name) async {
//    var data = await foodData.getFoodData(name, 10, 10);
//    print(data);
//    foodData.uploadDataFromApiToFireBase(data, 10, name);
//  }

  void navigateToFilterScreen(BuildContext context) {
    //NavigateToFilterScreen()
    Navigator.pushNamed(context, 'FilterScreen');
  }

  void searchOnSubmitted(String name) {
    print(name);
    foodData.getRecipe(context, name);
  }*/

  @override
  Widget build(BuildContext context) {
    final List<String> tagList = _mealType == 0
        ? [
            'apple',
            'avocado',
            'banana',
            'bread',
            'cheese',
            'egg',
            'juice',
            'potato',
          ]
        : _mealType == 1
            ? [
                'beef',
                'chicken',
                'crab',
                'meat',
                'pasta',
                'pork',
                'shrimp',
                'steak',
              ]
            : [
                'cucumber',
                'fish',
                'mushroom',
                'salad',
                'salmon',
                'sauce',
                'soup',
                'spinach',
                'tomato',
                'tuna',
                'vegetable',
              ];

    return ModalProgressHUD(
      inAsyncCall: _isLoading,
      child: Scaffold(
        backgroundColor: Color(0xFFF6F7F8),
        body: Column(
          children: <Widget>[
            SafeArea(
              child: Stack(
                children: <Widget>[
                  Container(
                    //height: size.height * 0.35,
                    decoration: BoxDecoration(
                      color: Color(0xFFFCECC5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Day ${_index + 1}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF07084B),
                              fontSize: 33,
                              fontFamily: 'Pacifico',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Meals For ${_mealType == 0 ? 'Breakfast' : _mealType == 1 ? 'Lunch' : 'Dinner'}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF07084B),
                              fontSize: 33,
                              fontFamily: 'Pacifico',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 25,
                            ),
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(29.5),
                            ),
                            height: 50,
                            alignment: Alignment.centerRight,
                            width: double.infinity,
                            child: DropdownButton<String>(
                              value: _chosenSearchTag,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 25,
                              elevation: 15,
                              isExpanded: true,
                              onChanged: (String chosenOption) async {
                                setState(() {
                                  _chosenSearchTag = chosenOption;
                                  _isLoading = true;
                                });

                                await _mealSearchList
                                    .getMealsFromTag(_chosenSearchTag);
                                setState(() {
                                  _isLoading = false;
                                });
                              },
                              items: tagList.map<DropdownMenuItem<String>>(
                                  (String option) {
                                return DropdownMenuItem<String>(
                                    value: option, child: Text(option));
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment(-1.15, -1.0),
                    child: FlatButton(
                      onPressed: () {
                        _mealSearchList.accessList.clear();
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        size: 30.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: MealViewItem(_mealSearchList),
            ),
          ],
        ),
      ),
    );
  }
}

/*Scaffold(
      backgroundColor: Color(0xFFF6F7F8),
      body: FutureBuilder(
          future: _mealSearchList.getMealsFromTag(_chosenSearchTag),
          builder: (bCtx, snapshop) {
            if (snapshop.connectionState == ConnectionState.done) {
              return Column(
                children: <Widget>[
                  SafeArea(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFFCECC5),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'Day ${_index + 1}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF07084B),
                                    fontSize: 33,
                                    fontFamily: 'Pacifico',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  'Meals For ${_mealType == 0 ? 'Breakfast' : _mealType == 1 ? 'Lunch' : 'Dinner'}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF07084B),
                                    fontSize: 33,
                                    fontFamily: 'Pacifico',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10,
                                    horizontal: 25,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(29.5),
                                  ),
                                  height: 50,
                                  alignment: Alignment.centerRight,
                                  width: double.infinity,
                                  child: DropdownButton<String>(
                                    value: _chosenSearchTag,
                                    icon: Icon(Icons.arrow_drop_down),
                                    iconSize: 25,
                                    elevation: 15,
                                    isExpanded: true,
                                    onChanged: (String chosenOption) async {
                                      setState(() {
                                        _chosenSearchTag = chosenOption;
                                      });
                                      await _mealSearchList
                                          .getMealsFromTag(_chosenSearchTag);
                                      setState(() {
                                      });
                                    },
                                    items: tagList
                                        .map<DropdownMenuItem<String>>(
                                            (String option) {
                                      return DropdownMenuItem<String>(
                                          value: option, child: Text(option));
                                    }).toList(),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment(-1.15, -1.0),
                          child: FlatButton(
                            onPressed: () {
                              _mealSearchList.accessList.clear();
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              size: 30.0,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: MealViewItem(_mealSearchList),
                  ),
                ],
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),*/
