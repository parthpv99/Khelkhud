import 'dart:async';

import '../constants.dart';
import '../models/apiurl.dart';
import '../models/user.dart';
import '../widgets/repository.dart';
import '../widgets/stateandcity.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:requests/requests.dart';

import '../validator.dart';

class AddTourny extends StatefulWidget {
  // SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<AddTourny> {
  // var checkBoxValue=false;

  final format = DateFormat("dd-MM-yyyy");
  final signupFormKey = GlobalKey<FormState>();
  final passwordFieldKey = GlobalKey<FormFieldState>();
  // final dateTimeField = GlobalKey<FormFieldState>();
  bool signupFormAutoValidation = false;
  String fname, lname, email, password, birthdate;

  //For Dropdown
  Repository repo = Repository();
  List<String> _states = ["Choose a state"];
  List<String> districts = ["Choose a city"];
  String _selectedState = "Choose a state";
  String _selectedLGA = "Choose a city";

  String validateConfirmPassword(String value) {
    if (value.isEmpty) {
      return 'Confirm password is required';
    }
    if (passwordFieldKey.currentState.value != value) {
      return 'Password not matching';
    }
    return null;
  }

  void _onSelectedState(String value) {
    setState(() {
      _selectedLGA = "Choose a city";
      districts = ["Choose a city"];
      _selectedState = value;
      districts = List.from(districts)..addAll(repo.getLocalByState(value));
    });
  }

  void _onSelectedLGA(String value) {
    setState(() => _selectedLGA = value);
  }

  void validateForm() {
    if (signupFormKey.currentState.validate()) {
      signupFormKey.currentState.save();
      signup();
    } else {
      setState(() {
        signupFormAutoValidation = true;
      });
    }
  }

