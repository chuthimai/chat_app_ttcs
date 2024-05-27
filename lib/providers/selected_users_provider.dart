import 'package:chat_app_ttcs/models/user/user_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedUsersNotifier extends StateNotifier<List<UserData>> {

  SelectedUsersNotifier() : super([]); // khoi tao empty list

  void selectedUser(List<UserData> users) {
    state = users;
  }
}

final selectedUsersProvider = StateNotifierProvider<SelectedUsersNotifier,
    List<UserData>>((ref) => SelectedUsersNotifier());

