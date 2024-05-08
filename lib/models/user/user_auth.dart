class UserAuth {
  final String _email;
  final String _password;

  UserAuth(this._email, this._password);

  String get password => _password;

  String get email => _email;
}