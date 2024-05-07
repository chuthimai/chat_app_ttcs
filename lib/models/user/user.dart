import 'package:chat_app_ttcs/models/data_obj.dart';
import 'package:chat_app_ttcs/models/process/process_email.dart';
import 'package:chat_app_ttcs/models/process/process_name.dart';

class User extends DataObj {
  final String _idUser;
  String _fullName;
  final bool _gender;
  String _phoneNum;
  String _userEmail;
  String? _companyEmail;
  String _password;
  int? _idJobTransfer;
  String _role;
  String _avartar = '';
  bool _state = true;

  bool get state => _state;

  set state(bool value) {
    _state = value;
  }

  String get avartar => _avartar;

  set avartar(String value) {
    _avartar = value;
  }

  String get fullName => _fullName;

  set fullName(String value) {
    _fullName = value;
  }

  String get idUser => _idUser;

  int get idJobTransfer => _idJobTransfer!;

  set idJobTransfer(int value) {
    _idJobTransfer = value;
  }

  User({
    required String idUser,
    required String fullName,
    bool gender = true,
    required String phoneNum,
    required String userEmail,
    required String password,
    required String role,
  })  : _idUser = idUser,
        _role = role,
        _password = password,
        _userEmail = userEmail,
        _phoneNum = phoneNum,
        _gender = gender,
        _fullName = fullName {
    final processName = ProcessName(_fullName);
    final processEmail = ProcessEmail(processName.standForName);
    _fullName = processName.name;
    _companyEmail = processEmail.email;
  }

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

  String? get companyEmail => _companyEmail;


  set companyEmail(String? value) {
    _companyEmail = value;
  }

  @override
  Map<String, dynamic> toMap() => {
        'id': _idUser,
        'avatar': _avartar,
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

  factory User.toUser(Map<String, dynamic> json) {
    User user = User(
      idUser: json['id'],
      fullName: json['fullName'],
      gender: json['gender'],
      phoneNum: json['phoneNum'],
      userEmail: json['userEmail'],
      password: json['password'],
      role: json['role'],
    );
    user.state = json['state'];
    user.avartar = json['avatar'];
    user.companyEmail = json['companyEmail'];
    user.idJobTransfer = json['idJobTransfer'];

    return user;
  }
}
