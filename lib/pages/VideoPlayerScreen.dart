import 'package:SportsAcademy/models/apiurl.dart';
import 'package:SportsAcademy/models/user.dart';
import 'package:requests/requests.dart';

import '../constants.dart';
import '../widgets/expansion.dart';

import '../widgets/custom_orientation_player/custom_orientation_player.dart';
import 'package:flutter/material.dart';

class VideoPlayerScreen extends StatefulWidget {
  dynamic playlistjson, videoindex;
  VideoPlayerScreen({@required this.playlistjson, @required this.videoindex});

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  apiurl u = new apiurl();
  User user;
  bool isbookmarked = false;
  bool getdatatransfer = false;
  bool iswatchlater = false;
  void increview() async {
    try {
      user = await User.fromSharedPreference;
      var response =
          await Requests.post(u.getapi() + 'videos/videocount', json: {
        "token": user.token,
        "playlist_id": widget.playlistjson["_id"],
        "video_id": widget.playlistjson["playlist_video"][widget.videoindex]
            ["video_id"]
      });
      response.raiseForStatus();
      if (response.statusCode == 200) {
        var userJson = response.json();

        if (!userJson["is_error"]) {
          isbookmarked = userJson["is_active"];
          iswatchlater = userJson["watch_video"];
          print(iswatchlater);
          print(isbookmarked);
//          setState(() {});
        }
      }
    } on Exception catch (e) {
      print(e);
    }
    getdatatransfer = true;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    increview();
  }

  @override
  Widget build(BuildContext context) {
    if (getdatatransfer == false) {
      return Scaffold(body: SafeArea(child: Center(child: CircularProgress)));
    } else {
      return Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,

              children: <Widget>[
                SizedBox(
//              flex: 30,
                  height: 200,
                  child: CustomOrientationPlayer(
                      playlistjson: widget.playlistjson,
                      videoindex: widget.videoindex), //url
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.playlistjson["playlist_video"].length +
                          1, //TODO:total size of playlist
                      itemBuilder: (context, index) {
                        if (index == 0) {
//                      return Container(child: Text("Hey..."));
                          return Expansion(
                              videotitle: widget.playlistjson["playlist_video"]
                                  [widget.videoindex]["video_desc"],
                              video_desc: widget.playlistjson["playlist_video"]
                                  [widget.videoindex]["video_desc"],
                              video_views: widget.playlistjson["playlist_video"]
                                  [widget.videoindex]["video_view"],
                              video_tutor: widget.playlistjson["tutor_name"],
                              isplaylistbookmarked: isbookmarked,
                              iswatchlater: iswatchlater,
                              video_id: widget.playlistjson["playlist_video"]
                                  [widget.videoindex]["video_id"],
                              playlistid: widget.playlistjson["_id"]);
                        } else {
                          return GestureDetector(
                            child: Card(
                              color: ((index - 1) == widget.videoindex)
                                  ? Colors.grey[400] //continue video
                                  : (((index - 1) < widget.videoindex)
                                      ? Colors.grey[700] //already seen video
                                      : Color(0xff2E3754)),
                              //TODO: colors setting
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
                                          widget.playlistjson["playlist_video"]
                                              [index - 1]["video_thumbnail"],
//                                        "assets/football.jpg",
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      flex: 57,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            widget
                                                .playlistjson["playlist_video"]
                                                    [index - 1]["video_desc"]
                                                .trim(),
                                            style: kTextCardTitle,
                                          ),
                                          Text(
                                            "By " +
                                                widget
                                                    .playlistjson["tutor_name"]
                                                    .trim(),
                                            style: kvideocard_descripation,
                                          ),
                                          Text(
                                            widget.playlistjson[
                                                        "playlist_video"]
                                                        [index - 1]
                                                        ["video_view"]
                                                    .toString() +
                                                " Views",
                                            style: kvideocard_descripation,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
//                            print('tapped...');
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => VideoPlayerScreen(
                                          playlistjson: widget.playlistjson,
                                          videoindex: index - 1)));
                            },
                          );
                        }
                      }),
                ),
                // CustomOrientationPlayer(),
                // Container(child: Expansion()),
                // Container(child: BodyLayout()),
              ],
            ),
          ),
        ),
      );
    }
  }
}
