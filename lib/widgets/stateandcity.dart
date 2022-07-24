import 'package:flutter/material.dart';
import 'repository.dart';

class StateAndCity extends StatefulWidget {
  @override
  _StateAndCityState createState() => _StateAndCityState();
}

class _StateAndCityState extends State<StateAndCity> {
  Repository repo = Repository();

  List<String> _states = ["Choose a state"];
  List<String> districts = ["Choose a city"];
  String _selectedState = "Choose a state";
  String _selectedLGA = "Choose a city";

  @override
  void initState() {
    _states = List.from(_states)..addAll(repo.getStates());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
              border: new Border.all(color: Color(0xFFFE8B0E))),
          child: DropdownButton<String>(
            // isExpanded: true,
            underline: SizedBox(),
            style: TextStyle(color: Color(0xFFFE8B0E)),
            items: _states.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem),
              );
            }).toList(),
            onChanged: (value) => _onSelectedState(value),
            value: _selectedState,
          ),
        ),
        SizedBox(width: 5),
        Container(
//          width: 30,
          decoration: new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
              border: new Border.all(color: Color(0xFFFE8B0E))),
          child: DropdownButton<String>(
            // isExpanded: true,
            underline: SizedBox(),
            style: TextStyle(color: Color(0xFFFE8B0E)),
            items: districts.map((String dropDownStringItem) {
              return DropdownMenuItem<String>(
                value: dropDownStringItem,
                child: Text(dropDownStringItem),
              );
            }).toList(),
            // onChanged: (value) => print(value),
            onChanged: (value) => _onSelectedLGA(value),
            value: _selectedLGA,
          ),
        ),
      ],
    );
  }

  void _onSelectedState(String value) {
    setState(() {
      _selectedLGA = "Choose a city";
      districts = ["Choose a city"];
      _selectedState = value;
      districts = List.from(districts)..addAll(repo.getLocalByState(value));
    });
  }

  void _onSelectedLGA(String value) {
    setState(() => _selectedLGA = value);
  }

}
