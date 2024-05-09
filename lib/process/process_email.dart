import 'package:chat_app_ttcs/db/admin/show_user_dao.dart';
import 'package:chat_app_ttcs/models/user/user_data.dart';

class ProcessEmail {
  String? _email;
  final String _headEmail;
  final _db = ShowUserDAO();
  late List<UserData> _allUsers;

  String get email => _email!;

  ProcessEmail(this._headEmail);

  Future<void> initialize() async {
    await _getAllUsers();
    final numOfSameEmail = _filterEmails().length;
    _email = '$_headEmail${numOfSameEmail == 0 ? '' : numOfSameEmail}@cp.vn';
  }

  Future<void> _getAllUsers() async {
    _allUsers = await _db.getAllUsers();
  }

  List<UserData> _filterEmails() {
    RegExp regExp = RegExp(r'^' + _headEmail + r'\d*@');
    var test =  _allUsers
        .where((user) {
          return regExp.hasMatch(user.companyEmail);
    }).toList();
    return test;
  }
}