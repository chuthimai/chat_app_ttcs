import 'package:chat_app_ttcs/db/user/manage_user_dao.dart';
import 'package:chat_app_ttcs/models/department.dart';
import 'package:chat_app_ttcs/models/job_transfer.dart';
import 'package:chat_app_ttcs/models/position.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ShowUserDAO extends ManageUserDAO{
  final _db = FirebaseFirestore.instance;
  final _firebaseAuth = FirebaseAuth.instance;

  ShowUserDAO();

  Future<List<Position>> getAllPosition() async {
    final positions = await _db.collection('Position').get().then((value) {
      return value.docs.map((e) async {
        final position = Position.toPosition(e.data());
        final departmentDoc = await e.data()['department'].get();
        final department = Department.toDepartment(departmentDoc.data()!);
        position.department = department;
        return position;
      }).toList();
    });

    // Doi tai xong moi thuc thi tiep
    return Future.wait(positions);
  }

  Future<List<JobTransfer>> getAllJobTransfer() async {
    final jobTransfers = await getAllUsersOn().then((value) {
      return value.map((e) async{
        final jobTransDoc = await _db.collection('JobTransfer').doc(e.idJobTransfer).get();
        final jobTrans = JobTransfer.toJobTransfer(jobTransDoc.data()!);
        return jobTrans;
      }).toList();
    });

    return Future.wait(jobTransfers);
  }

  Future<Position> getPosition(String idJobTransfer) async {
    final jobTransferDoc =
        await _db.collection('JobTransfer').doc(idJobTransfer).get();
    final jobTransfer = JobTransfer.toJobTransfer(jobTransferDoc.data()!);

    final positionDoc = await _db
        .collection('Position')
        .doc(jobTransfer.idNewPosition.toString())
        .get();
    final position = Position.toPosition(positionDoc.data()!);

    final departmentDoc = await positionDoc.data()!['department'].get();
    final department = Department.toDepartment(departmentDoc.data()!);

    position.department = department;
    return position;
  }

  Future<JobTransfer> getJobTransfer(String idJobTransfer) async {
    final jobTransferDoc =
    await _db.collection('JobTransfer').doc(idJobTransfer).get();
    final jobTransfer = JobTransfer.toJobTransfer(jobTransferDoc.data()!);

    return jobTransfer;
  }

  Future<void> createJobTransfer(JobTransfer jobTransfer) async {
    await _db
        .collection('JobTransfer')
        .doc(jobTransfer.idJobTransfer)
        .set(jobTransfer.toMap(), SetOptions(merge: true));
  }

}
