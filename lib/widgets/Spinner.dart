import 'package:flutter/material.dart';

class Spinner extends StatelessWidget {
  final Color color;
  final double strokeWidth;
  final Color backgroundColor;
  Spinner({this.color,this.strokeWidth=5.0,this.backgroundColor=Colors.transparent});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        value: null,
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color> (color),
      ),
    );
  }
}
