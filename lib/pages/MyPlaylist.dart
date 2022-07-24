import 'dart:math';

import 'package:SportsAcademy/models/apiurl.dart';
import 'package:SportsAcademy/models/user.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';

import '../constants.dart';
import 'PlaylistScreen.dart';

class MyPlaylist extends StatefulWidget {
//  _fetchEntry(int index) async {
//    await Future.delayed(Duration(milliseconds: 500));
//    return {'name': 'product $index', 'price': Random().nextInt(100)};
//  }

  @override
  _MyPlaylistState createState() => _MyPlaylistState();
}

class _MyPlaylistState extends State<MyPlaylist> {
  dynamic mybookmarkedplaylist;

  apiurl u = new apiurl();
  User user;
  bool rep = false;

  void fetchmyplaylist() async {
    user = await User.fromSharedPreference;
    try {
      var response =
          await Requests.post(u.getapi() + 'home_page/countsub', json: {
        "token": user.token,
      });
      response.raiseForStatus();

      if (response.statusCode == 200) {
        var userJson = response.json();

        if (!userJson["is_error"]) {
          mybookmarkedplaylist = userJson["data"];
          print(userJson["message"]);
          print('+++++++++++++++++++++++++++++++++++++++');
          print(mybookmarkedplaylist);
          setState(() {});

//          print(mybookmarkedplaylist);
        }
      }
      rep = true;
      setState(() {});
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchmyplaylist();
  }

  @override
  Widget build(BuildContext context) {
    if (rep == false) {
      return Container(child: CircularProgress);
    } else if (mybookmarkedplaylist.length == 0) {
      return SafeArea(
          child: Container(child: Center(child: Text("Add Playlist"))));
    } else {
      return SafeArea(
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: mybookmarkedplaylist.length,
            itemBuilder: (context, index) {
              return InkWell(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 43,
                          child: Container(
                            height: 100,
//                        width: 100,
                            child: Image.network(
                              mybookmarkedplaylist[index]["playlistdetails"][0]
                                  ["playlist_thumbnail"],
                              // "https://storage.googleapis.com/sports_digi_school_assets/sport/5f08989f1c62041de451ca71/5f0c912ace0b5033d82f1274/thumbnails/5f0c912ace0b5033d82f1274.jpg",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          flex: 57,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, left: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  mybookmarkedplaylist[index]["playlistdetails"]
                                          [0]["playlist_name"]
                                      .trim(),
                                  // 'Hello',
                                  style: kTextCardTitle,
                                ),
                                Text(
                                  // 'Hello',
                                  mybookmarkedplaylist[index]["playlistdetails"]
                                          [0]["playlist_desc"]
                                      .trim(),
                                  style: kvideocard_descripation,
                                ),
                                Text(
                                  "By " +
                                      mybookmarkedplaylist[index]
                                                  ["playlistdetails"][0]
                                              ["tutor_name"]
                                          .trim(),
                                  style: kvideocard_descripation,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PlaylistScreen(
                            sportid: mybookmarkedplaylist[index]
                                ["playlistdetails"][0]["sport_id"],
                            playlistid: mybookmarkedplaylist[index]
                                ["playlist_id"],
                            playlisttitle: mybookmarkedplaylist[index]
                                ["playlistdetails"][0]["playlist_name"],
                          )));
                  //
                },
              );
            }),
      );
    }
  }
}
