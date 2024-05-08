import 'package:chat_app_ttcs/models/data_obj.dart';

class Department extends DataObj{
  final int _idDepartment;
  final String _nameDepartment;

  Department(
    this._idDepartment,
    this._nameDepartment,
  );

  String get nameDepartment => _nameDepartment;

  int get idDepartment => _idDepartment;

  @override
  toMap() {
    return {
      'id': _idDepartment,
      'nameDepartment': _nameDepartment,
    };
  }

  factory Department.toDepartment(Map<String, dynamic> json) {
    return Department(json['id'], json['nameDepartment']);
  }
}
