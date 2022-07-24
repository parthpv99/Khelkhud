class Coach {
  String _id,
      _fname,
      _lname,
      _description,
      _dateJoined,
      _achievement,
      _photo,
      _dob,
      _mobile,
      _place,
      _city,
      _state;

  int _upvote;
  // List<Sport> _interest;

  Coach.fromJson(Map<String, dynamic> json) {
    _id = json["_id"];
    _fname = json["fname"];
    _lname = json["lname"];
    _description = json["coach_des"];
    _place = json["place"];
    _dateJoined = json["date"];
    _dob = json["dob"];
    _upvote = json["upvote"];
    _photo = json["photo"];
    _achievement = json["achievement"];
    // _interest = json["user_interest"];
    _mobile = json["mobile_no"];
    _city = json["city"];
    _state = json["state"];
  }

  String get id => _id;
  String get fname => _fname;
  String get lname => _lname;
  String get description => _description;
  String get dateJoined => _dateJoined;
  String get dob => _dob;
  String get photo => _photo;
  String get achievement => _achievement;
  // List<Sport> get interest => _interest;
  String get mobile => _mobile;
  String get place => _place;
  String get city => _city;
  String get state => _state;
  int get upvote => _upvote;
}
