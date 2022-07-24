import 'package:flutter/material.dart';
import '../widgets/text_title.dart';

class TournyRules extends StatefulWidget {
  String _id;
  TournyRules(this._id);
  @override
  _SportRulesState createState() => _SportRulesState();
}

class _SportRulesState extends State<TournyRules> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRvOFLtEwGW64B5fNsyFO8wzxOD7ZwqvMc7Zg&usqp=CAU',
                  fit: BoxFit.cover,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 2,
                margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              ),
              TextTitle(
                title: widget._id,
              ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
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
    );
  }
}
