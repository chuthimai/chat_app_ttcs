import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordDAO {
  final _db = FirebaseFirestore.instance.collection('Users');
  final _firebaseAuth = FirebaseAuth.instance;

  ForgotPasswordDAO();

  Future<void> sendMessageToEmail(String companyEmail, BuildContext context) async {
    print("====> 0");
    // final userEmail = await _db
    //     .where('companyEmail', isEqualTo: companyEmail)
    //     .get()
    //     .then((value) {
    //   return value.docs.map((e) => e.data()['userEmail']).toList();
    // });
    print("====> 1");
    // if (userEmail.isEmpty) {
    //   print("====> 1.1");
    //   ScaffoldMessenger.of(context).clearSnackBars();
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       duration: Duration(seconds: 3),
    //       content: Text("Your account does not exist."),
    //     ),
    //   );
    //   return;
    // } else {
      print("====> 1.2");
      ActionCodeSettings actionCodeSettings = ActionCodeSettings(
        url: "https://example.com/reset_password/${companyEmail}",
        handleCodeInApp: true,
      );
      _firebaseAuth.sendPasswordResetEmail(
          email: companyEmail, actionCodeSettings: actionCodeSettings);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 3),
          content: Text("Message has been sent."),
        ),
      );
      return;
    // }
  }
}
