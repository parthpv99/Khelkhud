import 'package:flutter/material.dart';
import '../pages/CoachDetails.dart';

class CoachCard extends StatelessWidget {
  final String id;
  final String name;
  final String photo;
  final int upvote;
  final String place;

  CoachCard(
      {@required this.id,
      @required this.name,
      @required this.photo,
      @required this.upvote,
      @required this.place});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CoachDetails(id)));
      },
      child: Card(
        color: Colors.white24,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Center(
                  child: CircleAvatar(
                    radius: 38.0,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 35.0,
                      backgroundImage: NetworkImage(
                        photo,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Text(place),
                    SizedBox(
                      height: 5.0,
                    ),
                    upvote == 0
                        ? Text(
                            'No Upvotes',
                            style: TextStyle(
                              color: Colors.grey[400],
                            ),
                          )
                        : Text(
                            'Upvoted by ' + upvote.toString() + ' People',
                            style: TextStyle(
                              color: Colors.grey[400],
                            ),
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
