import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:requests/requests.dart';
import '../widgets/Spinner.dart';
import '../widgets/data_field.dart';
import '../models/Coach.dart';
import '../models/apiurl.dart';
import '../models/sport.dart';
import '../widgets/sport_card.dart';

class CoachDetails extends StatefulWidget {
  final String _id;
  CoachDetails(this._id);
  @override
  _CoachDetailsState createState() => _CoachDetailsState();
}

class _CoachDetailsState extends State<CoachDetails>
    with AutomaticKeepAliveClientMixin<CoachDetails> {
  @override
  bool get wantKeepAlive => true;
  apiurl u = apiurl();
  Coach coach;
  List<Sport> interst = List<Sport>();

  void getCoachDetails() async {
    print(widget._id);
    try {
      var response = await Requests.post(
        u.getapi() + 'coach/coachdetails',
        json: {"coach_id": widget._id},
      );
      response.raiseForStatus();

      if (response.statusCode == 200) {
        var coachJson = response.json();
        print(coachJson);
        if (!coachJson["is_error"]) {
          coach = Coach.fromJson(coachJson["data"]);
          for (int i = 0; i < coachJson["count"]; i++) {
            interst.add(Sport.fromJson(coachJson["data"]["user_interest"][i]));
          }
          setState(() {});
        } else {
          Fluttertoast.showToast(
            msg: coachJson["message"],
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
    getCoachDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: coach == null
            ? Center(
                child: Spinner(
                  backgroundColor: Colors.white,
                  strokeWidth: 2.0,
                ),
              )
            : CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    expandedHeight: 200.0,
                    floating: false,
                    pinned: true,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Container(
                        color: Colors.black38,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 4.0,
                          ),
                          child: Text(
                            coach.fname + ' ' + coach.lname,
                            style: TextStyle(
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  blurRadius: 2.0,
                                  color: Colors.black38,
                                  offset: Offset(0.5, 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      background: Image.network(
                        coach.photo,
                        fit: BoxFit.cover,
                        colorBlendMode: BlendMode.srcATop,
                      ),
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: true,
                    fillOverscroll: true,
                    child: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: InkWell(
                                    onTap: () {},
                                    child: Row(
                                      children: <Widget>[
                                        Icon(Icons.trending_up),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(coach.upvote.toString()),
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: FlatButton(
                                    onPressed: () {},
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.call),
                                        SizedBox(
                                          width: 15.0,
                                        ),
                                        Text('+91 ' + coach.mobile),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            Text(
                              coach.description,
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            DataField(
                              field: 'Achievements',
                              data: coach.achievement ?? 'No Achievements',
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            DataField(
                              field: 'Location',
                              data: coach.place +
                                  ', ' +
                                  coach.city +
                                  ', ' +
                                  coach.state,
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            DataField(
                              field: 'Joinned Since',
                              data: DateTime.now()
                                          .difference(
                                              DateTime.parse(coach.dateJoined))
                                          .inDays >
                                      30
                                  ? DateTime.now().month -
                                              DateTime.parse(coach.dateJoined)
                                                  .month >
                                          12
                                      ? (DateTime.now().year -
                                                  DateTime.parse(coach.dateJoined)
                                                      .year)
                                              .toString() +
                                          ' years'
                                      : (DateTime.now().month -
                                                  DateTime.parse(coach.dateJoined)
                                                      .month)
                                              .toString() +
                                          ' months'
                                  : DateTime.now()
                                          .difference(DateTime.parse(coach.dateJoined))
                                          .inDays
                                          .toString() +
                                      ' days',
                            ),
                            SizedBox(
                              height: 8.0,
                            ),
                            DataField(
                              field: 'Age',
                              data: (DateTime.now().year -
                                          int.parse(coach.dob.substring(6, 10)))
                                      .toString() +
                                  ' years',
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              'Other Interests:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            SizedBox(
                              height: 100.0,
                              child: ListView.builder(
                                // shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: interst.length,
                                itemBuilder: (context, index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SportCard(
                                      image: interst[index].image1,
                                      title: interst[index].name,
                                      id: interst[index].id),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ));
  }
}
