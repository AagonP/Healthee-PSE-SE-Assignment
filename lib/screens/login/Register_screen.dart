import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;
  String name;
  bool obscure = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  'Registration',
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
                          hintText: 'Enter your name',
                        ),
                        textAlign: TextAlign.center,
                        onChanged: (value) {
                          name = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: inputDecoration.copyWith(
                            hintText: 'Enter your email'),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter your user name';
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
                                  final user = await _auth
                                      .createUserWithEmailAndPassword(
                                          email: email, password: password);
                                  FirebaseUser newUser =
                                      await _auth.currentUser();
                                  UserUpdateInfo updateInfo = UserUpdateInfo();
                                  updateInfo.displayName = name;
                                  print(name);
                                  await newUser.updateProfile(updateInfo);
                                  print('USERNAME IS: ${newUser.displayName}');
                                  if (user != null) {
                                    Navigator.pushNamed(
                                        context, 'NavigatePage');
                                  }
                                } catch (signUpError) {
                                  print(signUpError);
                                  if (signUpError is PlatformException) {
                                    if (signUpError.code ==
                                        'ERROR_EMAIL_ALREADY_IN_USE') {
                                      setState(() {
                                        showSpinner = false;
                                      });

                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Email already in use'),
                                        ),
                                      );
                                    }
                                    if (signUpError.code ==
                                        'ERROR_INVALID_EMAIL') {
                                      setState(() {
                                        showSpinner = false;
                                      });

                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Invalid email'),
                                        ),
                                      );
                                    }
                                    if (signUpError.code ==
                                        'ERROR_WEAK_PASSWORD') {
                                      setState(() {
                                        showSpinner = false;
                                      });

                                      Scaffold.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('Password is too weak'),
                                        ),
                                      );
                                    }
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
                              'Sign Up',
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
//                TextField(
//                  decoration: inputDecoration.copyWith(
//                    hintText: ''
//                        'Enter your name',
//                  ),
//                  textAlign: TextAlign.center,
//                  onChanged: (value) {
//                    name = value;
//                  },
//                ),
//                SizedBox(
//                  height: 10.0,
//                ),
//                TextField(
//                  decoration: inputDecoration.copyWith(
//                      hintText: 'Enter your user name'),
//                  textAlign: TextAlign.center,
//                  keyboardType: TextInputType.emailAddress,
//                  onChanged: (value) {
//                    email = value;
//                  },
//                ),
//                SizedBox(
//                  height: 10.0,
//                ),
//                TextFormField(
//                  decoration: inputDecoration.copyWith(
//                    hintText: 'Enter your password',
//                    suffixIcon: IconButton(
//                      icon: Icon(
//                        Icons.remove_red_eye,
//                        color: Colors.grey,
//                      ),
//                      onPressed: () {
//                        setState(() {
//                          obscure = !obscure;
//                        });
//                      },
//                    ),
//                    contentPadding: EdgeInsets.only(
//                      top: 10.0,
//                      bottom: 10.0,
//                      left: 45.0,
//                    ),
//                  ),
//                  textAlign: TextAlign.center,
//                  obscureText: obscure,
//                  onChanged: (value) {
//                    password = value;
//                  },
//                  validator: (value) =>
//                      (value.length < 6) ? 'Password can\'t less then 6' : null,
//                ),
//                SizedBox(
//                  height: 10.0,
//                ),
//                Padding(
//                  padding: EdgeInsets.symmetric(vertical: 10.0),
//                  child: MaterialButton(
//                    color: Color(0xFFFECC4C),
//                    shape: RoundedRectangleBorder(
//                      borderRadius: BorderRadius.circular(30.0),
//                    ),
//                    onPressed: () async {
//                      setState(() {
//                        showSpinner = true;
//                      });
//                      try {
//                        final user = await _auth.createUserWithEmailAndPassword(
//                            email: email, password: password);
//                        FirebaseUser newUser = await _auth.currentUser();
//                        UserUpdateInfo updateInfo = UserUpdateInfo();
//                        updateInfo.displayName = name;
//                        print(name);
//                        await newUser.updateProfile(updateInfo);
//                        print('USERNAME IS: ${newUser.displayName}');
//                        if (user != null) {
//                          Navigator.pushNamed(context, 'NavigatePage');
//                        }
//                        setState(() {
//                          showSpinner = false;
//                        });
//                      } catch (e) {
//                        print(e);
//                      }
//                    },
//                    minWidth: 200.0,
//                    height: 50.0,
//                    child: Text(
//                      'Sign Up',
//                      textAlign: TextAlign.center,
//                      style: TextStyle(
//                        color: Colors.white,
//                        fontSize: 15.0,
//                        fontWeight: FontWeight.w600,
//                      ),
//                    ),
//                  ),
//                ),
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
                        'Already have an account? ',
                        textAlign: TextAlign.center,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, 'LoginPage');
                        },
                        child: Text(
                          'Log in',
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
