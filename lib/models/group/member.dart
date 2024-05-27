class Member {
  final String _idUser;
  final String _fullName;
  final bool _gender;
  final String _email;
  String _roleInGroup = "Member";

  Member(this._idUser, this._fullName, this._gender, this._email);

  String get roleInGroup => _roleInGroup;

  set roleInGroup(String value) {
    _roleInGroup = value;
  }

  String get fullName => _fullName;

  String get email => _email;

  bool get gender => _gender;

  String get idUser => _idUser;
}