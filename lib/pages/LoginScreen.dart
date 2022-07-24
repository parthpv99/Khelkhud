import 'package:flutter/material.dart';
import '../validator.dart';
// import '../widgets/buttonLogin.dart';
// import '../widgets/InputUsername.dart';
import '../constants.dart';
// import '../widgets/password.dart';
import '../widgets/textLogin.dart';
// import '../widgets/buttonsignup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:requests/requests.dart';
import '../models/user.dart';
import '../models/apiurl.dart';
// import 'SignUpScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginFormKey = GlobalKey<FormState>();
  bool loginFormAutoValidation = false;
  String loginname = '', password = '';
  var checkBoxValue = true;
  User user;
  apiurl u = apiurl();
  bool splash = true;

  void validateForm() {
    if (loginFormKey.currentState.validate()) {
      loginFormKey.currentState.save();
      login();
    } else {
      setState(() {
        loginFormAutoValidation = true;
      });
    }
  }

  void login() async {
    try {
      var response = await Requests.post(u.getapi() + 'login',
          json: {"login_name": loginname.trim(), "password": password});
      response.raiseForStatus();

      if (response.statusCode == 200) {
        var userJson = response.json();
        // print(userJson);
        if (!userJson["is_error"]) {
          user = User.fromJson(userJson);
          user.setPreference();
          // print(user);
          Navigator.pushReplacementNamed(context, '/manageScreen');
        } else {
          Fluttertoast.showToast(
              msg: userJson["message"],
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        // print(response.json()); //if status code 500
      }
    } on Exception catch (e) {
      // print(e);
      Fluttertoast.showToast(
          msg: 'Unable to login. Please try again later',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void checkSession() async {
//    try {

//    } on Exception catch (e) {
//      splash = false;
//    }
    // print(user);
    // if(user==Null)
    // {
    //   Navigator.pushReplacementNamed(context, '/');
    // }
    try {
      user = await User.fromSharedPreference;
      if (user != null) {
        var response = await Requests.post(u.getapi() + 'session_check',
            json: {"token": user.token});
        response.raiseForStatus();

        if (response.statusCode == 200) {
          var userJson = response.json();
          // print(userJson);
          if (!userJson["is_error"]) {
            // print(user);
            if (user.loginname.length > 0) {
              Navigator.pushReplacementNamed(context, '/manageScreen');
            }
          }
        }
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: 'Error. Please try again later',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    checkSession();
  }

  @override
  Widget build(BuildContext context) {
//    if (splash && user == null) {
//      return Scaffold(body: SafeArea(child: Center(child: CircularProgress)));
//    } else {
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
              key: loginFormKey,
              // autovalidate: loginFormAutoValidation,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextLogin(),
                      ]),
//                InputUsername(),
                  Center(
                    child: Container(
                      width: 350,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          TextFormField(
                            // keyboardType: TextInputType.emailAddress,
                            // validator: validateEmail,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            onSaved: (value) => loginname = value,
                            decoration: kTextFieldDecoration.copyWith(
                              labelText: 'Username',
                              labelStyle: TextStyle(color: Color(0xFFFE8B0E)),
                              hintText: 'Enter your E-mail ID / Mobile number',
                              hintStyle: TextStyle(color: Colors.white24),
                              prefixIcon:
                                  Icon(Icons.person, color: Color(0xFFFE8B0E)),
                            ),
                          ),
                          SizedBox(height: 15),
                          TextFormField(
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            obscureText: true,
                            validator: validatePassword,
                            onSaved: (value) => password = value,
                            decoration: kTextFieldDecoration.copyWith(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Color(0xFFFE8B0E)),
                              hintText: 'Enter your password',
                              hintStyle: TextStyle(color: Colors.white24),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color(0xFFFE8B0E),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // SizedBox(width: 45),
                              new Checkbox(
                                  value: checkBoxValue,
                                  // hoverColor: Colors.white,
                                  // focusColor: Colors.white,
                                  activeColor: Color(0xFFFE8B0E),
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      checkBoxValue = newValue;
                                    });
                                  }),
                              Expanded(
                                child: Text(
                                  'Remember me',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: InkWell(
                                  child: Text(
                                    'Forget password ?',
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, '/forgotPasswordScreen');
                                  },
                                ),
                              ),
                              // SizedBox(width: 60)
                            ],
                          ),
                          SizedBox(height: 5),
                          Row(
                            children: <Widget>[
                              // SizedBox(width: 60),
                              Expanded(
                                child: Container(
                                  height: 50,
                                  child: FlatButton(
                                    textColor: Color(0xff2E3754),
                                    color: Colors.white,
                                    // onPressed: validateForm,
                                    onPressed: () {
                                      // validateForm();
                                      // Navigator.pushNamed(context,'/signUpScreen');
                                      Navigator.pushNamed(
                                          context, '/signUpScreen');
                                    },
                                    shape: kRoundedBorder,
                                    child: Text(
                                      'Sign Up',
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
                                      'Login',
                                      style: kTextButton,
                                    ),
                                  ),
                                ),
                              ),
                              // SizedBox(width: 60),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
//    }
  }
}
