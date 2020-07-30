
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import './recipe_list_view.dart';
import '../../models/product.dart';
import '../../providers/products.dart';
import '../../providers/data_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser user;
  String name = '';
  @override
//Text input controller
  var _controller = TextEditingController();
  //List<String> id = List(20);
  var input;
  FoodData foodData = FoodData();

  //this function is for uploading data to firebase
  void uploadData(String name) async {
    var data = await foodData.getFoodData(name, 10, 0);
    print(data);
    foodData.uploadDataFromApiToFireBase(data, 10, name);
  }

  //Update UI when loading product list
  void updateUI(String name) async {
    Provider.of<Products>(context).clearProduct();
    DocumentSnapshot documentSnapshot = await foodData.getEntry(name);
    List<dynamic> recipe = documentSnapshot.data['Recipe'];

    for (int i = 0; i < 10; i++) {
      Product product = await foodData.decodeProduct(recipe[i]);
      if (product.name != null)
        Provider.of<Products>(context).addProduct(product);
    }
    Provider.of<Products>(context).updateDisplayProduct('all');
  }

  void navigateToFilterScreen(BuildContext context) {
    //NavigateToFilterScreen()
    Navigator.pushNamed(context, 'FilterScreen');
  }

  void searchOnSubmitted(String context) {
    //onSubmittedChange(String key)
    print(context);
    input = context;
    updateUI(input);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Color(0xFFF8F8F8),
      body: Column(
        children: <Widget>[
          //Title "Healthee"
          SafeArea(
            child: Container(
              //height: size.height * 0.4,
              decoration: BoxDecoration(
                color: Color(0xFFFDF4DE),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 7,
                      ),
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29.5),
                      ),
                      child: TextField(
                        controller: _controller,
                        autofocus: false,
                        onSubmitted: (context) {
                          searchOnSubmitted(context);
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                            onPressed: () => _controller.clear(),
                            icon: Icon(
                              Icons.clear,
                              color: Colors.grey,
                            ),
                          ),
                          hintText: "Search",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                          ),
                          icon: Icon(Icons.search),
                          border: InputBorder.none,
                        ),
                      ),
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
            child: RecipeListView(),
          ),
        ],
      ),
    );
  }
}