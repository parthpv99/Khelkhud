class Sport {
  String _id,
      _name,
      _description,
      _rules,
      _dimensions,
      _howtoplay,
      _image1,
      _image2,
      _image3,
      _equipment,
      _type;

  int _subscriber;

  Sport.fromJson(Map<String, dynamic> json) {
    _id = json["_id"];
    _name = json["sport_name"];
    _description = json["sport_description"];
    _rules = json["sport_rule"];
    _dimensions = json["sport_dimensions"];
    _howtoplay = json["how_to_play"];
    _image1 = json["sport_image1"];
    _image2 = json["sport_image2"];
    _image3 = json["sport_image3"];
    _equipment = json["sport_equipment"];
    _type = json["sport_type"];
    _subscriber = json["subscribe"];
  }

  String get id => _id;
  String get name => _name;
  String get description => _description;
  String get rules => _rules;
  String get dimensions => _dimensions;
  String get howtoplay => _howtoplay;
  String get image1 => _image1;
  String get image2 => _image2;
  String get image3 => _image3;
  String get equipment => _equipment;
  String get type => _type;
  int get subscriber => _subscriber;
}
