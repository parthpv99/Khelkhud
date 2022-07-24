import 'package:flutter/material.dart';
import '../constants.dart';

class SportCard extends StatelessWidget {
  final String image;
  final String title;
  final String id;

  SportCard({@required this.image, @required this.title, @required this.id});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, '/sportDetails', arguments: id);
      },
      child: Card(
        color: Colors.white24,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(image),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black,
                  BlendMode.softLight,
                )),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: kTextCardTitle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
