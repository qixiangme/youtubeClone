import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/features/auth/repositoy/auth_service.dart';
import 'package:riverpod/riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("YOUTUBE"),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 55),
                child: GestureDetector(
                  child: const Text("SING WITH GOOGLE"),
                  onTap: () {
                    ref.read(authServiceProvider).singInWithGoogle();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
