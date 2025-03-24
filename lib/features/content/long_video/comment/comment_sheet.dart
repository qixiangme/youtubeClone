import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/error_page.dart';
import 'package:instagram_clone/features/auth/provider/user_provider.dart';
import 'package:instagram_clone/features/content/long_video/comment/comment._tile.dart';
import 'package:instagram_clone/features/upload/comments/comment_model.dart';
import 'package:instagram_clone/features/upload/comments/comment_reposity.dart';
import 'package:instagram_clone/features/upload/video_model.dart';
import 'package:riverpod/riverpod.dart';

class CommentSheet extends ConsumerStatefulWidget {
  final VideoModel video;
  const CommentSheet({super.key, required this.video});

  @override
  ConsumerState<CommentSheet> createState() => _CommentSheetState();
}

class _CommentSheetState extends ConsumerState<CommentSheet> {
  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider).whenData((user) => user);

    return Container(
      child: Column(
        children: [
          const Text(
            "Comments",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Colors.grey.shade400,
            ),
            child: const Text(
                "Remember to keep comments respectful and to follow our community and guideline"),
          ),
          SizedBox(
            height: 160,
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("comments")
                    .where("videoId", isEqualTo: widget.video.videoId)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const ErrorPage();
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }

                  final commentsMap = snapshot.data!.docs;
                  final List<CommentModel> comments = commentsMap
                      .map(
                        (comment) => CommentModel.fromMap(
                          comment.data(),
                        ),
                      )
                      .toList();
                  return SizedBox(
                    height: 20,
                    child: ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          return CommentTile(comment: comments[index]);
                        }),
                  );
                }),
          ),
          Row(
            children: [
              const CircleAvatar(),
              const SizedBox(
                width: 10,
              ),
              SizedBox(
                width: 255,
                height: 55,
                child: TextField(
                  controller: _commentController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                ),
              ),
              IconButton(
                  onPressed: () async {
                    ref.watch(commentProvider).uploadCommentToFireStore(
                        commentText: _commentController.text,
                        videoId: widget.video.videoId,
                        displayName: user.value!.displayName,
                        profilePic: user.value!.profilePic);
                  },
                  icon: const Icon(Icons.check))
            ],
          )
        ],
      ),
    );
  }
}
