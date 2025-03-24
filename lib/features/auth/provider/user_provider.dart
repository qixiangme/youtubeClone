import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:instagram_clone/features/auth/repositoy/user_data_service.dart';
import 'package:instagram_clone/features/auth/model/user_model.dart';

final currentUserProvider = FutureProvider<UserModel>((ref) async {
  final UserModel user =
      await ref.watch(userDataServiceProvider).fetchCurrentUserData();
  return user;
}); //FutureProvider는 비동기로 데이터를 가져올 때 사용

final anyUserDataProvider = FutureProvider.family((ref, userId) async {
  final UserModel user =
      await ref.watch(userDataServiceProvider).fetchAnyUserData(userId);
  return user;
});
