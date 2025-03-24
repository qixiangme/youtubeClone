import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/auth/model/user_model.dart';

class TopHeaderWidget extends StatelessWidget {
  final UserModel user;
  const TopHeaderWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //top header
          Center(
            child: CircleAvatar(
              radius: 38,
              backgroundColor: Colors.grey,
              backgroundImage: CachedNetworkImageProvider(user.profilePic),
            ),
          ),
          Text(
            user.displayName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          RichText(
            text: TextSpan(
              style: const TextStyle(color: Colors.black),
              children: [
                TextSpan(text: "${user.username}  "),
                TextSpan(text: "${user.subscriptions.length} subscriptions  "),
                TextSpan(text: "${user.videos} videos"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
