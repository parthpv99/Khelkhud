import 'dart:convert';

import 'package:SportsAcademy/models/apiurl.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:requests/requests.dart';
import '../constants.dart';
import '../validator.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String loginname;

  final forgetpasswordformkey = GlobalKey<FormState>();
  bool forgetpasswordFormAutoValidation = false;

  void validateForm() {
    if (forgetpasswordformkey.currentState.validate()) {
      forgetpasswordformkey.currentState.save();
      sendPassword();
    } else {
      setState(() {
        forgetpasswordFormAutoValidation = true;
      });
    }
  }

  apiurl u = apiurl();
  void sendPassword() async {
    try {
      var response = await Requests.post(u.getapi() + 'forgot_pass',
          json: {"login_name": loginname});
      response.raiseForStatus();

      if (response.statusCode == 200) {
        var userJson = response.json();
        if (!userJson["is_error"]) {
          Fluttertoast.showToast(
              msg: "Password Succesfully send on your E-mail😊✌",
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Navigator.pop(context);
        } else {
          Fluttertoast.showToast(
              msg: userJson["message"],
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        Fluttertoast.showToast(
            msg: 'Network Error !!!!!!',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } on Exception catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: 'Network Error !!!!!!😁😁',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

// Password 82EMe21F
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xff2E3754),
            image: DecorationImage(
              image: AssetImage('assets/46.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.8), BlendMode.srcATop),
            ),
          ),
          child: Center(
            child: Container(
              width: 350,
              child: Form(
                key: forgetpasswordformkey,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
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
                                      // Text(
                                      //   'Welcome Back! Please login to your account',
                                      //   style: TextStyle(
                                      //     fontSize: 15,
                                      //     color: Colors.white,
                                      //     letterSpacing: 1,
                                      //   ),
                                      // ),
                                      SizedBox(height: 60),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                    TextFormField(
                      // keyboardType: TextInputType.emailAddress,
                      // validator: validateEmail,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      onSaved: (value) => loginname = value,
                      validator: validateEmail,
                      decoration: kTextFieldDecoration.copyWith(
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Color(0xFFFE8B0E)),
                        hintText: 'Enter your E-mail ID / Mobile number',
                        hintStyle: TextStyle(color: Colors.white24),
                        prefixIcon:
                            Icon(Icons.person, color: Color(0xFFFE8B0E)),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: FlatButton(
                              onPressed: () {
                                Navigator.pop(context, '/');
                              },
                              shape: kRoundedBorder,
                              child: Text(
                                'Go back',
                                style: kTextButton,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFFE8B0E),
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: FlatButton(
                                onPressed: () {
                                  validateForm();
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      "Send Password",
                                    )
                                  ],
                                )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
