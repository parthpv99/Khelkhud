import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:requests/requests.dart';
import '../widgets/text_title.dart';
import '../models/sport.dart';
import '../models/apiurl.dart';
import '../widgets/Spinner.dart';

class SportOverview extends StatefulWidget {
  final String _id;
  SportOverview(this._id);
  @override
  _SportOverviewState createState() => _SportOverviewState();
}

class _SportOverviewState extends State<SportOverview>
    with AutomaticKeepAliveClientMixin<SportOverview> {
  @override
  bool get wantKeepAlive => true;

  Sport sport;
  apiurl u = apiurl();
  void getSportDetails() async {
    try {
      var response = await Requests.post(
        u.getapi() + 'sport_info',
        json: {"sport_id": widget._id},
      );
      response.raiseForStatus();

      if (response.statusCode == 200) {
        var sportJson = response.json();

        if (!sportJson["is_error"]) {
          sport = Sport.fromJson(sportJson["data"]);
          setState(() {});
        } else {
          Fluttertoast.showToast(
            msg: sportJson["message"],
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      }
    } on Exception catch (e) {
      Fluttertoast.showToast(
        msg: e.toString(),
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  void initState() {
    getSportDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: sport == null
          ? Center(
              child: Spinner(
                backgroundColor: Colors.white,
                strokeWidth: 2.0,
              ),
            )
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(sport.name),
                    background: Image.network(
                      sport.image1,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  fillOverscroll: true,
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: <Widget>[
                          // Card(
                          //   semanticContainer: true,
                          //   clipBehavior: Clip.antiAliasWithSaveLayer,
                          //   child: Image.network(
                          //     sport.image1,
                          //     fit: BoxFit.cover,
                          //   ),
                          //   shape: RoundedRectangleBorder(
                          //     borderRadius: BorderRadius.circular(10.0),
                          //   ),
                          //   elevation: 2,
                          //   margin: EdgeInsets.symmetric(
                          //       horizontal: 20.0, vertical: 15.0),
                          // ),
                          // TextTitle(
                          //   title: sport.name,
                          // ),
                          // SizedBox(
                          //   height: 10.0,
                          // ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              sport.description,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextTitle(
                            title: 'How to play?',
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              sport.howtoplay,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextTitle(
                            title: 'Game Rules',
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              sport.rules,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextTitle(
                            title: 'Equipments',
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              sport.equipment,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextTitle(
                            title: 'Sport Type',
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              sport.type,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          TextTitle(
                            title: 'Dimensions',
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              sport.dimensions,
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
      //
    );
  }
}
