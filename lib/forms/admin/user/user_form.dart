import 'package:chat_app_ttcs/models/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserForm extends StatefulWidget {
  // User? user;

  const UserForm({super.key});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 40),
        child: Form(
          // key: ,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("User", style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.bold
              ),),
              const SizedBox(height: 30),
              TextFormField(
                maxLength: 50,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  label: Text("Full Name"),
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {},
                validator: (value) {
                  // Kt trong database
                  return null;
                },
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: DropdownButtonFormField(
                    items: const [
                      DropdownMenuItem(value: false, child: Text("Female"),),
                      DropdownMenuItem(value: true, child: Text("Male"),),
                    ],
                    value: null,
                    hint: const Text("Gender"),
                    onChanged: (value) {},
                  )),
              const SizedBox(height: 16,),
              TextFormField(
                maxLength: 50,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text("Phone Number"),
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {},
                validator: (value) {
                  // Kt trong database
                  return null;
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
                onSaved: (value) {},
                validator: (value) {
                  // Kt trong database
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
                onSaved: (value) {},
              ),
              const SizedBox(height: 16,),
              TextFormField(
                maxLength: 50,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                  label: Text("Password"),
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {},
                validator: (value) {
                  // Kt trong database
                  return null;
                },
              ),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: DropdownButtonFormField(
                    items: [],
                    value: null,
                    hint: const Text("Department"),
                    onChanged: (value) {},
                  )),
              const SizedBox(height: 16,),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: DropdownButtonFormField(
                    items: [],
                    value: null,
                    hint: const Text("Position"),
                    onChanged: (value) {},
                  )),
              const SizedBox(height: 16,),
              SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: DropdownButtonFormField(
                    items: [],
                    value: null,
                    hint: const Text("Role"),
                    onChanged: (value) {},
                  )),
              const SizedBox(height: 20,),
              Row(
                children: [
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {},
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
