int idPositionControl = 1;

class Position {
  final int _idPosition = idPositionControl++;
  final String namePosition;

  Position(this.namePosition);

  int get idPosition => _idPosition;
}