import 'package:chat_app_ttcs/db/admin/show_user_dao.dart';
import 'package:chat_app_ttcs/db/user/change_password_dao.dart';
import 'package:chat_app_ttcs/models/department.dart';
import 'package:chat_app_ttcs/models/job_transfer.dart';
import 'package:chat_app_ttcs/models/position.dart';
import 'package:chat_app_ttcs/models/user/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class EditUserForm extends StatefulWidget {
  final UserData user;

  const EditUserForm({required this.user, super.key});

  @override
  State<EditUserForm> createState() => _EditUserFormState();
}

class _EditUserFormState extends State<EditUserForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _db = ShowUserDAO();
  late UserData _adminAccount;
  List<Position> _allPositions = [];
  final List<String> _roles = ['Admin', 'Normal User'];
  late Position _currentPosition;
  final uuid = const Uuid();

  //TODO: bien nhap form
  String _enterFullName = '';
  bool _enterGender = true;
  String _enterPhoneNumber = '';
  String _enterUserEmail = '';
  String _enterCompanyEmail = '';
  late String _enterPassword;
  Department? _enterDepartment;
  Position? _enterPosition;
  late String _enterRole;

  @override
  void initState() {
    _getAllPosition();
    _getCurrentPosition();
    _getAdminAccount();
    _enterFullName = widget.user.fullName;
    _enterGender = widget.user.gender;
    _enterPhoneNumber = widget.user.phoneNum;
    _enterUserEmail = widget.user.userEmail;
    _enterCompanyEmail = widget.user.companyEmail;
    _enterPassword = widget.user.password;
    _enterRole = widget.user.role;

    super.initState();
  }

  void _clickUpdate() async {
    final isValid = _formKey.currentState!.validate(); // KQ chay xac thuc
    if (!isValid) return;
    _formKey.currentState!.save(); // thuc hien hanh dong onSave cua Form

    // xu ly khi mat khau thay doi
    if (widget.user.password.compareTo(_enterPassword) != 0) {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: widget.user.companyEmail,
        password: widget.user.password,
      );

      final changePassword = ChangePasswordDAO();
      await changePassword.changePassword(_enterPassword);

      // Prevent login new account
      await FirebaseAuth.instance.signOut();
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _adminAccount.companyEmail,
        password: _adminAccount.password,
      );
    }

    String idJT = '';

    // xu ly khi vi tri cong viec thay doi
    if (_currentPosition.idPosition != _enterPosition!.idPosition) {
      final idJobTransfer = uuid.v4();
      final newJobTransfer = JobTransfer(
        idJobTransfer: idJobTransfer,
        idNewPosition: _enterPosition!.idPosition,
        idUser: widget.user.idUser,
      );
      await _db.createJobTransfer(newJobTransfer);
      idJT = idJobTransfer;
    } else {
      idJT = widget.user.idJobTransfer;
    }

    // create user in collection "Users"
    final user = UserData(
      idUser: widget.user.idUser,
      fullName: _enterFullName,
      phoneNum: _enterPhoneNumber,
      gender: _enterGender,
      userEmail: _enterUserEmail,
      companyEmail: _enterCompanyEmail,
      password: _enterPassword,
      role: _enterRole,
    );
    user.idJobTransfer = idJT;
    print(user.toMap());
    await _db.updateUser(user);

    // exit overlay
    Navigator.pop(context);

    // show notification add new users successfully
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Update users successfully.'),
      ),
    );
  }

  void _getAllPosition() async {
    final positions = await _db.getAllPosition();
    setState(() {
      _allPositions = positions.toList();
    });
  }

  void _getCurrentPosition() async {
    final currentJobTran = await _db.getPosition(widget.user.idJobTransfer);
    setState(() {
      _currentPosition = _allPositions.where((element) => element.idPosition == currentJobTran.idPosition).first;
      _enterPosition = _currentPosition;
      _enterDepartment = _enterPosition!.department;
    });
  }

  void _getAdminAccount() async {
    _adminAccount = await _db.getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    if (_allPositions.isEmpty) return const CircularProgressIndicator();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Edit User",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextFormField(
                maxLength: 50,
                initialValue: widget.user.fullName,
                readOnly: true,
                decoration: const InputDecoration(
                  label: Text("Full Name"),
                  border: OutlineInputBorder(),
                  filled: true,
                ),
                onSaved: (value) async {
                  _enterFullName = value!;
                },
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: DropdownButtonFormField(
                    items: const [
                      DropdownMenuItem(
                        value: false,
                        child: Text("Female"),
                      ),
                      DropdownMenuItem(
                        value: true,
                        child: Text("Male"),
                      ),
                    ],
                    value: widget.user.gender,
                    onChanged: (value) {
                      _enterGender = value!;
                    },
                  )),
              const SizedBox(height: 16),
              TextFormField(
                maxLength: 50,
                initialValue: widget.user.phoneNum,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("Phone Number"),
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  if (value == null) {
                    _enterPhoneNumber = '';
                  } else {
                    _enterPhoneNumber = value;
                  }
                },
                validator: (value) {
                  final regex = RegExp(r'^0\d{9}$'); //sdt
                  if (value == null) {
                    return null;
                  } else if (regex.hasMatch(value)) {
                    return null;
                  }
                  return "Phone Number is incorrect.";
                },
              ),
              TextFormField(
                maxLength: 50,
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                initialValue: widget.user.userEmail,
                decoration: const InputDecoration(
                  label: Text("User Email"),
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  _enterUserEmail = value!;
                },
                validator: (value) {
                  final regex = RegExp(r'@gmail.com$');
                  if (value == null) {
                    return "Please enter a valid email address.";
                  } else if (!regex.hasMatch(value)) {
                    return "Please enter email end with '@gmail.com'.";
                  }
                  return null;
                },
              ),
              TextFormField(
                readOnly: true,
                initialValue: widget.user.companyEmail,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Company Email",
                  filled: true,
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                maxLength: 50,
                initialValue: widget.user.password,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text("Password"),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value!.length < 6) {
                    return "Password has at least 6 characters.";
                  }
                  return null;
                },
                onSaved: (value) {
                  _enterPassword = value!;
                },
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: _enterDepartment?.nameDepartment,
                    filled: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: DropdownButtonFormField(
                    items: _allPositions.map((position) {
                      return DropdownMenuItem(
                        value: position,
                        child: Text(position.namePosition),
                      );
                    }).toList(),
                    value: _enterPosition,
                    hint: const Text("Position"),
                    onChanged: (value) {
                      setState(() {
                        _enterPosition = value!;
                        _enterDepartment = _enterPosition!.department;
                      });
                    },
                  )),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: DropdownButtonFormField(
                    items: _roles
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    value: widget.user.role,
                    hint: const Text("Role"),
                    onChanged: (value) {
                      setState(() {
                        _enterRole = value!;
                      });
                    },
                  )),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _clickUpdate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(213, 246, 189, 208),
                    ),
                    child: const Text("Update"),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(),
                    child: const Text("Cancel"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
