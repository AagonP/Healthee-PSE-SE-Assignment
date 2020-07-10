import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRegisterPage extends StatefulWidget {
  @override
  _LoginRegisterPageState createState() => _LoginRegisterPageState();
}

class _LoginRegisterPageState extends State<LoginRegisterPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<void> signInGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);
    if (await googleSignIn.isSignedIn()) {
      print('yes bitch');
    } else
      print('fuck no');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: Image(
                  image: AssetImage(
                    'image/nutrition.png',
                  ),
                  height: 80.0,
                ),
              ),
              TyperAnimatedTextKit(
                isRepeatingAnimation: false,
                speed: Duration(
                  milliseconds: 300,
                ),
                text: ['Healthee'],
                textAlign: TextAlign.center,
                textStyle: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Pacifico',
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              RoundedButton(
                title: 'Sign Up',
                onPressed: () {
                  Navigator.pushNamed(context, 'RegisterPage');
                },
                textColor: Colors.white,
                color: Color(0xFFFECC4C),
                borderColor: Color(0xFFFECC4C),
              ),
              RoundedButton(
                title: 'Log in',
                color: Colors.white,
                onPressed: () {
                  Navigator.pushNamed(context, 'LoginPage');
                },
                textColor: Color(0xFFFECC4C),
                borderColor: Color(0xFFFECC4C),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.0),
                height: 20.0,
                width: double.infinity,
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              RoundedButtonLink(
                color: Color(0xFF3B5999),
                title: 'Continue with Facebook',
                image: Image(
                  image: AssetImage(
                    'image/facebook.png',
                  ),
                ),
                function: () {},
              ),
              RoundedButtonLink(
                color: Color(0xFF518DF8),
                title: 'Continue with Google',
                image: Image.asset(
                  'image/brands-and-logotypes.png',
                ),
                function: () {
                  signInGoogle().whenComplete(
                      () => Navigator.pushNamed(context, 'NavigatePage'));
                },
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: 10.0,
                  bottom: 10.0,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'NavigatePage');
                  },
                  child: Text(
                    'Skip for now',
                    style: TextStyle(
                        color: Color(0xFFFECC4C), fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class RoundedButton extends StatelessWidget {
  RoundedButton(
      {@required this.title,
      @required this.color,
      @required this.onPressed,
      @required this.textColor,
      this.borderColor});

  final Color textColor;
  final Color color;
  final String title;
  final Function onPressed;
  Color borderColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
          side: BorderSide(
            color: borderColor,
          ),
        ),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 50.0,
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

class RoundedButtonLink extends StatelessWidget {
  final Color color;
  final String title;
  final Image image;
  final Function function;

  RoundedButtonLink(
      {@required this.color, @required this.title, this.image, this.function});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: MaterialButton(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        onPressed: function,
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
