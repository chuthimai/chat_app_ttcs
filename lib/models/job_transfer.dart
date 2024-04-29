class JobTransfer {
  final int _idJobTransfer;
  int _idNewDepartment;
  int _idNewPosition;
  String _idUser;
  DateTime _dateTransfer = DateTime.now();

  JobTransfer(
    this._idJobTransfer,
    this._idNewDepartment,
    this._idNewPosition,
    this._idUser,
  );

  int get idNewDepartment => _idNewDepartment;

  int get idJobTransfer => _idJobTransfer;

  int get idNewPosition => _idNewPosition;

  DateTime get dateTransfer => _dateTransfer;

  String get idUser => _idUser;
}
