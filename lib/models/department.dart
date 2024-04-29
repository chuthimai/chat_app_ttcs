class Department {
  final int _idDepartment;
  final String _nameDepartment;

  Department(
    this._idDepartment,
    this._nameDepartment,
  );

  String get nameDepartment => _nameDepartment;

  int get idDepartment => _idDepartment;
}
