import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:progress_dialog/progress_dialog.dart';

// Packages for fetching user's health data
import 'package:provider/provider.dart';
import '../../providers/user_health_data.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

// This class is for handling clicking Login
class LoginDataFetcher {}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  String name;
  bool obscure = true;
  final _formKey = GlobalKey<FormState>();
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    // This is for fetching User's Health Data.
    final userHealthData = Provider.of<UserHealthData>(context);

    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: 50.0,
                  ),
                  child: Image(
                    image: AssetImage(
                      'image/nutrition.png',
                    ),
                    height: 90.0,
                  ),
                ),
                Text(
                  'Log in',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Pacifico',
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextFormField(
                        decoration: inputDecoration.copyWith(
                          hintText: 'Enter your email',
                        ),
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          email = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: inputDecoration.copyWith(
                          hintText: 'Enter your password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.remove_red_eye,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                obscure = !obscure;
                              });
                            },
                          ),
                          contentPadding: EdgeInsets.only(
                            top: 10.0,
                            bottom: 10.0,
                            left: 45.0,
                          ),
                        ),
                        textAlign: TextAlign.center,
                        obscureText: obscure,
                        onChanged: (value) {
                          password = value;
                        },
                        validator: (value) => (value.length < 6)
                            ? 'Password can\'t less then 6'
                            : null,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Builder(
                        builder: (context) => Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.0),
                          child: MaterialButton(
                            color: Color(0xFFFECC4C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            onPressed: () async {
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  showSpinner = true;
                                });
                                try {
                                  final user =
                                      await _auth.signInWithEmailAndPassword(
                                          email: email, password: password);
                                  var isFirstLogin =
                                      await userHealthData.getUserHealthData();
                                  if (user != null) {
                                    if (isFirstLogin == false) {
                                      Future.delayed(Duration(seconds: 1))
                                          .then((value) {
                                        setState(() {
                                          showSpinner = false;
                                        });
                                        Navigator.pushNamed(
                                            context, 'NavigatePage');
                                      });
                                    } else {
                                      Future.delayed(Duration(seconds: 1))
                                          .then((value) {
                                        setState(() {
                                          showSpinner = false;
                                        });
                                        Navigator.pushNamed(context,
                                            '/health-data-input-screen');
                                      });
                                    }
                                  }
                                } catch (signInError) {
                                  print(signInError);
                                  if (signInError is PlatformException) {
                                    setState(() {
                                      showSpinner = false;
                                    });
                                    Scaffold.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text('Email or password wrong'),
                                      ),
                                    );
                                  }
                                }
                                setState(() {
                                  showSpinner = false;
                                });
                              }
                            },
                            minWidth: 200.0,
                            height: 50.0,
                            child: Text(
                              'Log In',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
//              TextField(
//                decoration:
//                    inputDecoration.copyWith(hintText: 'Enter your email'),
//                textAlign: TextAlign.center,
//                keyboardType: TextInputType.emailAddress,
//                onChanged: (value) {
//                  email = value;
//                },
//              ),
//              SizedBox(
//                height: 10.0,
//              ),
//              TextField(
//                decoration: inputDecoration.copyWith(
//                  hintText: 'Enter your password',
//                  suffixIcon: IconButton(
//                    icon: Icon(
//                      Icons.remove_red_eye,
//                      color: Colors.grey,
//                    ),
//                    onPressed: () {
//                      setState(() {
//                        obscure = !obscure;
//                      });
//                    },
//                  ),
//                  contentPadding: EdgeInsets.only(
//                    top: 10.0,
//                    bottom: 10.0,
//                    left: 45.0,
//                  ),
//                ),
//                textAlign: TextAlign.center,
//                obscureText: obscure,
//                onChanged: (value) {
//                  password = value;
//                },
//              ),
//              SizedBox(
//                height: 10.0,
//              ),
//              Padding(
//                padding: EdgeInsets.symmetric(vertical: 10.0),
//                child: MaterialButton(
//                  color: Color(0xFFFECC4C),
//                  shape: RoundedRectangleBorder(
//                    borderRadius: BorderRadius.circular(30.0),
//                  ),
//                  onPressed: () async {
//                    // Fetch user health data, if first login,
//                    // navigate to HealthDataInputScreen,
//                    // if not, navigate to HomeScreen
//                    await pr.show();
//                    try {
//                      final user = await _auth.signInWithEmailAndPassword(
//                          email: email, password: password);
//                      var isFirstLogin =
//                          await userHealthData.getUserHealthData();
//                      if (user != null) {
//                        if (isFirstLogin == false) {
//                          Future.delayed(Duration(seconds: 1)).then((value) {
//                            pr.hide().whenComplete(() {
//                              Navigator.pushNamed(context, 'NavigatePage');
//                            });
//                          });
//                        } else {
//                          Future.delayed(Duration(seconds: 1)).then((value) {
//                            pr.hide().whenComplete(() {
//                              Navigator.pushNamed(
//                                  context, '/health-data-input-screen');
//                            });
//                          });
//                        }
//                      }
//                    } catch (e) {
//                      print(e);
//                    }
//                  },
//                  minWidth: 200.0,
//                  height: 50.0,
//                  child: Text(
//                    'Log In',
//                    textAlign: TextAlign.center,
//                    style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 15.0,
//                      fontWeight: FontWeight.w600,
//                    ),
//                  ),
//                ),
//              ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  height: 20.0,
                  width: double.infinity,
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Don\'t have an account? ',
                        textAlign: TextAlign.center,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'RegisterPage');
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const inputDecoration = InputDecoration(
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  hintText: 'Enter your name',
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFFECC4C), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFFECC4C), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(30.0)),
  ),
);
