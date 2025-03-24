import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/error_page.dart';
import 'package:instagram_clone/features/auth/model/user_model.dart';
import 'package:instagram_clone/features/auth/provider/user_provider.dart';
import 'package:instagram_clone/features/content/long_video/parts/video.dart';
import 'package:instagram_clone/features/upload/video_model.dart';

class Post extends ConsumerWidget {
  final VideoModel video;
  const Post({required this.video, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
//UserModel 가져와서 그 User의 Video 표시시
    final AsyncValue<UserModel> userModel =
        ref.watch(anyUserDataProvider(video.userId));
    return userModel.when(
      data: (user) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Video(
                video: video,
              ),
            ),
          );
        },
        child: Container(
          child: Column(
            children: [
              CachedNetworkImage(imageUrl: video.thumbnail),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: CircleAvatar(
                      radius: 20,
                      backgroundImage:
                          CachedNetworkImageProvider(user.profilePic),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(video.title),
                  ),
                  const Spacer(),
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.more_vert))
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.sizeOf(context).width * 0.15),
                child: Row(
                  children: [
                    Text(user.displayName),
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Text(video.views.toString()),
                    ),
                    const Text("a moment ago")
                  ],
                ),
              ),






              
            ],
          ),
        ),
      ),
      error: (err, stack) => Center(child: Text("에러 발생: $err")), // 에러 표시
      loading: () => const Center(child: CircularProgressIndicator()), //
    );
  }
}
