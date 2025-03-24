import 'package:flutter/material.dart';

class TabVarView extends StatelessWidget {
  const TabVarView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 14),
      child: Column(
        children: [
          Expanded(
            child: TabBarView(children: [
              Center(
                child: Text("Home"),
              ),
              Center(
                child: Text("Videos"),
              ),
              Center(
                child: Text("Shorts"),
              ),
              Center(
                child: Text("Community"),
              ),
              Center(
                child: Text("playlist"),
              ),
              Center(
                child: Text("channel"),
              ),
              Center(
                child: Text("about"),
              )
            ]),
          ),
        ],
      ),
    );
  }
}
