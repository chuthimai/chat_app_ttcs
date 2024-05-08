import 'package:chat_app_ttcs/models/data_obj.dart';

class UserData extends DataObj {
  final String _idUser;
  String _fullName;
  final bool _gender;
  String _phoneNum;
  String _userEmail;
  String _companyEmail;
  String _password;
  String? _idJobTransfer;
  String _role;
  String _avatar = '';
  bool _state = true;

  bool get state => _state;

  set state(bool value) {
    _state = value;
  }

  String get avatar => _avatar;

  set avatar(String value) {
    _avatar = value;
  }

  String get fullName => _fullName;

  set fullName(String value) {
    _fullName = value;
  }

  String get idUser => _idUser;

  String get idJobTransfer => _idJobTransfer!;

  set idJobTransfer(String value) {
    _idJobTransfer = value;
  }

  UserData({
    required String idUser,
    required String fullName,
    bool gender = true,
    required String phoneNum,
    required String userEmail,
    required String companyEmail,
    required String password,
    required String role,
  })  : _idUser = idUser,
        _role = role,
        _password = password,
        _userEmail = userEmail,
        _companyEmail = companyEmail,
        _phoneNum = phoneNum,
        _gender = gender,
        _fullName = fullName;

  String get phoneNum => _phoneNum;

  set phoneNum(String value) {
    _phoneNum = value;
  }

  String get userEmail => _userEmail;

  set userEmail(String value) {
    _userEmail = value;
  }

  String get role => _role;

  bool get gender => _gender;

  set role(String value) {
    _role = value;
  }

  String get password => _password;

  set password(String value) {
    _password = value;
  }

  String get companyEmail => _companyEmail;

  @override
  Map<String, dynamic> toMap() => {
        'id': _idUser,
        'avatar': _avatar,
        'companyEmail': _companyEmail,
        'fullName': _fullName,
        'gender': _gender,
        'idJobTransfer': _idJobTransfer,
        'password': _password,
        'phoneNum': _phoneNum,
        'role': _role,
        'state': _state,
        'userEmail': _userEmail
      };

  factory UserData.toUser(Map<String, dynamic> json) {
    UserData user = UserData(
      idUser: json['id'],
      fullName: json['fullName'],
      gender: json['gender'],
      phoneNum: json['phoneNum'],
      userEmail: json['userEmail'],
      password: json['password'],
      role: json['role'],
      companyEmail: json['companyEmail']
    );
    user.state = json['state'];
    user.avatar = json['avatar'];
    user.idJobTransfer = json['idJobTransfer'];

    return user;
  }
}
