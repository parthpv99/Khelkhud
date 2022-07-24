import 'package:flutter/material.dart';
import '../pages/SearchPage.dart';
import '../pages/SportRules.dart';
import '../pages/Tourny_rules.dart';

class TournyDetails extends StatefulWidget {
  @override
  _SportDetailsState createState() => _SportDetailsState();
}

class _SportDetailsState extends State<TournyDetails> {
  @override
  Widget build(BuildContext context) {
    String id = ModalRoute.of(context).settings.arguments;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tournament Details'),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(text: 'About'),
              Tab(text: 'Rules'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            TournyRules(id),
            TournyRules(id),
          ],
        ),
      ),
    );
  }
}
