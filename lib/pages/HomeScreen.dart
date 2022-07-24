import 'package:SportsAcademy/models/apiurl.dart';
import 'package:SportsAcademy/models/user.dart';
import 'package:SportsAcademy/pages/PlaylistScreen.dart';
import 'package:SportsAcademy/widgets/playlistCard.dart';
import 'package:SportsAcademy/widgets/sport_card.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:requests/requests.dart';

import '../constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin<HomeScreen> {
  @override
  bool get wantKeepAlive => true;

  apiurl u = new apiurl();

  @override
  void initState() {
    sportlist();
    gettingUserinterestedsports();
  }

  List<dynamic> categories;
  void sportlist() async {
    try {
      // print(categories);
      var response = await Requests.get(u.getapi() + 'sport_name');
      response.raiseForStatus();
      if (response.statusCode == 200) {
        var userJson = response.json();

        if (!userJson["is_error"]) {
          categories = userJson["data"];
          // print(categories);
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
      // print(e);
    }
  }

  //Getting user interested sport playlist
  User user;
  var interestedsports1;
  void gettingUserinterestedsports() async {
    // print(user);
    try {
      user = await User.fromSharedPreference;
      var response = await Requests.post(u.getapi() + 'home_page/',
          json: {"token": user.token});
      response.raiseForStatus();

      if (response.statusCode == 200) {
        var userJson = response.json();
        // print(userJson);
        if (!userJson["is_error"]) {
          interestedsports1 = userJson["data"];
          // print(interestedsports1);
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
      // print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (interestedsports1 == null || categories == null) {
      return Container(child: CircularProgress);
    } else {
      return ListView.builder(
          shrinkWrap: true,
          itemCount:
              (interestedsports1 == null) ? 0 : interestedsports1.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Categories",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // print(ca[index - 1]["name"]);
                              //TO DO : See all categories
                            },
                            child: Text("SEE ALL"),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                        height: 120,
                        child: GridView.count(
                          crossAxisCount: 2,
                          scrollDirection: Axis.horizontal,
                          childAspectRatio: 0.29,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          children: List.generate(
                              (categories != null) ? categories.length : 0,
                              (index) {
                            return SportCard(
                              image: categories[index]["sport_image1"],
                              id: categories[index]["_id"],
                              title: categories[index]["sport_name"],
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Playlist of " +
                                  interestedsports1[index - 1]["sport_name"],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              //TODO : Return playlist_id nad navigate to the playlist view
                              print(interestedsports1[index - 1]["sport_name"]);
                              // Navigator.pushNamed(context, '/playlistScreen');
                            },
                            child: Text("SEE ALL"),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                      child: Container(
                        height: 200,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: (interestedsports1[index - 1]["playlist"]
                                      .length <=
                                  6)
                              ? interestedsports1[index - 1]["playlist"]
                                      .length +
                                  1
                              : 7,
                          itemBuilder: (context, videoindex) {
                            if (videoindex == 6 ||
                                videoindex ==
                                    interestedsports1[index - 1]["playlist"]
                                        .length) {
                              return Card(
                                child: Container(
                                  width: 150,
                                  height: 130,
                                  child: Center(
                                      child: FlatButton(
                                          onPressed: () {
                                            print("ON click");
                                          },
                                          child: Icon(
                                            Icons.arrow_forward,
                                            size: 30,
                                            color:
                                                Theme.of(context).accentColor,
                                          ))
                                      // Icon(
                                      //   Icons.arrow_forward,
                                      //   color: Theme.of(context).accentColor,
                                      // ),
                                      ),
                                ),
                              );
                            } else {
                              return PlaylistCard(
                                  sportid: interestedsports1[index - 1]
                                      ["sport_id"][videoindex],
                                  playlistid: interestedsports1[index - 1]
                                      ["playlist_id"][videoindex],
                                  thumnail: interestedsports1[index - 1]
                                      ["thumnail"][videoindex],
                                  title: interestedsports1[index - 1]["title"]
                                      [videoindex]);
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          });
    }
  }

//  @override
//  // TODO: implement wantKeepAlive
//  bool get wantKeepAlive => throw UnimplementedError();
}
