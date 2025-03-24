import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/features/upload/comments/comment_model.dart';
import 'package:uuid/uuid.dart';

class CommentReposity {
  final FirebaseFirestore firestore;
  CommentReposity({required this.firestore});

  uploadCommentToFireStore(
      {required String commentText,
      required String videoId,
      required String displayName,
      required String profilePic}) async {
    String commentId = const Uuid().v4();
    CommentModel comment = CommentModel(
        displayName: displayName,
        commentText: commentText,
        videoId: videoId,
        commentId: commentId,
        profilePic: profilePic);
    firestore.collection("comments").doc(commentId).set(comment.toMap());
  }
}

final commentProvider =
    Provider((ref) => CommentReposity(firestore: FirebaseFirestore.instance));
