import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/cores/methods.dart';
import 'package:instagram_clone/features/upload/video_repositoy.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VideoDetailsPage extends ConsumerStatefulWidget {
  final File? video;
  const VideoDetailsPage({super.key, required this.video});

  @override
  ConsumerState<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends ConsumerState<VideoDetailsPage> {
  final titleController = TextEditingController();
  final decriptionController = TextEditingController();
  bool isThumnailselected = false;
  File? image;
  String videoId = const Uuid().v4();
  String randomNumber = const Uuid().v4();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text("Enter the Title "),
              TextField(
                controller: titleController,
                maxLines: 1,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.title),
                  hintText: "Enter the title",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              const Text("Enter the Description "),
              TextField(
                controller: decriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: "Enter the Description",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              //select thumnail
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(11),
                    ),
                  ),
                  child: TextButton(
                      onPressed: () async {
                        //pick image
                        image = await pickImage();
                        print(image);
                        print(image!.path);

                        isThumnailselected = true;
                        setState(() {});
                      },
                      child: const Text(
                        "Select Thumnual",
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
              isThumnailselected
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        image!,
                        cacheHeight: 160,
                        cacheWidth: 400,
                      ),
                    )
                  : const SizedBox(),
              isThumnailselected
                  ? Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(
                            Radius.circular(11),
                          ),
                        ),
                        child: TextButton(
                            onPressed: () async {
                              try {
                                print("퍼블리시 눌려잠");
                                print(image!.path);
                                print(widget.video);
                                //publish video
                                String thumnail = await putFileInStorage(
                                    image, randomNumber, "image");
                                String videoUrl = await putFileInStorage(
                                    widget.video, randomNumber, "video");
                                ref
                                    .watch(longVideoProvider)
                                    .uploadVideoToFirestore(
                                      videoUrl: videoUrl,
                                      thumbnail: thumnail,
                                      title: titleController.text,
                                      videoId: videoId,
                                      datePublished: DateTime.now(),
                                      userId: FirebaseAuth
                                          .instance.currentUser!.uid,
                                    );
                              } catch (e) {
                                print("❌ 퍼블리시 중 오류 발생: $e");
                              }
                            },
                            child: const Text(
                              "publish",
                              style: TextStyle(color: Colors.white),
                            )),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
