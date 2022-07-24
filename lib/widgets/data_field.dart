import 'package:flutter/material.dart';

class DataField extends StatelessWidget {
  final String field;
  final String data;

  DataField({@required this.field, @required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Text(
            field + ': ',
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Text(
            data,
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ],
    );
  }
}
