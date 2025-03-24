import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/features/auth/model/user_model.dart';
import 'package:riverpod/riverpod.dart';

final userDataServiceProvider = Provider((ref) => UserDataService(
    auth: FirebaseAuth.instance, firestore: FirebaseFirestore.instance));

class UserDataService {
  FirebaseAuth auth;
  FirebaseFirestore firestore;
  UserDataService({required this.auth, required this.firestore});
  addUserDataToFirestore(
      {required String displayName,
      required String username,
      required String email,
      required String profilePic,
      List? subscriptions,
      int? videos,
      String? userId,
      required String description,
      String? type}) async {
    UserModel user = UserModel(
      displayName: displayName,
      username: username,
      email: email,
      profilePic: profilePic,
      subscriptions: [],
      videos: 0,
      userId: auth.currentUser!.uid,
      description: description,
      type: "user",
    );
    await firestore.collection("users").doc(auth.currentUser!.uid).set(user
        .toMap()); //toMap -> 내가 만든거임 ㅋㅋ 이거는 UserModel에 있는거임 Map으로 변환시킴(FIREBASE에 넣을 수 있게)
  }

  Future<UserModel> fetchCurrentUserData() async {
    final currentUserMap =
        await firestore.collection("users").doc(auth.currentUser!.uid).get();
    UserModel user = UserModel.fromMap(currentUserMap.data()!);
    return user;
  }
    Future<UserModel> fetchAnyUserData(userid) async {
    final currentUserMap =
        await firestore.collection("users").doc(userid).get();
    UserModel user = UserModel.fromMap(currentUserMap.data()!);
    return user;
  }
}
