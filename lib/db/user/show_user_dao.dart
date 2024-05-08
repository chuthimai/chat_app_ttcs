import 'package:chat_app_ttcs/models/department.dart';
import 'package:chat_app_ttcs/models/job_transfer.dart';
import 'package:chat_app_ttcs/models/position.dart';
import 'package:chat_app_ttcs/models/user/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShowUserDAO {
  final _db = FirebaseFirestore.instance;

  ShowUserDAO();

  Future<List<User>> getAllUsers() async {
    final users = await _db.collection('Users').get().then((value) {
      return value.docs.map((e) {
        return User.toUser(e.data());
      });
    });

    return users.toList();
  }

  Future<List<Position>> getAllPosition() async {
    final positions = await _db.collection('Position').get().then((value) {
      return value.docs.map((e) {
        return Position.toPosition(e.data());
      });
    });
    return positions.toList();
  }

  Future<Position> getJobTransfer(int idJobTransfer) async {
    final jobTransferDoc =
        await _db.collection('JobTransfer').doc(idJobTransfer.toString()).get();

    final jobTransfer = JobTransfer.toJobTransfer(jobTransferDoc.data()!);

    final positionDoc = await _db
        .collection('Position')
        .doc(jobTransfer.idJobTransfer.toString())
        .get();

    final position = Position.toPosition(positionDoc.data()!);
    final departmentDoc = await positionDoc.data()!['department'].get();
    final department = Department.toDepartment(departmentDoc.data()!);
    position.department = department;

    return position;
  }
}
