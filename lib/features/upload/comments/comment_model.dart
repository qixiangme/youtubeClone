// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CommentModel {
  final String displayName;
  final String commentText;
  final String videoId;
  final String commentId;
  final String profilePic;

  CommentModel(
      {required this.displayName,
      required this.commentText,
      required this.videoId,
      required this.commentId,
      required this.profilePic});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayName': displayName,
      'commentText': commentText,
      'videoId': videoId,
      'commentId': commentId,
      'profilePic': profilePic,
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      displayName: map['displayName'] as String,
      commentText: map['commentText'] as String,
      videoId: map['videoId'] as String,
      commentId: map['commentId'] as String,
      profilePic: map['profilePic'] as String,
    );
  }
}
