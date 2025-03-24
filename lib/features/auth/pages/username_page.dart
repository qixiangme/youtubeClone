import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/features/auth/repositoy/user_data_service.dart';

final _formKey = GlobalKey<FormState>();

class UsernamePage extends ConsumerStatefulWidget {
  final String displayName;
  final String email;
  final String profilePic;

  const UsernamePage(this.displayName, this.email, this.profilePic,
      {super.key});

  @override
  ConsumerState<UsernamePage> createState() => _UsernamePageState();
}

class _UsernamePageState extends ConsumerState<UsernamePage> {
  final TextEditingController _usernameController = TextEditingController();
  bool isValidate = true;

  void validateUserName() async {
    final userMap = await FirebaseFirestore.instance.collection("users").get();
    final users = userMap.docs.map((user) => user).toList();
    String? targetedUsername;
    for (var user in users) {
      if (_usernameController.text == user["username"]) {
        targetedUsername = user.data()["username"];
        isValidate = false;
        setState(() {});
      }
      if (_usernameController.text != targetedUsername) {
        isValidate = true;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 26, horizontal: 16),
          child: Text("Enter the Username"),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Form(
            child: TextFormField(
              onChanged: (username) {
                validateUserName();
              },
              autovalidateMode: AutovalidateMode.always,
              validator: (username) {
                return isValidate ? null : "Username already exists";
              },
              controller: _usernameController,
              key: _formKey,
              decoration: InputDecoration(
                  suffixIcon: isValidate
                      ? const Icon(Icons.check)
                      : const Icon(Icons.close),
                  hintText: "Insert username",
                  suffixIconColor: isValidate ? Colors.green : Colors.red,
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue)),
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green))),
            ),
          ),
        ),
        const Spacer(),
        TextButton(
            onPressed: () async {
              // add user Data inside database
              isValidate
                  ? await ref
                      .read(userDataServiceProvider)
                      .addUserDataToFirestore(
                        displayName: widget.displayName,
                        username: _usernameController.text,
                        email: widget.email,
                        profilePic: widget.profilePic,
                        description: "",
                      )
                  : null;
            },
            child: const Text('Continue'))
      ],
    )));
  }
}
