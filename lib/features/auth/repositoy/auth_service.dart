import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod/riverpod.dart';

final authServiceProvider = Provider((ref) {
  final auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  return AuthService(auth: auth, googleSignIn: googleSignIn);
});

class AuthService {
  FirebaseAuth auth;
  GoogleSignIn googleSignIn;
  AuthService({required this.auth, required this.googleSignIn});

  singInWithGoogle() async {
    final user = await googleSignIn.signIn();
    final googleAuth = await user!.authentication;
    final credencial = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    auth.signInWithCredential(credencial);
  }
}
