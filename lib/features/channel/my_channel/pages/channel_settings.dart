import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/error_page.dart';
import 'package:instagram_clone/features/auth/provider/user_provider.dart';
import 'package:instagram_clone/features/channel/my_channel/repository/edit_field.dart';
import 'package:instagram_clone/features/channel/my_channel/widgets/edit_field.dart';

class MyChannelSettings extends ConsumerStatefulWidget {
  const MyChannelSettings({super.key});

  @override
  ConsumerState<MyChannelSettings> createState() => _MyChannelSettingsState();
}

class _MyChannelSettingsState extends ConsumerState<MyChannelSettings> {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return ref.watch(currentUserProvider).when(
        data: (currentUser) => Scaffold(
              body: SafeArea(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(color: Colors.blue, height: 100),
                        Positioned(
                          left: 160,
                          top: 20,
                          child: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.grey,
                            backgroundImage: CachedNetworkImageProvider(
                                currentUser.profilePic),
                          ),
                        ),
                        const Positioned(
                          right: 16,
                          height: 40,
                          child: Icon(
                            Icons.camera,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    //second part
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(currentUser.displayName),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (conetxt) => SettingsDialog(
                                      identifier: "Channel Name",
                                      onSave: (name) {
                                        ref
                                            .watch(editSettingsProvider)
                                            .editDisplayName(name);
                                      },
                                    ));
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(currentUser.username),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (conetxt) => SettingsDialog(
                                      identifier: "User Name",
                                      onSave: (name) {
                                        ref
                                            .watch(editSettingsProvider)
                                            .editUserName(name);
                                      },
                                    ));
                          },
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(currentUser.description),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (conetxt) => SettingsDialog(
                                identifier: "Description",
                                onSave: (description) {
                                  ref
                                      .watch(editSettingsProvider)
                                      .editDescription(description);
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Keep all my subscriptions private"),
                        Switch(
                          value: isSwitched,
                          onChanged: (value) {
                            isSwitched = value;
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    const Text(
                      "Chaneges made on your names and profile pictures are visible only to youtube and not to google",
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
        error: (error, Stacktrace) => const ErrorPage(),
        loading: () => const CircularProgressIndicator());
  }
}
