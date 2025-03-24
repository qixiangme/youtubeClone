import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/error_page.dart';
import 'package:instagram_clone/features/auth/provider/user_provider.dart';
import 'package:instagram_clone/features/channel/my_channel/parts/buttons.dart';
import 'package:instagram_clone/features/channel/my_channel/parts/tab_var.dart';
import 'package:instagram_clone/features/channel/my_channel/parts/tab_var_view.dart';
import 'package:instagram_clone/features/channel/my_channel/parts/top_header.dart';

class MyChannelScreen extends ConsumerWidget {
  const MyChannelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(currentUserProvider).when(
        data: (currentUser) => DefaultTabController(
              length: 7,
              child: Scaffold(
                body: Column(
                  children: [
                    TopHeaderWidget(
                      user: currentUser,
                    ),
                    const Text("More about this channel"),
                    const Buttons(),
                    const TabVar(),
                    const Expanded(
                      child: TabVarView(),
                    ),
                  ],
                ),
              ),
            ),
        error: (error, stackTrace) => const ErrorPage(),
        loading: () => const CircularProgressIndicator());
  }
}
