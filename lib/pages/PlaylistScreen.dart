import 'package:SportsAcademy/models/apiurl.dart';
import 'package:SportsAcademy/pages/VideoPlayerScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:requests/requests.dart';

import '../constants.dart';

class PlaylistScreen extends StatefulWidget {
  dynamic playlistid, sportid, playlisttitle;

  PlaylistScreen(
      {@required this.sportid,
      @required this.playlistid,
      @required this.playlisttitle});

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  void initState() {
    fetchplaylist();
  }

  apiurl u = new apiurl();

  dynamic playlist;

  void fetchplaylist() async {
    try {
      var response = await Requests.post(
          u.getapi() + 'home_page/fetch_playlist/',
          json: {"sport_id": widget.sportid, "playlist_id": widget.playlistid});
      response.raiseForStatus();
      print(response.json());
      if (response.statusCode == 200) {
        var userJson = response.json();

        if (!userJson["is_error"]) {
          playlist = userJson["data"];
          // print(names);
          setState(() {});
        } else {
          print("in else");
        }
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: 'Network Error!!!',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (playlist == null) {
      return Scaffold(
          body: SafeArea(child: Container(child: CircularProgress)));
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.playlisttitle,
          ),
        ),
        body: SafeArea(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: playlist["playlist_video"].length,
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
                                playlist["playlist_video"][index]
                                    ["video_thumbnail"],
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
                                    playlist["playlist_video"][index]
                                            ["video_desc"]
                                        .trim(),
                                    style: kTextCardTitle,
                                  ),
                                  Text(
                                    "By " + playlist["tutor_name"].trim(),
                                    style: kvideocard_descripation,
                                  ),
                                  Text(
                                    playlist["playlist_video"][index]
                                                ["video_view"]
                                            .toString() +
                                        " Views",
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
                    // print('tapped...');
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => VideoPlayerScreen(
                            playlistjson: playlist, videoindex: index)));
                  },
                );
              }),
        ),
      );
    }
  }
}
