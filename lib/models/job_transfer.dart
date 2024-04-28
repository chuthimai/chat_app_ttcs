int idJobTransferControl = 1;

class JobTransfer {
  final int _idJobTransfer = idJobTransferControl++;
  int idNewDepartment;
  int idNewPosition;
  int idUser;
  DateTime dateTransfer = DateTime.now();

  JobTransfer({
    required this.idNewDepartment,
    required this.idNewPosition,
    required this.idUser,
  });

  int get idJobTransfer => _idJobTransfer;
}
