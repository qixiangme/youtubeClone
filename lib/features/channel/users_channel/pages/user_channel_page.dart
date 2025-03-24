import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/features/auth/provider/user_provider.dart';

class UserChannelPage extends StatefulWidget {
  const UserChannelPage({super.key});

  @override
  State<UserChannelPage> createState() => _UserChannelPageState();
}

class _UserChannelPageState extends State<UserChannelPage> {
  bool haveVideos = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  color: Colors.blue,
                  height: 150,
                ),
                const Positioned(top: 75, left: 150, child: Text("data"))
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20, top: 10),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "qixiangme",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Text("data"),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: "No subscriptions",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                            TextSpan(
                              text: " No videos",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: 40,
                decoration: const BoxDecoration(color: Colors.black),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    "SUBSCRIBE",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            haveVideos
                ? Container()
                : Center(
                    child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.sizeOf(context).height * 0.2),
                    child: const Text("No videos"),
                  )),
          ],
        ),
      ),
    );
  }
}
