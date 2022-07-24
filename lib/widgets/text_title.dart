import 'package:flutter/material.dart';

class TextTitle extends StatelessWidget {
  final String title;

  TextTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22.0,
        ),
      ),
    );
  }
}
