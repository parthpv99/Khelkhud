import 'package:SportsAcademy/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';
import 'HomeScreen.dart';
import 'MyPlaylist.dart';
import 'SearchPage.dart';
import 'SportList.dart';
import 'AddTournament.dart';
import 'package:flutter/material.dart';
import 'addTourny.dart';
import 'UseProfile.dart';
// import 'transaction_screen.dart';

class ManageScreen extends StatefulWidget {
  @override
  _ManageScreenState createState() => _ManageScreenState();
}

class _ManageScreenState extends State<ManageScreen> {
  // void logout() async {
  //   final sharedPreference = await SharedPreferences.getInstance();
  //   sharedPreference.remove("user");
  //   // user = await User.fromSharedPreference;
  //   Navigator.pushReplacementNamed(context, '/');
  // }

  int _selectedIndex = 0;
  final _pageList = [
    HomeScreen(),
    SearchPage(),
    MyPlaylist(),
    SportList(),
    AddTournament(),
  ];

  final List<String> _appBarList = [
    'Home',
    'Search',
    'My Playlist',
    'SportDetails',
    'Add Tournament',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  // // Logout

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            _appBarList[_selectedIndex],
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/userProfile');
              },
              icon: Icon(Icons.person),
            ),
            // FlatButton(onPressed: logout, child: Text("Logout")),
          ],
        ),
        // backgroundColor: Color(0xff2E3754),
        //TODO : Center widget exisst here
        body: _pageList.elementAt(_selectedIndex),
        floatingActionButton: (_selectedIndex == 4)
            ? FloatingActionButton(
                child: Icon(Icons.add),
                backgroundColor: Colors.redAccent,
                onPressed: () {
                  if (_selectedIndex == 4) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddTourny())).then((value) {
                      setState(() {});
                    });
                  }
                },
              )
            : null,
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xff2E3754),
          ),
          child: BottomNavigationBar(
//            backgroundColor: Color(0xFFFE8B0E),
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text('Search'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.play_circle_outline),
                title: Text('My Playlist'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.games),
                title: Text('Rules'),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.control_point),
                title: Text('Tournament'),
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Color(0xFFFE8B0E),
            unselectedItemColor: Colors.white,
            onTap: _onItemTapped,
          ),
        ));
  }
}

//HomeScreen
//SearchPage
//AddTournament
//SportDetails
//UseProfile
