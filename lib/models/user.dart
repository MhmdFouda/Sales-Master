import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:fouda_pharma/providers/auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class UserApp with _$UserApp {
  factory UserApp({
    String? id,
    required String name,
    required String email,
  }) = _UserApp;

  factory UserApp.fromJson(Map<String, dynamic> json) =>
      _$UserAppFromJson(json);

// fromsnapshot
  factory UserApp.fromSnapshot(DocumentSnapshot doc) {
    return UserApp(
      id: doc['id'],
      name: doc['name'],
      email: doc['email'],
    );
  }
}

@riverpod
class AsyncUser extends _$AsyncUser {
  @override
  FutureOr<void> build() {}

// get current user
  Future<UserApp?> getCurrentUser(String id) async {
    final userCollection = FirebaseFirestore.instance.collection('users');

    final userDoc = userCollection.doc(id);
    final userSnapshot =
        await userDoc.get(const GetOptions(source: Source.cache));
    final user = UserApp.fromSnapshot(userSnapshot);
    return user;
  }

  // add user
  Future<void> addUser() async {
    final userId = await ref.watch(getUserIdProvider.future);
    final userEmail = await ref.watch(getUserEmailProvider.future);
    final user = UserApp(
      id: userId,
      name: 'Mhmd Fouda',
      email: userEmail!,
    );
    final userCollection = FirebaseFirestore.instance.collection('users');
    final userDoc = userCollection.doc(userId!);
    await userDoc.set(user.toJson());
  }

  //update user

  // deletuser
}
