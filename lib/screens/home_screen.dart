import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/drawer.dart';
import '../plan_for_a_diet/plan_for_a_diet_logic_handler/plan_a_diet_click_handler.dart';
import '../providers/products.dart';
import 'package:provider/provider.dart';

class NavigatePage extends StatefulWidget {
  @override
  _NavigatePageState createState() => _NavigatePageState();
}

class _NavigatePageState extends State<NavigatePage> {
  final _auth = FirebaseAuth.instance;

  FirebaseUser loginUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loginUser = user;
        print(loginUser.email);
        print(loginUser.displayName);
      } else
        print('no user');
    } catch (e) {
      print(e);
    }
  }

  void clearProduct() {
    Provider.of<Products>(context).clearProduct();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.clear_all,
                color: Color(0xFFF1CB57),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Healthee',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 50,
                          fontFamily: 'Pacifico',
                        ),
                      ),
                    ),
                  ),
                  //Second Title "Nutrition & Diet"
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Nutrition & Diet',
                        style: TextStyle(
                          fontSize: 30,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  NavigateTab(
                    color: Color(0xFFFDF4DE),
                    title: 'Search recipe \n and product',
                    description: 'Get the best food just for you',
                    navigatePage: 'HomePage',
                    image: Image(
                      width: 60.0,
                      height: 60.0,
                      image: AssetImage('image/recipe.png'),
                    ),
                    function: clearProduct,
                  ),
                  NavigateTab(
                    color: Colors.red[50],
                    title: 'Filter by Illness',
                    description: 'Know what suits your health',
                    navigatePage: 'FilterScreen',
                    image: Image(
                      width: 60.0,
                      height: 60.0,
                      image: AssetImage('image/filter.png'),
                    ),
                  ),
                  NavigateTab(
                    color: Color(0xFFE9F4FE),
                    title: 'Plan a diet',
                    description: 'Make your own diet',
                    navigatePage: '/plan-a-diet',
                    image: Image(
                      width: 60.0,
                      height: 60.0,
                      image: AssetImage('image/calendar.png'),
                    ),
                  ),
                  NavigateTab(
                    color: Color(0xFFE8F3EB),
                    title: 'Scan a product',
                    description: 'Get product information \n with your camera',
                    navigatePage: 'HomePage',
                    image: Image(
                      width: 60.0,
                      height: 60.0,
                      image: AssetImage('image/photograph.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavigateTab extends StatelessWidget {
  final Function function;
  final Color color;
  final String title;
  final String description;
  final Image image;
  final String navigatePage;

  NavigateTab(
      {@required this.color,
      @required this.title,
      @required this.navigatePage,
      this.image,
      this.description,
      this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Condition before moving into Plan A Diet
        if (navigatePage == '/plan-a-diet') {
          PADClickHandler().clickFAP(context);
        } else if (navigatePage == 'HomePage') {
          function();
          Navigator.pushNamed(context, navigatePage);
        } else {
          Navigator.pushNamed(context, navigatePage);
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10.0,
        ),
        height: 110.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(7.0),
                //width: 80.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: image,
            ),
          ],
        ),
      ),
    );
  }
}
