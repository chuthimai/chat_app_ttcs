import 'package:chat_app_ttcs/models/data_obj.dart';

class JobTransfer extends DataObj {
  final String _idJobTransfer;
  final int _idNewPosition;
  final String _idUser;
  DateTime _dateTransfer;

  JobTransfer({
    required String idJobTransfer,
    required int idNewPosition,
    required String idUser,
    DateTime? dateTransfer,
  })
      : _idJobTransfer = idJobTransfer,
        _idNewPosition = idNewPosition,
        _idUser = idUser,
        _dateTransfer = dateTransfer ?? DateTime.now();


  String get idJobTransfer => _idJobTransfer;

  int get idNewPosition => _idNewPosition;

  DateTime get dateTransfer => _dateTransfer;

  String get idUser => _idUser;

  @override
  toMap() =>
      {
        'id': _idJobTransfer,
        'idNewPosition': _idNewPosition,
        'dateTransfer': _dateTransfer,
        'idUser': _idUser,
      };

  factory JobTransfer.toJobTransfer(Map<String, dynamic> json) {

    return JobTransfer(
      idJobTransfer: json['id'],
      idNewPosition: json['idNewPosition'],
      idUser: json['idUser'],
    );
  }
}