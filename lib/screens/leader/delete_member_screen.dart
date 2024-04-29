import 'dart:io';

import 'package:flutter/material.dart';

class DeleteMemberScreen extends StatelessWidget {
  DeleteMemberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Delete Member"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (ctx, index) {
            return ListTile(
              leading: CircleAvatar(
                radius: 26,
                foregroundImage:
                    FileImage(File("assets/images/avatar_default.png")),
              ),
              title: Text(
                "Name",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                "Leader",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              trailing: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(213, 246, 189, 208),
                ),
                child: Text("Delete"),
              ),
            );
          },
        ),
      ),
    );
  }
}
