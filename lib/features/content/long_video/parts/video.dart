// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/error_page.dart';
import 'package:instagram_clone/features/auth/model/user_model.dart';
import 'package:instagram_clone/features/auth/provider/user_provider.dart';
import 'package:instagram_clone/features/content/long_video/comment/comment_sheet.dart';
import 'package:instagram_clone/features/content/long_video/parts/post.dart';
import 'package:instagram_clone/features/upload/video_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import '../../../upload/comments/comment_model.dart';
import '../comment/comment_provider.dart';
import '../widgets/video_first_comment.dart';

class Video extends ConsumerStatefulWidget {
  final VideoModel video;
  const Video({Key? key, required this.video}) : super(key: key);

  @override
  ConsumerState<Video> createState() => _VideoState();
}

class _VideoState extends ConsumerState<Video> {
  bool isShowIcon = false;
  bool isPlaying = false;
  VideoPlayerController? _controller;
  @override
  void initState() {
    super.initState();
    _controller =
        VideoPlayerController.networkUrl(Uri.parse(widget.video.videoUrl))
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {});
          });
  }

  toogleVideoPlayer() {
    if (_controller!.value.isPlaying) {
      //pause the video
      _controller!.pause();
      isPlaying = false;
      setState(() {});
    } else {
      //play the video
      _controller!.play();
      isPlaying = true;
      setState(() {});
    }
  }

  goBackWord() {
    Duration position = _controller!.value.position;
    position = position - Duration(seconds: 1);
    _controller!.seekTo(position);
  }

  goForWord() {
    Duration position = _controller!.value.position;
    position = position + Duration(seconds: 1);
    _controller!.seekTo(position);
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final AsyncValue<UserModel> usermodel =
        ref.watch(anyUserDataProvider(widget.video.userId));

    return usermodel.when(
        data: (user) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.grey,
                elevation: 0,
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(176),
                  child: _controller!.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: GestureDetector(
                            onTap: () {
                              isShowIcon ? () {} : () {};
                            },
                            child: Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: _controller!.value.aspectRatio,
                                  child: GestureDetector(
                                      onTap: () {
                                        isShowIcon = !isShowIcon;
                                        setState(() {});
                                      },
                                      child: VideoPlayer(_controller!)),
                                ),
                                isShowIcon
                                    ? Positioned(
                                        left: 160,
                                        top: 87,
                                        child: GestureDetector(
                                          onTap: toogleVideoPlayer,
                                          child: SizedBox(
                                            height: 50,
                                            child: Icon(
                                              Icons.play_arrow,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                isShowIcon
                                    ? Positioned(
                                        left: 40,
                                        top: 87,
                                        child: GestureDetector(
                                          onTap: goBackWord,
                                          child: SizedBox(
                                            height: 50,
                                            child: Icon(
                                              Icons.play_arrow,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                isShowIcon
                                    ? Positioned(
                                        left: 300,
                                        top: 87,
                                        child: GestureDetector(
                                          onTap: goForWord,
                                          child: SizedBox(
                                            height: 50,
                                            child: Icon(
                                              Icons.play_arrow,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: SizedBox(
                                    height: 7.5,
                                    child: VideoProgressIndicator(_controller!,
                                        allowScrubbing: true),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : CircularProgressIndicator(),
                ),
              ),
              body: SafeArea(
                child: ListView(
                  children: [
                    Text(
                      widget.video.title,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 7),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Text(
                              widget.video.views.toString(),
                              style: const TextStyle(
                                fontSize: 13.4,
                                color: Color(0xff5F5F5F),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 12,
                        top: 9,
                        right: 9,
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 14,
                            backgroundImage:
                                CachedNetworkImageProvider(user.profilePic),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 5,
                            ),
                            child: Text(
                              user.displayName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Text(user.subscriptions.length.toString()),
                          SizedBox(
                            height: 35,
                            width: 100,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: TextButton(
                                child: Text("Subscribe"),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 9, top: 10.5, right: 9),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25),
                                ),
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Icon(
                                      Icons.thumb_up,
                                      size: 15.5,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.thumb_down,
                                    size: 15.5,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 9, right: 9),
                              child: TextButton(
                                child: Text("Share"),
                                onPressed: () {},
                              ),
                            ),
                            TextButton(
                              child: Text("Share"),
                              onPressed: () {},
                            ),
                            TextButton(
                              child: Text("Share"),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) =>
                              CommentSheet(video: widget.video),
                        );
                      },
                      child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          child: Consumer(
                            builder: (context, ref, child) {
                              final comments = ref.watch(
                                  commentsProvider(widget.video.videoId));

                              return comments.when(
                                data: (commentList) {
                                  if (commentList.isEmpty) {
                                    return const SizedBox(height: 20);
                                  }
                                  return VideoFirstComment(
                                    comments: commentList,
                                    user: user,
                                  );
                                },
                                loading: () => CircularProgressIndicator(),
                                error: (err, stack) => Text("Error: $err"),
                              );
                            },
                          )),
                    ),
                    SizedBox(
                      height: 300,
                      child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("videos")
                              .where("videoId",
                                  isNotEqualTo: widget.video.videoId)
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData || snapshot.data == null) {
                              return const ErrorPage();
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            final videosMap = snapshot.data!.docs;
                            final videos = videosMap
                                .map(
                                    (video) => VideoModel.fromMap(video.data()))
                                .toList();
                            return ListView.builder(
                                itemCount: videos.length,
                                itemBuilder: (content, index) {
                                  return Post(
                                    video: videos[index],
                                  );
                                });
                          }),
                    )
                  ],
                ),
              ),
            ),
        error: (error, stackTrace) => const ErrorPage(),
        loading: () => CircularProgressIndicator());
  }
}
