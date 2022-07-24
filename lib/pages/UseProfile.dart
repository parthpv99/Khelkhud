import 'package:SportsAcademy/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class UseProfile extends StatefulWidget {
  @override
  _UseProfileState createState() => _UseProfileState();
}

class _UseProfileState extends State<UseProfile> {
  User user;
  List<String> sportsList = ["Football", "Cricket", "Hockey", "Badminton"];
  String name, email, password, contactNo, address, area, city;
  // BuildContext get context => null;

  void logout() async {
    final sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.remove("user");
    // user = await User.fromSharedPreference;
    // Navigator.pushNamedAndRemoveUntil(context,);

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff2e3754),
      appBar: (AppBar(
        // backgroundColor: Color(0xfffe8b0e),
        title: Text("Khel Kud"),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(onPressed: logout, child: Text("Logout")),
          SizedBox(
            width: 5,
          )
        ],
      )),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 50.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Hero(
                        tag: 'dp',
                        child: InkWell(
                          onTap: () {
//                             _getImage();
                          },
                          child: Stack(
                            children: <Widget>[
                              CircleAvatar(
//                                 backgroundImage: _image == null
//                                     ? AssetImage('assets/user.png')
//                                     : FileImage(
//                                         _image,
//                                       ),
                                backgroundImage: AssetImage('assets/46.jpg'),
                                radius: 55.0,
                              ),
                              Positioned(
                                bottom: 0.0,
                                child: InkWell(
                                  onTap: () {
//                                     _getImage();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xfffe8b0e),
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 20.0,
                                      minHeight: 20.0,
                                    ),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      InkWell(
                        onTap: () {
//                           _getImage();
                        },
                        child: Text(
                          'Change Photo',
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Card(
//                       color: Colors.transparent,
                      shape: kRoundedBorder,
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
//                               initialValue: u.address,
                              initialValue:
                                  "I am An All-Round Player. I play Badminton, Kabaddi, Cricket, Vollyball and passionate about Swimming.",
                              keyboardType: TextInputType.text,
                              maxLines: 4,
//                               validator: validateAddress,
                              onSaved: (value) => address = value,
                              decoration: kTextFieldDecoration.copyWith(
                                labelText: 'Mention Your Sports Achievements',
                                hintText: 'Enter your Achievements',
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 10.0, 0.0, 5.0),
                              child: RaisedButton(
                                onPressed: () {},
                                color: Color(0xfffe8b0e),
                                textColor: Colors.white,
                                shape: kRoundedBorder,
                                child: Text('Update Achievements'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40.0, 0, 40.0, 0),
                    child: Card(
//                       color: Colors.transparent,
                      shape: kRoundedBorder,
                      elevation: 2.0,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            TextFormField(
//                               initialValue: u.firstName,
                              initialValue: "Nisarg Chokshi",
                              keyboardType: TextInputType.text,
//                               validator: validateFirstName,
                              onSaved: (value) => name = value,
                              decoration: kTextFieldDecoration.copyWith(
                                labelText: 'User Name',
                                hintText: 'Enter your Name',
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
//                               initialValue: u.mobileNo,
                              initialValue: "9624904521",
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: false, signed: false),
//                               validator: validateContactNo,
                              onSaved: (value) => contactNo = value,
                              maxLength: 10,
                              decoration: kTextFieldDecoration.copyWith(
                                labelText: 'Contact No.',
                                hintText: 'Enter your contact number',
                                prefixIcon: Icon(Icons.phone_android),
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            TextFormField(
//                               initialValue: u.email,
                              initialValue: "nisarg4000@gmail.com",
                              keyboardType: TextInputType.emailAddress,
//                               validator: validateContactNo,
//                               onSaved: (value) => contactNo = value,
                              decoration: kTextFieldDecoration.copyWith(
                                labelText: 'Email Address',
                                hintText: 'Enter your Email Address',
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
//                               initialValue: u.state,
                              initialValue: "Gujarat",
                              keyboardType: TextInputType.text,
//                               validator: validateContactNo,
//                               onSaved: (value) => contactNo = value,
                              decoration: kTextFieldDecoration.copyWith(
                                labelText: 'State',
                                hintText: 'Enter your State',
                                prefixIcon: Icon(Icons.location_city),
                              ),
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  0.0, 10.0, 0.0, 5.0),
                              child: RaisedButton(
                                onPressed: () {},
                                color: Color(0xfffe8b0e),
                                textColor: Colors.white,
                                shape: kRoundedBorder,
                                child: Text('Update User Profile'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
