import 'package:flutter/material.dart';

class TextLogin extends StatefulWidget {
  @override
  _TextLoginState createState() => _TextLoginState();
}

class _TextLoginState extends State<TextLogin> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.green,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 0),
          Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Khel Kud'.toUpperCase(),
                  style: TextStyle(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Welcome Back!\nPlease login to your account',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    letterSpacing: 1,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 60),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
