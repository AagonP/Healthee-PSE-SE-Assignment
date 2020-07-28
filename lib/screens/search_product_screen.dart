import 'package:flutter/material.dart';
import '../widgets/food_list_view.dart';
import '../providers/data_helper.dart';
import '../widgets/category.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'scan.dart';
import 'package:pse_assignment/widgets/BottomNavigator.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../providers/list_of_entry.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _typeAheadController = TextEditingController();
  bool isLoading = false;
  String res = "Sample code";
  FoodData foodData = FoodData();

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

  void navigateToFilterScreen(BuildContext context) {
    //NavigateToFilterScreen()
    Navigator.pushNamed(context, 'FilterScreen');
  }

  void bottomRandomCallBack() async {
    setState(() {
      isLoading = true;
    });
    Provider.of<Products>(context).clearProduct();
    await foodData.getRandomProduct(context);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Color(0xFFF6F7F8),
        bottomNavigationBar: BottomBar(
          callback: this.bottomRandomCallBack,
        ),
        body: Column(
          children: <Widget>[
            SafeArea(
              child: Container(
                //height: size.height * 0.35,
                decoration: BoxDecoration(
                  color: Color(0xFFFCECC5),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Recipe and Product',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF07084B),
                          fontSize: 33,
                          fontFamily: 'Pacifico',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: TypeAheadField(
                          textFieldConfiguration: TextFieldConfiguration(
                            onSubmitted: (value) async {
                              if (suggestion.contains(value)) {
                                setState(() {
                                  isLoading = true;
                                });
                                await foodData.getRecipe(context, value);
                                setState(() {
                                  isLoading = false;
                                });
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Enter Recipe or Product',
                              labelStyle: TextStyle(
                                color: Colors.black54,
                              ),
                              hintText: 'Enter by name',
                              hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade400,
                              ),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.blueAccent,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            controller: this._typeAheadController,
                          ),
                          onSuggestionSelected: (suggestion) async {
                            setState(() {
                              isLoading = true;
                            });
                            await foodData.getRecipe(
                                context, suggestion.toString());
                            setState(() {
                              isLoading = false;
                            });
                          },
                          itemBuilder: (BuildContext context, itemData) {
                            return itemData.toString().isEmpty
                                ? ListTile(
                                    leading: Icon(Icons.do_not_disturb_alt),
                                    title: Text(
                                      'No data found',
                                    ),
                                  )
                                : ListTile(
                                    leading: Icon(Icons.fastfood),
                                    title: Text(
                                      itemData.toString(),
                                    ),
                                  );
                          },
                          suggestionsCallback: (String pattern) {
                            return pattern.isEmpty
                                ? suggestion
                                : suggestion
                                    .where((e) =>
                                        e.startsWith(pattern.toLowerCase()))
                                    .toList();
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          RoundTypeButton(
                            color: Color(0xFFFEC2C2),
                            image: 'image/food.png',
                            title: 'Vegan',
                          ),
                          RoundTypeButton(
                            color: Color(0xFFCEFFC0),
                            image: 'image/dairy.png',
                            title: 'DairyFree',
                          ),
                          RoundTypeButton(
                            color: Color(0xFFFEE1C7),
                            image: 'image/fruit.png',
                            title: 'LowFodMap',
                          ),
                          RoundTypeButton(
                            color: Color(0xFFFDDFFA),
                            image: 'image/coin.png',
                            title: 'Cheap',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: FoodListView(),
            ),
          ],
        ),
      ),
    );
  }
}

//
//Row(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Expanded(
//                child: Card(
//                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                  //Search input field
//                  child: Container(
//                    height: 45.0,
//                    child: TextField(
//                      autofocus: false,
//                      onSubmitted: (context) {
//                        searchOnSubmitted(context);
//                      },
//                      controller: _controller,
//                      decoration: InputDecoration(
//                        suffixIcon: IconButton(
//                          onPressed: () => _controller.clear(),
//                          icon: Icon(
//                            Icons.clear,
//                            color: Colors.grey,
//                          ),
//                        ),
//                        border: OutlineInputBorder(
//                          borderSide: BorderSide.none,
//                        ),
//                        hintText: 'Search product..',
//                        hintStyle: TextStyle(
//                          color: Colors.grey,
//                        ),
//                        prefixIcon: Icon(Icons.search),
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//              // Filter search
//              Card(
//                child: IconButton(
//                  onPressed: () {
//                    navigateToFilterScreen(context);
//                  },
//                  icon: Badge(
//                      badgeColor: Colors.white,
//                      animationType: BadgeAnimationType.scale,
//                      badgeContent: Text((Provider.of<Products>(context)
//                              .filteringProducts
//                              .length)
//                          .toString()),
//                      child: Icon(Icons.shopping_cart)), //filter
//                ),
//              ),
//              //Scan screen
//              Card(
//                child: IconButton(
//                  onPressed: () {
//                    doScanning();
//                  },
//                  icon: Icon(Icons.camera_alt),
//                ),
//              ),
//            ],
//          ),
//          //Food filter
//          Row(
//            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//            children: <Widget>[
//              RoundTypeButton(
//                color: Color(0xFFF7F6C5),
//                image: 'image/food.png',
//                title: 'Vegan',
//              ),
//              RoundTypeButton(
//                color: Color(0xFFCEFFC0),
//                image: 'image/dairy.png',
//                title: 'DairyFree',
//              ),
//              RoundTypeButton(
//                color: Color(0xFFFEE1C7),
//                image: 'image/fruit.png',
//                title: 'LowFodMap',
//              ),
//              RoundTypeButton(
//                color: Color(0xFFFDDFFA),
//                image: 'image/coin.png',
//                title: 'Cheap',
//              ),
//            ],
//          ),
//          Padding(
//            padding: EdgeInsets.all(10),
//          ),
//          Expanded(
//            child: FoodListView(),
//          ),
