import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class User {
  dynamic jsonString,
      id,
      state,
      dob,
      fname,
      lname,
      achievement,
      loginname,
      userinterest,
      city,
      token;
  User.fromJson(Map<dynamic, dynamic> json) {
    jsonString = jsonEncode(json);
    // id = json["user_id"];
    fname = json["data"]["fname"];
    lname = json["data"]["lname"];
    city = json["data"]["city"];
    dob = json["data"]["dob"];
    state = json["data"]["state"];
    loginname = json["data"]["login_name"];
    achievement = json["data"]["achievement"];
    token = json["token"];
    userinterest = json["data"]["user_interest"]; //comma sep.
  }

  static Future<User> get fromSharedPreference async {
    final sharedPreference = await SharedPreferences.getInstance();
    return User.fromJson(jsonDecode(sharedPreference.getString("user")));
  }

  void setPreference() async {
    final sharedPreference = await SharedPreferences.getInstance();
    sharedPreference.setString("user", jsonString);
  }

  // void removePreference() async {
  //   final sharedPreference = await SharedPreferences.getInstance();
  //   sharedPreference.remove("user");
  // }
}
