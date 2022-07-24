import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:requests/requests.dart';
import '../widgets/sport_card.dart';
import '../widgets/text_title.dart';
import '../constants.dart';
import '../models/apiurl.dart';
import '../models/sport.dart';
import '../widgets/Spinner.dart';

class SportList extends StatefulWidget {
  @override
  _SportListState createState() => _SportListState();
}

class _SportListState extends State<SportList>
    with AutomaticKeepAliveClientMixin<SportList> {
  @override
  bool get wantKeepAlive => true;
  TextEditingController textEditingController = TextEditingController();
  List<Sport> sport = List<Sport>();
  bool _isSearching = false;
  apiurl u = apiurl();
  List<String> sports = List<String>();
  List<Sport> sportList = [];
  // List<String> sportList = [
  //   'a',
  //   'b',
  //   'c',
  //   'd',
  //   'e',
  //   'f',
  //   'g',
  //   'h',
  //   'i',
  //   'j',
  //   'k'
  // ];

  @override
  void initState() {
    getAllSports();
    super.initState();
  }

  void getAllSports() async {
    try {
      var response = await Requests.get(u.getapi() + 'sport_name');
      response.raiseForStatus();
      sportList.clear();
      if (response.statusCode == 200) {
        var sportJson = response.json();
        if (!sportJson["is_error"]) {
          for (int i = 0; i < sportJson["count"]; i++) {
            sportList.add(Sport.fromJson(sportJson["data"][i]));
            sports.add(sportList[i].name);
          }
          setState(() {
            sport.addAll(sportList);
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

  void searchData(String query) {
    _isSearching = false;
    if (query.isNotEmpty) {
      _isSearching = true;
      List<String> result = List<String>();
      sports.forEach((element) {
        if (element.contains(query)) {
          result.add(element);
        }
      });
      setState(() {
        sport.clear();
        for (var sprt in sportList) {
          result.forEach((element) {
            if (element == sprt.name) {
              sport.add(sprt);
            }
          });
        }
      });
      return;
    } else {
      setState(() {
        sport.clear();
        sport.addAll(sportList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  onChanged: (value) => searchData(value),
                  controller: textEditingController,
                  decoration: kSearchTextField,
                ),
              ),
              _isSearching
                  ? Container()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextTitle(
                          title: 'Top Sports',
                        ),
                        // SizedBox(
                        //   height: 20.0,
                        // ),
                        sport.isEmpty
                            ? Spinner(
                                backgroundColor: Colors.white,
                                strokeWidth: 2.0,
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
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
                                      height: 175.0,
                                      child: GridView.builder(
                                        itemCount: sport.length,
                                        scrollDirection: Axis.horizontal,
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 50.0,
                                          mainAxisSpacing: 20.0,
                                          crossAxisSpacing: 10.0,
                                          childAspectRatio: 0.3,
                                        ),
                                        itemBuilder: (context, index) {
                                          return SportCard(
                                            title: sport[index].name,
                                            image: sport[index].image1,
                                            id: sport[index].id,
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
              // SizedBox(
              //   height: 10.0,
              // ),
              TextTitle(
                title: _isSearching ? 'Search Result' : 'All Sports',
              ),
              sport.isEmpty
                  ? Spinner(
                      backgroundColor: Colors.white,
                      strokeWidth: 2.0,
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
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
                          child: Container(
                            child: GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: sport.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2.75,
                                mainAxisSpacing: 10.0,
                                crossAxisSpacing: 20.0,
                              ),
                              itemBuilder: (context, index) {
                                return SportCard(
                                  title: sport[index].name,
                                  image: sport[index].image1,
                                  id: sport[index].id,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
