import 'package:flutter/material.dart';

class TabVar extends StatelessWidget {
  const TabVar({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBar(
      isScrollable: true,
      labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      indicatorSize: TabBarIndicatorSize.label,
      indicatorPadding: EdgeInsets.only(top: 12),
      tabs: [
        Text("Home"),
        Text("Videos"),
        Text("Shorts"),
        Text("Community"),
        Text("playlists"),
        Text("channels"),
        Text("about"),
      ],
    );
  }
}
