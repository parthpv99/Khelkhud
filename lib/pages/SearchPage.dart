import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:requests/requests.dart';
import '../constants.dart';
import '../widgets/text_title.dart';
import '../widgets/sport_card.dart';
import '../widgets/Spinner.dart';
import '../models/sport.dart';
import '../models/apiurl.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  // with AutomaticKeepAliveClientMixin<SearchPage> {
  // @override
  // bool get wantKeepAlive => true;
  TextEditingController textEditingController = TextEditingController();
  String searchString;
  // List<String> sport = List<String>();
  List<Sport> sportList = List<Sport>();
  List<Sport> topsportList = List<Sport>();
  List<String> tournamentList = List<String>();
  List<String> playlistList = List<String>();
  List<String> toptournamentList = List<String>();
  List<String> topplaylistList = List<String>();

  apiurl u = apiurl();
  bool _isSearching = false;
  // void searchData(String query) {
  //   List<String> sports = List<String>();
  //   sports.addAll(sportList);
  //   if (query.isNotEmpty) {
  //     List<String> result = List<String>();
  //     sports.forEach((element) {
  //       if (element.contains(query)) {
  //         result.add(element);
  //       }
  //     });
  //     setState(() {
  //       sport.clear();
  //       sport.addAll(result);
  //     });
  //     return;
  //   } else {
  //     setState(() {
  //       sport.clear();
  //       sport.addAll(sportList);
  //     });
  //   }
  // }

  void getTopSports() async {
    try {
      var response = await Requests.get(u.getapi() + 'home_page/topsport');
      response.raiseForStatus();
      sportList.clear();
      if (response.statusCode == 200) {
        var sportJson = response.json();
        if (!sportJson["is_error"]) {
          for (int i = 0; i < sportJson["sportdata_number"]; i++) {
            sportList.add(Sport.fromJson(sportJson["data"]["sportdata"][i]));
            // sports.add(sportList[i].name);
          }
          setState(() {
            topsportList.addAll(sportList);
            // sport.addAll(sportList);
          });
        } else {
          Fluttertoast.showToast(
              msg: sportJson["message"],
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void search() async {
    print(searchString);
    try {
      var response =
          await Requests.post(u.getapi() + 'home_page/search', json: {
        "searchstring": searchString,
      });
      response.raiseForStatus();
      sportList.clear();
      if (response.statusCode == 200) {
        var sportJson = response.json();
        print(sportJson);
        if (!sportJson["is_error"]) {
          for (int i = 0; i < sportJson["sportdata_number"]; i++) {
            sportList.add(Sport.fromJson(sportJson["data"]["sportsdata"][i]));
            // sports.add(sportList[i].name);
          }
          setState(() {
            if (sportList.isEmpty &&
                tournamentList.isEmpty &&
                playlistList.isEmpty) {
              sportList = topsportList;
              tournamentList = toptournamentList;
              playlistList = topplaylistList;
              _isSearching = false;
            } else {
              _isSearching = true;
            }
            // sport.addAll(sportList);
          });
        } else {
          Fluttertoast.showToast(
              msg: sportJson["message"],
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    getTopSports();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //Searchbar
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 9,
                      child: TextField(
                        onChanged: (value) {
                          searchString = value;
                        },
                        controller: textEditingController,
                        decoration: kSearchTextField,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                        icon: Icon(Icons.search),
                        onPressed: () {
                          setState(() {
                            _isSearching = true;
                          });
                          search();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              sportList.isEmpty &&
                      tournamentList.isEmpty &&
                      playlistList.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 10.0,
                      ),
                      child: Text(
                        'No Results Found.',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white38,
                        ),
                      ),
                    )
                  : Container(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  sportList.isEmpty
                      ? Container()
                      : TextTitle(
                          title: _isSearching ? 'Sports' : 'Top Sports',
                        ),
                  sportList.isEmpty
                      ? Container()
                      : Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25.0,
                            vertical: 10.0,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 25.0,
                                vertical: 10.0,
                              ),
                              child: SizedBox(
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: sportList.length,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 2.75,
                                    mainAxisSpacing: 10.0,
                                    crossAxisSpacing: 20.0,
                                  ),
                                  itemBuilder: (context, index) {
                                    return SportCard(
                                      id: sportList[index].id,
                                      title: sportList[index].name,
                                      image: sportList[index].image1,
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                  // TextTitle(
                  //   title: _isSearching ? 'Tournaments' : 'Top Tournaments',
                  // ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  //   child: Divider(
                  //     color: Colors.white,
                  //   ),
                  // ),
                  // //Todo: Tournament Card
                  // TextTitle(
                  //   title: _isSearching ? 'Playlists' : 'Top Playlists',
                  // ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
