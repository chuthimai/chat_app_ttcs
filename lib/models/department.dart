int idDepartmentControl = 1;

class Department {
  final int _idDepartment = idDepartmentControl++;
  final String nameDepartment;

  Department(this.nameDepartment);

  int get idDepartment => _idDepartment;
}