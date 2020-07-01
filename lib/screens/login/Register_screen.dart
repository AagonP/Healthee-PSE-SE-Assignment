import 'package:flutter/material.dart';
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
  bool obsucre = true;

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
                TextField(
                  decoration: inputDecoration.copyWith(
                    hintText: ''
                        'Enter your name',
                  ),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    name = value;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  decoration:
                      inputDecoration.copyWith(hintText: 'Enter your email'),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextField(
                  decoration: inputDecoration.copyWith(
                    hintText: 'Enter your password',
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          obsucre = !obsucre;
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
                  obscureText: obsucre,
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  child: MaterialButton(
                    color: Color(0xFFFECC4C),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    onPressed: () {},
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
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  height: 20.0,
                  width: double.infinity,
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                RoundRectangleButton(
                  color: Color(0xFF3B5999),
                  title: 'Sign up with Facebook',
                  image: Image(
                    image: AssetImage(
                      'image/facebook.png',
                    ),
                  ),
                ),
                RoundRectangleButton(
                  color: Color(0xFF518DF8),
                  title: 'Sign up with Google',
                  image: Image.asset(
                    'image/brands-and-logotypes.png',
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

class RoundRectangleButton extends StatelessWidget {
  final Color color;
  final String title;
  final Image image;

  RoundRectangleButton(
      {@required this.color, @required this.title, this.image});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: MaterialButton(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: () {},
        minWidth: 200.0,
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              width: 35.0,
              height: 35.0,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: image,
              ),
            ),
          ],
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
