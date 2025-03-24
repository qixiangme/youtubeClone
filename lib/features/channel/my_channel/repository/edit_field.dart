import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final editSettingsProvider = Provider((ref) => EditSettingField(
      firestore: FirebaseFirestore.instance,
      auth: FirebaseAuth.instance,
    ));

class EditSettingField {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  EditSettingField({required this.firestore, required this.auth});

  editDisplayName(displayName) async {
    final user = auth.currentUser;
    await firestore.collection("users").doc(user!.uid).update({
      "displayName": displayName,
    });
  }

  editUserName(userName) async {
    final user = auth.currentUser;
    await firestore.collection("users").doc(user!.uid).update({
      "UserName": userName,
    });
  }

  editDescription(description) async {
    final user = auth.currentUser;
    await firestore.collection("users").doc(user!.uid).update({
      "description": description,
    });
  }
}
