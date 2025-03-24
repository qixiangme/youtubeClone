import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  const Buttons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Container(
            height: 41,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
              color: Colors.grey[300],
            ),
            child: TextButton(
              child: const Text("Manage Text"),
              onPressed: () {},
            ),
          ),
        ),
        Expanded(
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.edit))),
        Expanded(
            child: IconButton(onPressed: () {}, icon: const Icon(Icons.edit)))
      ],
    );
  }
}
