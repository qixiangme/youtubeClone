// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone/features/upload/video_details_page.dart';

void showErrorSnackBar(String message, context) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
      ),
    );

Future pickVideo(context) async {
  XFile? file = await ImagePicker().pickVideo(source: ImageSource.gallery);
  File video = File(file!.path);
  print(video);
  print(video.path);

  Navigator.push(context, MaterialPageRoute(
    builder: (context) {
      return VideoDetailsPage(video: video);
    },
  ));
}

Future<File> pickImage() async {
  XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
  File image = File(file!.path);
  return image;
}

Future<String> putFileInStorage(
    File? file, String number, String fileType) async {
  print(number);
  print(file);
  print(fileType);
  if (file == null) {
    print("❌ 업로드할 파일이 없습니다.");
    return Future.error("파일이 없습니다.");
  }
  try {
    print("파일 업로드 시작: $fileType/$number");
    final ref = FirebaseStorage.instance.ref().child("$fileType/$number");
    print(ref);
    final upload = ref.putFile(file);
    final snapshot = await upload.snapshotEvents.last;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    print("파일 업로드 완료: $downloadUrl");
    return downloadUrl;
  } catch (e) {
    print("❌ 파일 업로드 중 오류 발생: $e");
    return Future.error("파일 업로드 중 오류 발생: $e");
  }
}
