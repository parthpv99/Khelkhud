import 'package:SportsAcademy/pages/PlaylistScreen.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class PlaylistCard extends StatelessWidget {
  dynamic sportid, playlistid, thumnail, title;

  PlaylistCard(
      {@required this.sportid,
      @required this.playlistid,
      @required this.thumnail,
      @required this.title});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PlaylistScreen(
                  sportid: sportid,
                  playlistid: playlistid,
                  playlisttitle: title,
                )));
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 135,
              width: 230,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: Card(
                shape: kRoundedBorder,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Image.network(
                  thumnail,
                  fit: BoxFit.fill,
                ),
                elevation: 10,
              ),
            ),
            Container(
              width: 230,
              margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
              child: Text(
                title,
                // style: TextStyle(
                //   color: Colors.deepPurple,
                // ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
