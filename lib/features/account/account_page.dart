import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/auth/model/user_model.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key, required this.user});
  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.backspace))
              ],
            ),
            Center(
              child: CircleAvatar(
                backgroundImage: CachedNetworkImageProvider(user!.profilePic),
              ),
            ),
            Text(user!.displayName),
            Text(user!.username),
            const Text("설정"),
            const Text("설정")
          ],
        ),
      ),
    );
  }
}
