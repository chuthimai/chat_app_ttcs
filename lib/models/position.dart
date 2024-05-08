import 'package:chat_app_ttcs/models/data_obj.dart';
import 'package:chat_app_ttcs/models/department.dart';

class Position extends DataObj{
  final int _idPosition;
  final String _namePosition;
  Department? _department;

  set department(Department value) {
    _department = value;
  }

  Department get department => _department!;


  Position(this._idPosition, this._namePosition);

  int get idPosition => _idPosition;

  String get namePosition => _namePosition;

  @override
  toMap() {
    return {
      'id': _idPosition,
      'namePosition': _namePosition,
    };
  }

  factory Position.toPosition(Map<String, dynamic> json) {
    Position position = Position(json['id'], json['namePosition']);
    return position;
  }

}