import 'package:chat_app_ttcs/models/data_obj.dart';

class JobTransfer extends DataObj {
  final int _idJobTransfer;
  final int _idNewDepartment;
  final int _idNewPosition;
  final String _idUser;
  DateTime _dateTransfer;

  JobTransfer({
    required int idJobTransfer,
    required int idNewDepartment,
    required int idNewPosition,
    required String idUser,
    DateTime? dateTransfer,
  })
      : _idJobTransfer = idJobTransfer,
        _idNewDepartment = idNewDepartment,
        _idNewPosition = idNewPosition,
        _idUser = idUser,
        _dateTransfer = dateTransfer ?? DateTime.now();

  int get idNewDepartment => _idNewDepartment;

  int get idJobTransfer => _idJobTransfer;

  int get idNewPosition => _idNewPosition;

  DateTime get dateTransfer => _dateTransfer;

  String get idUser => _idUser;

  @override
  toMap() =>
      {
        'id': _idJobTransfer,
        'idNewDepartment': _idNewDepartment,
        'idNewPosition': _idNewPosition,
        'dateTransfer': _dateTransfer,
        'idUser': _idUser,
      };

  factory JobTransfer.toJobTransfer(Map<String, dynamic> json) {

    return JobTransfer(
      idJobTransfer: json['id'],
      idNewDepartment: json['idNewDepartment'],
      idNewPosition: json['idNewPosition'],
      idUser: json['idUser'],
    );
  }
}