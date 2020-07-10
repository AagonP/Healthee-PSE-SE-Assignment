//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class CustomDrawer extends StatelessWidget {
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }
    } catch (e) {
      print(e); // TODO: show dialog with error
    }
  }

  Widget _drawerTitle({
    IconData icon,
    String title,
    Function ontap,
  }) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 7.0),
            child: Text(
              title,
            ),
          )
        ],
      ),
      onTap: ontap,
    );
  }

  Widget _drawerHeader() {
    return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage('image/table.jpg'),
        ),
      ),
      child: Stack(
        children: <Widget>[
          Center(
            child: Text(
              'Healthee',
              style: TextStyle(
                fontSize: 40,
                color: Colors.black38,
                letterSpacing: 3.0,
                fontFamily: 'Pacifico',
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _drawerHeader(),
          _drawerTitle(
            icon: Icons.face,
            title: 'Change information',
          ),
          _drawerTitle(
              icon: Icons.chevron_left,
              title: 'Sign out',
              ontap: () async {
                await _signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                    'WelcomePage', (Route<dynamic> route) => false);
              }),
        ],
      ),
    );
  }
}
