import 'dart:io';

import 'package:chat_app_ttcs/db/user/manage_user_dao.dart';
import 'package:chat_app_ttcs/forms/search/search.dart';
import 'package:chat_app_ttcs/forms/staff/all_conversations.dart';
import 'package:chat_app_ttcs/models/user/user_data.dart';
import 'package:chat_app_ttcs/screens/user/change_password_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ViewListFriendScreen extends StatefulWidget {
  const ViewListFriendScreen({super.key});

  @override
  State<ViewListFriendScreen> createState() => _ViewListFriendScreenState();
}

class _ViewListFriendScreenState extends State<ViewListFriendScreen> {
  final ManageUserDAO _manageUserDAO = ManageUserDAO();
  UserData? _currentUser;

  @override
  void initState() {
    _getCurrentUser();
    super.initState();
  }

  Future<void> _getCurrentUser() async {
    final user = await _manageUserDAO.getCurrentUser();
    setState(() {
      _currentUser = user;
    });
  }

  void _selectChangePassword(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => const ChangePasswordScreen(),
      ),
    );
  }

  void _takeAvatar() async {
    File? selectedImage;
    final imagePicker = ImagePicker();
    final pickedImage = await imagePicker.pickImage(
      source: ImageSource.gallery, // mo thu vien anh de chon
      maxWidth: 600,
    );
    if (pickedImage == null) return;
    selectedImage = File(pickedImage.path); // chuyen XFile ve File
    _manageUserDAO.saveAvatarImage(selectedImage);
    await _getCurrentUser();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Successfully updated profile picture"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    if (_currentUser == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversations"),
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ListTile(
                        leading: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("Users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }

                            if (!snapshot.hasData) {
                              return const Center(
                                child: Text("No messages found."),
                              );
                            }
                            final currentUserSnapshot = snapshot.data!.data();
                            final currentUser = UserData.toUser(currentUserSnapshot!);

                            return InkWell(
                              onDoubleTap: _takeAvatar,
                              child: CircleAvatar(
                                radius: 26,
                                backgroundImage:
                                    NetworkImage(currentUser.avatar),
                              ),
                            );
                          },
                        ),
                        title: Text(
                          _currentUser!.fullName,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        subtitle: Text(
                          _currentUser!.companyEmail,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  Icons.password,
                  size: 26,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
                title: Text(
                  "Change Password",
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontSize: 22,
                      ),
                ),
                onTap: () {
                  _selectChangePassword(context);
                },
              ),
              ListTile(
                  leading: Icon(
                    Icons.logout,
                    size: 26,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  title: Text(
                    "Logout",
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                          fontSize: 22,
                        ),
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                  })
            ],
          ),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                SearchUser(),
                SizedBox(
                  height: 20,
                ),
                AllConversations(),
              ],
            )),
      ),
    );
  }
}
