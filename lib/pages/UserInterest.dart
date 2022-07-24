import 'package:SportsAcademy/models/apiurl.dart';
import 'package:SportsAcademy/models/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:requests/requests.dart';

import '../constants.dart';

class UserInterest extends StatefulWidget {
  @override
  _UserInterestState createState() => _UserInterestState();
}

class _UserInterestState extends State {
  apiurl u = apiurl();
  List<dynamic> names;
  dynamic output;

  // List<String> names = [
  //   "Cricket",
  //   "Football",
  //   "Badminton",
  //   "Vollyball",
  //   "Kho-kho",
  //   "Tannis",
  //   "Kabbadi",
  //   "Carrom",
  //   "Chess",
  //   "Baseball",
  // ];
  List<int> _selectedIndexList = List();
  String _selectedindexstring = "";
  bool _UserInterestMode = true;
  User user;

  @override
  void initState() {
    sportlist();
    setState(() {});
  }

  void _changeUserInterest({bool enable, int index}) {
    _UserInterestMode = enable;
    _selectedIndexList.add(index);
    if (index == -1) {
      _selectedIndexList.clear();
    }
  }

  void sportlist() async {
    try {
      print(names);
      var response = await Requests.get(u.getapi() + 'sport_name');
      response.raiseForStatus();
      if (response.statusCode == 200) {
        var userJson = response.json();

        if (!userJson["is_error"]) {
          names = userJson["data"];
          print(names);
          setState(() {});
        } else {
          Fluttertoast.showToast(
              msg: userJson["message"],
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: 'Unable to sign up. Please try again later',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void userInterest() async {
    print(user);
    for (int i = 0; i < _selectedIndexList.length; i++) {
      if (i == (_selectedIndexList.length - 1)) {
        _selectedindexstring += names[_selectedIndexList[i]]["_id"];
        continue;
      }
      _selectedindexstring += names[_selectedIndexList[i]]["_id"] + ",";
    }
    print(_selectedindexstring);

    try {
      // var response =  await Request.get(u.)
      user = await User.fromSharedPreference;
      //TO DO : replace api name with userinterest api
      var response = await Requests.post(u.getapi() + 'update_profile', json: {
        "token": user.token,
        "user_interest": _selectedindexstring,
      });
      response.raiseForStatus();
      if (response.statusCode == 200) {
        var userJson = response.json();
        // print(userJson);
        if (!userJson["is_error"]) {
          print(user);

          Navigator.pushReplacementNamed(context, "/manageScreen");
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
            msg: 'Unable to sign up. Please try again later',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: 'Network Error !!!',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    GridTile getGridTile(int index) {
      return GridTile(
          child: GestureDetector(
        child: new Card(
          color: _selectedIndexList.contains(index)
              ? Color(0xFFFE8B0E)
              : Colors.orangeAccent[200],
          child: Center(
            child: Text(
              names[index]["sport_name"],
              style: TextStyle(
                color: _selectedIndexList.contains(index)
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        onTap: () {
          setState(() {
            if (_UserInterestMode == false) {
              _changeUserInterest(enable: false, index: -1);
              _UserInterestMode = true;
            }

            // _changeUserInterest(enable: false, index: -1);
            if (_selectedIndexList.contains(index)) {
              _selectedIndexList.remove(index);
              print(_selectedIndexList);
            } else {
              _selectedIndexList.add(index);
              print(_selectedIndexList);
            }
          });
        },
      ));
    }

    if (names != null) {
      return Scaffold(
        // backgroundColor: Color(0xff2e3754),
        appBar: AppBar(
          title: Text("Select Your Interested Sports"),
        ),
        body: new GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 3,
          children:
              new List.generate((names != null) ? names.length : 0, (index) {
            return getGridTile(index);
          }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: userInterest,
          child: Icon(Icons.arrow_forward),
          backgroundColor: Color(0xFFFE8B0E),
        ),
      );
    } else {
      return Scaffold(
        // backgroundColor: Color(0xff2e3754),
        appBar: AppBar(
          title: Text("Select Your Interested Sports"),
        ),
        body: Container(child: CircularProgress),
      );
    }
  }
}
