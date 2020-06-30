import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 50.0,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 5.0,
                ),
                child: Image(
                  image: AssetImage('image/welcome.png'),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Welcome to Healthee',
                  style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'Pacifico',
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Getting food products and recipes matching your need is now just a matter of some clicks!',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'LoginRegisterPage');
                },
                child: Container(
                  margin: EdgeInsets.all(20.0),
                  height: 60.0,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFF1CB57),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Center(
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
