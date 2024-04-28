import 'package:chat_app_ttcs/models/job_transfer.dart';
import 'package:chat_app_ttcs/models/process/process_email.dart';
import 'package:chat_app_ttcs/models/process/process_name.dart';

int idUserControl = 1;

class User {
  final int _idUser = idUserControl++;
  String _fullName;
  final bool _gender;
  String _phoneNum;
  String _userEmail;
  String? _companyEmail;
  String _password;
  int? _idJobTransfer;
  String _role;

  String get fullName => _fullName;

  set fullName(String value) {
    _fullName = value;
  }

  int get idUser => _idUser;

  int get idJobTransfer => _idJobTransfer!;

  set idJobTransfer(int value) {
    _idJobTransfer = value;
  }

  User({
    required String fullName,
    bool gender = true,
    required String phoneNum,
    required String userEmail,
    required String password,
    required String role,
  })  : _role = role,
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
}
