import 'pages/MyPlaylist.dart';
import 'pages/Tourny_details.dart';
import 'pages/addTourny.dart';

import 'pages/VideoPlayerScreen.dart';

import 'pages/UserInterest.dart';

import 'pages/AddTournament.dart';
import 'pages/ManageScreen.dart';
import 'package:flutter/material.dart';
import 'pages/LoginScreen.dart';
import 'pages/SignUpScreen.dart';
import 'pages/ForgotPasswordScreen.dart';
import 'pages/HomeScreen.dart';
import 'pages/UseProfile.dart';
import 'pages/SearchPage.dart';
import 'pages/SportDetails.dart';
import 'pages/SportList.dart';
import 'pages/PlaylistScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        cardColor: Color(0xff363D54),
        scaffoldBackgroundColor: Color(0xff2E3754),
        appBarTheme: AppBarTheme(
          elevation: 0,
        ),
        primaryColor: Color(0xff2E3754),
        accentColor: Color(0xFFFE8B0E),
      ),
      // home: MyHomePage(title: 'Flutter Demo Home Page'),

      initialRoute: '/',
      routes: {
//        'sessioncheck': (context) => SessionCheck(),
        '/': (context) => LoginScreen(),
        '/signUpScreen': (content) => SignUpScreen(),
        '/forgotPasswordScreen': (context) => ForgotPasswordScreen(),
        '/homeScreen': (context) => HomeScreen(),
        '/manageScreen': (context) => ManageScreen(), //manageScreen
        '/searchScreen': (context) => SearchPage(),
        '/addTournament': (context) => AddTournament(),
        // '/sportsRules': (context) => SportsRules(),
        '/userProfile': (context) => UseProfile(),
        '/userinterest': (context) => UserInterest(),
        '/sportList': (context) => SportList(),
        '/sportDetails': (context) => SportDetails(),
        '/playlistScreen': (context) => PlaylistScreen(),
        '/videoPlayerScreen': (context) => VideoPlayerScreen(),
        '/myPlaylist': (context) => MyPlaylist(),
        '/addTourny': (context) => AddTourny(),
        '/Tourny_details': (context) => TournyDetails(),
      },
    );
  }
}
