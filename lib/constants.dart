import 'package:flutter/material.dart';

//For TextTitle Decoration
const kTextTitle = TextStyle(
  fontSize: 25.0,
  fontWeight: FontWeight.w300,
);

var kTextCardTitle = TextStyle(
  fontSize: 15.0,
  fontWeight: FontWeight.bold,
);

var kvideocard_descripation = TextStyle(
  fontSize: 10.0,
);

const kTextButton = TextStyle(
  color: Color(0xff2E3754),
  fontSize: 15,
  fontWeight: FontWeight.w700,
);
//For TextField Decoration
const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  // contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(6)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFFE8B0E), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(6)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFFE8B0E), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(6)),
  ),
);

//For Round Border
const kRoundedBorder =
    RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(6)));

//For heading of Container
const kContainerHeadingText = TextStyle(
  fontWeight: FontWeight.bold,
);

var kSearchTextField = InputDecoration(
  labelText: "Search",
  hintText: "Search",
  prefixIcon: Icon(Icons.search),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
);

const CircularProgress = Center(
  child: CircularProgressIndicator(
    strokeWidth: 3,
  ),
);