  apiurl u = apiurl();
  void signup() async {
    // birthdate = dob.day.toString()+"/"+dob.month.toString()+"/"+dob.year.toString();
    // print(birthdate);
    try {
      var response = await Requests.post(u.getapi() + 'signup', json: {
        "fname": fname,
        "lname": lname,
        "city": _selectedLGA,
        "state": _selectedState,
        "dob": birthdate,
        "login_name": email,
        "password": password,
      });
      response.raiseForStatus();

      if (response.statusCode == 200) {
        var userJson = response.json();

        if (!userJson["is_error"]) {
          // User user = User.fromJson({
          //   "data": {
          //     "fname": fname,
          //     "lname": lname,
          //     "city": _selectedLGA,
          //     "state": _selectedState,
          //     "user_interest": "",
          //     "dob": birthdate,
          //     "login_name": email,
          //   }
          // });
          // user.setPreference();

          var response = await Requests.post(u.getapi() + 'login',
              json: {"login_name": email, "password": password});
          response.raiseForStatus();

          if (response.statusCode == 200) {
            var userJson = response.json();
            // print(userJson);
            if (!userJson["is_error"]) {
              User user = User.fromJson(userJson);
              user.setPreference();

              Fluttertoast.showToast(
                  msg: 'Sign up successful',
                  toastLength: Toast.LENGTH_LONG,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
              // print(user.token);
              Navigator.pushReplacementNamed(context, '/userinterest');
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
                msg: userJson["message"],
                toastLength: Toast.LENGTH_LONG,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0); //if status code 500
          }
        }
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: 'E-mail Already Exist',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    _states = List.from(_states)..addAll(repo.getStates());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
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
          child: Form(
            key: signupFormKey,
            autovalidate: signupFormAutoValidation,
            child: ListView(
              shrinkWrap: true,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'Khel Kud',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        letterSpacing: 5,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Please Fill The Form To Apply as a Coach',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Container(
                    width: 350,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: TextFormField(
                                // keyboardType: TextInputType.emailAddress,
                                // validator: validateEmail,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                onSaved: (value) => fname = value,
                                decoration: kTextFieldDecoration.copyWith(
                                  labelText: 'First Name',
                                  labelStyle:
                                      TextStyle(color: Color(0xFFFE8B0E)),
                                  hintText: 'Enter First',
                                  hintStyle: TextStyle(color: Colors.white24),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                                onSaved: (value) => lname = value,
                                decoration: kTextFieldDecoration.copyWith(
                                  labelText: 'Last Name',
                                  labelStyle:
                                      TextStyle(color: Color(0xFFFE8B0E)),
                                  hintText: 'Enter Last Name',
                                  hintStyle: TextStyle(color: Colors.white24),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          validator: validateEmail,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          onSaved: (value) => email = value,
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Color(0xFFFE8B0E)),
                            hintText: 'Enter your E-mail ID',
                            hintStyle: TextStyle(color: Colors.white24),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: DateTimeField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            decoration: kTextFieldDecoration.copyWith(
                              labelText: 'Date of birth',
                              labelStyle: TextStyle(color: Color(0xFFFE8B0E)),
                              // hintText: 'Enter your E-mail ID',
                              hintStyle: TextStyle(color: Colors.white24),
                            ),
                            format: format,
                            onShowPicker: (context, currentValue) async {
                              final sDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(1900),
                                  initialDate: currentValue ?? DateTime.now(),
                                  lastDate: DateTime(2100));
                              return sDate;
                            },
                            onSaved: (currentValue) => birthdate =
                                currentValue.day.toString() +
                                    "/" +
                                    currentValue.month.toString() +
                                    "/" +
                                    currentValue.year.toString(),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            child: Row(
                          children: <Widget>[
                            Container(
                              decoration: new BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                  border:
                                      new Border.all(color: Color(0xFFFE8B0E))),
                              child: DropdownButton<String>(
                                // isExpanded: true,
                                underline: SizedBox(),
                                style: TextStyle(color: Color(0xFFFE8B0E)),
                                items: _states.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(dropDownStringItem),
                                  );
                                }).toList(),
                                onChanged: (value) => _onSelectedState(value),
                                value: _selectedState,
                              ),
                            ),
                            SizedBox(width: 5),
                            Container(
                              //          width: 30,
                              decoration: new BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0)),
                                  border:
                                      new Border.all(color: Color(0xFFFE8B0E))),
                              child: DropdownButton<String>(
                                // isExpanded: true,
                                underline: SizedBox(),
                                style: TextStyle(color: Color(0xFFFE8B0E)),
                                items:
                                    districts.map((String dropDownStringItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropDownStringItem,
                                    child: Text(dropDownStringItem),
                                  );
                                }).toList(),
                                // onChanged: (value) => print(value),
                                onChanged: (value) => _onSelectedLGA(value),
                                value: _selectedLGA,
                              ),
                            ),
                          ],
                        )),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          key: passwordFieldKey,
                          obscureText: true,

                          // keyboardType: TextInputType.emailAddress,
                          validator: validatePassword,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          onSaved: (value) => password = value,
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Color(0xFFFE8B0E)),
                            hintText: 'Enter Your Password',
                            hintStyle: TextStyle(color: Colors.white24),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: true,

                          // keyboardType: TextInputType.emailAddress,
                          validator: validateConfirmPassword,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          // onSaved: (value) => loginname = value,
                          decoration: kTextFieldDecoration.copyWith(
                            labelText: 'Confirm Password',
                            labelStyle: TextStyle(color: Color(0xFFFE8B0E)),
                            hintText: 'Re-Enter Your Password',
                            hintStyle: TextStyle(color: Colors.white24),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: <Widget>[
                            // SizedBox(width: 60),
                            Expanded(
                              child: Container(
                                height: 50,
                                child: FlatButton(
                                  // textColor:  Color(0xff2E3754),
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                        context, '/');
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
                                height: 50,
                                child: FlatButton(
                                  color: Color(0xFFFE8B0E),
                                  textColor: Color(0xff2E3754),
                                  onPressed: validateForm,
                                  shape: kRoundedBorder,
                                  child: Text(
                                    'Create New Account',
                                    style: kTextButton,
                                  ),
                                ),
                              ),
                            ), // SizedBox(width: 60),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
