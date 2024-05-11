import 'package:chat_app_ttcs/models/data_obj.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class JobTransfer extends DataObj {
  final String _idJobTransfer;
  final int _idNewPosition;
  final String _idUser;
  Timestamp _dateTransfer;

  JobTransfer({
    required String idJobTransfer,
    required int idNewPosition,
    required String idUser,
    Timestamp? dateTransfer,
  })
      : _idJobTransfer = idJobTransfer,
        _idNewPosition = idNewPosition,
        _idUser = idUser,
        _dateTransfer = dateTransfer ?? Timestamp.now();


  set dateTransfer(Timestamp value) {
    _dateTransfer = value;
  }

  String get idJobTransfer => _idJobTransfer;

  int get idNewPosition => _idNewPosition;

  Timestamp get dateTransfer => _dateTransfer;

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

    final jobTran =  JobTransfer(
      idJobTransfer: json['id'],
      idNewPosition: json['idNewPosition'],
      idUser: json['idUser'],
    );

    jobTran.dateTransfer = json['dateTransfer'];

    return jobTran;
  }
}