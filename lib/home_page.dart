import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/error_page.dart';
import 'package:instagram_clone/features/account/account_page.dart';
import 'package:instagram_clone/features/auth/provider/user_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:instagram_clone/features/content/bottom_navigationbar.dart';
import 'package:instagram_clone/features/upload/upload_bottom_sheet.dart';
import 'package:instagram_clone/pages.list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Consumer(
                builder: (context, ref, child) {
                  print("Consumer 실행됨!"); //
                  return ref.watch(currentUserProvider).when(
                        data: (currentUser) {
                          print("Profile Pic URL: ${currentUser.profilePic}");

                          return Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AccountPage(user: currentUser),
                                  ),
                                );
                              },
                              child: CircleAvatar(
                                radius: 15,
                                backgroundImage: CachedNetworkImageProvider(
                                    currentUser.profilePic),
                              ),
                            ),
                          );
                        },
                        error: (error, stackTrace) => const ErrorPage(),
                        loading: () => const CircularProgressIndicator(),
                      );
                },
              ),
              Flexible(child: pages[currentIndex])
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigation(
          onPressed: (index) {
            if (index != 2) {
              currentIndex = index;
              setState(() {});
            } else {
              return showModalBottomSheet(
                  context: context,
                  builder: (context) => const CreateBottomSheet());
            }
          },
        ));
  }
}
