class ProcessEmail {
  String? _email;
  final String _headEmail;

  String get email => _email!;

  ProcessEmail(this._headEmail) {
    _email = _headEmail + "00" + "@cp.vn";
  }
}