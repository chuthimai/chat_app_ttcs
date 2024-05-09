import 'package:chat_app_ttcs/db/admin/show_user_dao.dart';
import 'package:chat_app_ttcs/models/department.dart';
import 'package:chat_app_ttcs/models/job_transfer.dart';
import 'package:chat_app_ttcs/models/position.dart';
import 'package:chat_app_ttcs/models/user/user_auth.dart';
import 'package:chat_app_ttcs/models/user/user_data.dart';
import 'package:chat_app_ttcs/process/process_email.dart';
import 'package:chat_app_ttcs/process/process_name.dart';
import 'package:chat_app_ttcs/process/random_password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class NewUserForm extends StatefulWidget {
  const NewUserForm({super.key});

  @override
  State<NewUserForm> createState() => _NewUserFormState();
}

class _NewUserFormState extends State<NewUserForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _db = ShowUserDAO();
  late UserData _adminAccount;
  List<Position> allPositions = [];
  late List<String> roles;
  final randomPass = RandomPassword();
  final uuid = const Uuid();

  //TODO: bien nhap form
  String _enterFullName = '';
  bool _enterGender = true;
  String _enterPhoneNumber = '';
  String _enterUserEmail = '';
  String _enterCompanyEmail = '';
  late String _enterPassword;
  late Department _enterDepartment;
  late Position _enterPosition;
  late String _enterRole = roles[1];

  void _submit() async {
    final isValid = _formKey.currentState!.validate(); // KQ chay xac thuc
    if (!isValid) return;
    _formKey.currentState!.save(); // thuc hien hanh dong onSave cua Form

    // create account email auth
    final newUserAuth = UserAuth(_enterCompanyEmail, _enterPassword);
    final idUser = await _db.createAuthUser(newUserAuth);

    // create job transfer
    final idJobTransfer = uuid.v4();
    final newJobTransfer = JobTransfer(
      idJobTransfer: idJobTransfer,
      idNewDepartment: _enterDepartment.idDepartment,
      idNewPosition: _enterPosition.idPosition,
      idUser: idUser,
    );
    await _db.createJobTransfer(newJobTransfer);

    // create user in collection "Users"
    final newUser = UserData(
      idUser: idUser,
      fullName: _enterFullName,
      phoneNum: _enterPhoneNumber,
      gender: _enterGender,
      userEmail: _enterUserEmail,
      companyEmail: _enterCompanyEmail,
      password: _enterPassword,
      role: _enterRole,
    );
    newUser.idJobTransfer = idJobTransfer;
    await _db.createUser(newUser);

    // Prevent login new account
    await FirebaseAuth.instance.signOut();
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _adminAccount.companyEmail,
      password: _adminAccount.password,
    );

    // exit overlay
    Navigator.pop(context);

    // show notification add new users successfully
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Add new users successfully.'),
      ),
    );
  }

  void _getAllPosition() async {
    final positions = await _db.getAllPosition();
    setState(() {
      allPositions = positions.toList();
      _enterPosition = positions[0];
      _enterDepartment = _enterPosition.department;
    });
  }

  void _getAdminAccount() async {
    _adminAccount = await _db.getCurrentUser();
  }

  @override
  void initState() {
    _getAllPosition();
    _getAdminAccount();
    _enterPassword = randomPass.generatePassword(8);
    roles = ['Admin', 'Normal User'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (allPositions.isEmpty) return const CircularProgressIndicator();
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "User",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              TextFormField(
                maxLength: 50,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  label: Text("Full Name"),
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.words,
                onSaved: (value) async {
                  final processName = ProcessName(value!);
                  _enterFullName = processName.name;
                  final processEmail = ProcessEmail(processName.standForName);
                  await processEmail.initialize();
                  _enterCompanyEmail = processEmail.email;
                },
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a valid user\'s name.';
                  }
                  return null;
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
                    value: _enterGender,
                    hint: const Text("Gender"),
                    onChanged: (value) {
                      _enterGender = value!;
                    },
                  )),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                maxLength: 50,
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
                initialValue: "example@cp.vn",
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Company Email",
                  filled: true,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                maxLength: 50,
                initialValue: _enterPassword,
                keyboardType: TextInputType.text,
                readOnly: true,
                decoration: const InputDecoration(
                  label: Text("Password"),
                  border: OutlineInputBorder(),
                  filled: true,
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    // labelText: "Department",
                    hintText: _enterDepartment.nameDepartment,
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
                    items: allPositions.map((position) {
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
                        _enterDepartment = _enterPosition.department;
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
                    items: roles
                        .map((e) => DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            ))
                        .toList(),
                    value: _enterRole,
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
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(213, 246, 189, 208),
                    ),
                    child: const Text("Save"),
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
