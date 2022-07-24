import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:requests/requests.dart';
import '../widgets/Spinner.dart';
import '../widgets/text_title.dart';
import '../widgets/coach_card.dart';
import '../models/apiurl.dart';
import '../models/Coach.dart';

class CoachListBySport extends StatefulWidget {
  final String id;
  CoachListBySport(this.id);
  @override
  _CoachListBySportState createState() => _CoachListBySportState();
}

class _CoachListBySportState extends State<CoachListBySport>
    with AutomaticKeepAliveClientMixin<CoachListBySport> {
  @override
  bool get wantKeepAlive => true;

  List<Coach> coachList = List<Coach>();
  apiurl u = apiurl();

  void getCoaches() async {
    try {
      print(widget.id);
      var response = await Requests.post(
        u.getapi() + 'coach/getcoach',
        json: {
          "sport_id": widget.id,
        },
      );
      response.raiseForStatus();

      coachList.clear();
      if (response.statusCode == 200) {
        var coachJson = response.json();
        print(coachJson);
        if (!coachJson["is_error"]) {
          for (int i = 0; i < coachJson["count"]; i++) {
            coachList.add(Coach.fromJson(coachJson["data"][i]));
            // sports.add(sportList[i].name);
          }
          setState(() {
            // sport.addAll(sportList);
          });
        } else {
          Fluttertoast.showToast(
              msg: coachJson["message"],
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
        fontSize: 16.0,
      );
    }
  }

  @override
  void initState() {
    getCoaches();
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
              TextTitle(
                title: 'Coach List',
              ),
              coachList.isEmpty
                  ? Center(
                      child: Spinner(
                        backgroundColor: Colors.white,
                        strokeWidth: 2.0,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: coachList.length,
                      itemBuilder: (context, index) {
                        String coachname = coachList[index].fname +
                            ' ' +
                            coachList[index].lname;
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 25.0, vertical: 5.0),
                          child: CoachCard(
                            id: coachList[index].id,
                            name: coachname,
                            photo: coachList[index].photo,
                            place: coachList[index].place,
                            upvote: coachList[index].upvote,
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
