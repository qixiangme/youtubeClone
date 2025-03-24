import 'package:flutter/material.dart';
import 'package:instagram_clone/cores/methods.dart';

class CreateBottomSheet extends StatelessWidget {
  const CreateBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height * 0.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20, left: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("CREATE"),
              ],
            ),
          ),
          const Divider(),
          TextButton(
            child: const Text("CREATE a Shorts"),
            onPressed: () {},
          ),
          TextButton(
            child: const Text("Upload a videio"),
            onPressed: () async {
              await pickVideo(context);
            },
          ),
          TextButton(
            child: const Text("Go Live"),
            onPressed: () {},
          ),
          TextButton(
            child: const Text("Create a post"),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
