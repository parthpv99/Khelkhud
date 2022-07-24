import 'package:SportsAcademy/models/apiurl.dart';
import 'package:SportsAcademy/models/user.dart';
import 'package:flutter/material.dart';
import 'package:requests/requests.dart';

/// This Widge

// stores ExpansionPanel state information
class Item {
  Item({
//    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

//  String expandedValue;
  dynamic headerValue;
  bool isExpanded;
}

List<Item> generateItems(int no, dynamic title) {
  return List.generate(no, (int index) {
    return Item(
      headerValue: title,
      // expandedValue: 'Description555',
    );
  });
}

class Expansion extends StatefulWidget {
  dynamic videotitle,
      video_id,
      video_desc,
      video_views,
      video_tutor,
      playlistid;
  bool isplaylistbookmarked;
  bool iswatchlater;
  Expansion(
      {@required this.videotitle,
      @required this.video_desc,
      @required this.video_views,
      @required this.video_tutor,
      @required this.isplaylistbookmarked,
      @required this.playlistid,
      @required this.video_id,
      @required this.iswatchlater});

  @override
  _ExpansionState createState() => _ExpansionState();
}

class _ExpansionState extends State<Expansion> {
  String passedtitle;
  List<Item> _data;
  bool playlist = false;
  bool icon_change;

  bool icon_watch;

  apiurl u = new apiurl();
  User user;
  void isplaylistbookmark() async {
    try {
      user = await User.fromSharedPreference;
      var response =
          await Requests.post(u.getapi() + 'home_page/subscriber', json: {
        "token": user.token,
        "playlist_id": widget.playlistid,
      });
      response.raiseForStatus();
      if (response.statusCode == 200) {
        var userJson = response.json();

        if (!userJson["is_error"]) {
//          print(userJson["message"]);
//          print('--------------------------------------------');
        }
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  void isvideowatchlater() async {
    try {
      user = await User.fromSharedPreference;
      var response =
          await Requests.post(u.getapi() + 'videos/add_watch_later', json: {
        "token": user.token,
        "playlist_id": widget.playlistid,
        "video_id": widget.video_id,
      });
      response.raiseForStatus();
      if (response.statusCode == 200) {
        var userJson = response.json();

        if (!userJson["is_error"]) {
          print(userJson["message"]);
          print('--------------------------------------------');
        }
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    print(widget.videotitle);
    passedtitle = widget.videotitle;
    _data = generateItems(1, passedtitle);
    icon_change = widget.isplaylistbookmarked;
    icon_watch = !widget.iswatchlater;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // physics: ScrollPhysics(),
      child: Card(
        child: Container(
          child: _buildPanel(),
        ),
      ),
    );
  }

  Widget _buildPanel() {
    return Container(
      child: ExpansionPanelList(
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _data[index].isExpanded = !isExpanded;
          });
        },
        children: _data.map<ExpansionPanel>((Item item) {
          return ExpansionPanel(
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(item.headerValue),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 3,
                    ),
                    Text("by " + widget.video_tutor),
                    SizedBox(
                      height: 3,
                    ),
                    Text(widget.video_views.toString() + " views"),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
                trailing: Wrap(
                  spacing: 0,
                  children: <Widget>[
                    new IconButton(
                      icon: icon_change
                          ? Icon(
                              Icons.playlist_add_check,
                              color: Color(0xFFFE8B0E),
                            )
                          : Icon(Icons.playlist_add),
                      onPressed: () {
                        isplaylistbookmark();
                        setState(() {
                          icon_change = !icon_change;
                        });
                      }, //TODO : on Tap
                    ),
                    new IconButton(
                      icon: icon_watch
                          ? Icon(Icons.library_add)
                          : Icon(
                              Icons.check,
                              color: Color(0xFFFE8B0E),
                            ),

                      onPressed: () {
//                        print("clickde");
                        isvideowatchlater();
                        setState(() {
                          icon_watch = !icon_watch;
                        });
                      }, //TODO : on TAP
                    ),
                  ],
                ),
              );
            },
            body: ListTile(
//              title: Text(item.expandedValue),
              subtitle: Text(widget.video_desc),
            ),
            isExpanded: item.isExpanded,
          );
        }).toList(),
      ),
    );
  }
}
