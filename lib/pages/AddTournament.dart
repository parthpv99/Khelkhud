import 'package:SportsAcademy/models/sport.dart';
import 'package:SportsAcademy/models/tournament.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:requests/requests.dart';
import '../models/apiurl.dart';

class AddTournament extends StatefulWidget {
//-----------------Start----------Image Input-------------------------------
  @override
  _AddTournamentState createState() => _AddTournamentState();
}

class _AddTournamentState extends State<AddTournament> {
  List<Tournament> tournamentList = List<Tournament>();
  List<Tournament> historyList = List<Tournament>();
  List<Sport> sportList = List<Sport>();
  apiurl u = apiurl();

  @override
  void initState() {
    getUpcomingTournaments();
    getPreviousTournaments();
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
            // sports.add(sportList[i].name);
          }
          setState(() {
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

  void getPreviousTournaments() async {
    try {
      var response = await Requests.post(u.getapi() + 'tournament/history/');
      response.raiseForStatus();
      historyList.clear();
      if (response.statusCode == 200) {
        var historyJson = response.json();
        print(historyJson);
        if (!historyJson["is_error"]) {
          for (int i = 0; i < historyJson["count"]; i++) {
            historyList.add(Tournament.fromJson(historyJson["data"][i]));
            // sports.add(sportList[i].name);
          }
          setState(() {
            // print(historyList);
            // tournamentList.addAll(sportList);
            // sport.addAll(sportList);
          });
        } else {
          Fluttertoast.showToast(
              msg: historyJson["message"],
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

  void getUpcomingTournaments() async {
    try {
      var response = await Requests.post(u.getapi() + 'tournament/upcoming/');
      response.raiseForStatus();
      tournamentList.clear();
      if (response.statusCode == 200) {
        var tournamentJson = response.json();
        // print(tournamentJson);
        if (!tournamentJson["is_error"]) {
          for (int i = 0; i < tournamentJson["count"]; i++) {
            tournamentList.add(Tournament.fromJson(tournamentJson["data"][i]));
            // sports.add(sportList[i].name);
          }
          setState(() {
            print(tournamentList);
            // tournamentList.addAll(sportList);
            // sport.addAll(sportList);
          });
        } else {
          Fluttertoast.showToast(
              msg: tournamentJson["message"],
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

  Card firstRow(String imgVal, double C_width, double C_height, String id) {
    return Card(
      elevation: 10.0,
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/Tourny_details', arguments: id);
        },
        child: Container(
          width: C_width,
          height: C_height,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(imgVal),
            ),
            borderRadius: BorderRadius.circular(5),
//          color: Colors.deepPurpleAccent[coL],
          ),
        ),
      ),
    );
  }

  Card myText(String strs) {
    return Card(
//      color: Colors.teal[900], //Light,
//                margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 10.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                strs,
                style: TextStyle(
                  fontFamily: 'SourceSansPro',
                  fontSize: 15.0,
//                  color: Colors.white,
                ),
              ),
              FlatButton(
//                color: Colors.teal[600],
                child: Text(
                  'Explore All',
                  style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontSize: 15.0,
//                    color: Colors.white,
                  ),
                ),
                onPressed: () {},
              ),
            ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
//            mainAxisAlignment: MainAxisAlignment.start,
//            mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          myText('Tournaments'),

//------------------------------------Listview.seperated()----------------------
          Card(
//            color: Colors.teal[900],
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              height: 150,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
//                      padding: const EdgeInsets.all(8),
                  itemCount: tournamentList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        children: <Widget>[
                          firstRow(tournamentList[index].photo + "?v=1", 100,
                              90, tournamentList[index].id),
                          Text(tournamentList[index].name),
                        ],
                      ),
                    );
//                      firstRow(tournamentLink[index], 100, 70);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    thickness: 40.0,
                    height: 20.0,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
// ---------------------------Listview.seperated()------------------------------
//-----------------------------------------------Start-----Tournament History----------------------------------------------------------------------
          myText('Tournaments History'),

          Card(
//            color: Colors.teal[900],
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              height: 170,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
//                  padding: const EdgeInsets.all(8),
                  itemCount: historyList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Column(
                        children: <Widget>[
                          firstRow(historyList[index].photo + "?v=1", 100, 100,
                              historyList[index].id),
                          Text(historyList[index].name),
                        ],
                      ),
                    );
//                      firstRow(tournamentList[index][0], 100, 70);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(
                    thickness: 40.0,
                    height: 20.0,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
//--------------------------------------------End--------Tournament History----------------------------------------------------------------------

//--------------------------------------------Start--------Tournament By Sports----------------------------------------------------------------------
          myText('Tournaments By Sports'),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 25.0,
              vertical: 10.0,
            ),
            child: Container(
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: sportList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.3,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 20.0,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    height: 180,
                    child: Column(
                      children: <Widget>[
                        firstRow(sportList[index].image1, 140, 50,
                            sportList[index].id),
                        //  Text(tournamentList[index][1]),
                      ],
                    ),
                  );
//                    firstRow(tournamentList[index], 140, 70);
                },
              ),
            ),
          ),
//------------------------------------------End----------Tournament By Sports----------------------------------------------------------------------
        ],
      ),
    );
  }
}
