class Tournament {
  String _id,
      _name,
      _date,
      _time,
      _place,
      _photo,
      _description,
      _link,
      _mobile,
      _mail;

  bool _type;

  Tournament.fromJson(Map<String, dynamic> json) {
    _id = json["_id"];
    _name = json["tournament_name"];
    _place = json["place"];
    _description = json["coach_des"];
    _date = json["date"];
    _type = json["type"];
    _photo = json["photo"];
    _description = json["description"];
    _mobile = json["contact_no"];
    _link = json["link"];
    _mail = json["contact_mail"];
    _time = json["time"];
  }

  String get id => _id;
  String get name => _name;
  String get description => _description;
  String get date => _date;
  String get photo => _photo;
  String get mobile => _mobile;
  String get place => _place;
  String get link => _link;
  String get mail => _mail;
  String get time => _time;
  bool get type => _type;
}
