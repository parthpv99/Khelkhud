import 'package:flutter/material.dart';
import '../pages/SportOverview.dart';
import '../pages/CoachListBySport.dart';

class SportDetails extends StatefulWidget {
  @override
  _SportDetailsState createState() => _SportDetailsState();
}

class _SportDetailsState extends State<SportDetails> {
  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Sport Details'),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'Overview'),
              Tab(text: 'Playlist'),
              Tab(text: 'Tournaments'),
              Tab(text: 'Coach'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SportOverview(id),
            SportOverview(id),
            SportOverview(id),
            CoachListBySport(id),
          ],
        ),
      ),
    );
  }
}
