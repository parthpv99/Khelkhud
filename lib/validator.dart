String validateEmail(String value) {
  if (value.trim().isEmpty) {
    return 'Email is required';
  }
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Enter valid email';
  }
  return null;
}

String validatePassword(String value) {
  if (value.isEmpty) {
    return 'Password is required';
  }
  if (value.length < 2) {
    return 'Password too short';
  }
  return null;
}

String validateState(String value) {
  if (value.isEmpty) {
    return 'State is required';
  }
  return null;
}
