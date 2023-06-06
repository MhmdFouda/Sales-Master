import 'package:firedart/firedart.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth.g.dart';

@riverpod
Future<void> signIn(SignInRef ref,
    {required String email, required String password}) async {
  await FirebaseAuth.instance.signIn(email, password);
}

@riverpod
void signout(
  SignoutRef ref,
) async {
  FirebaseAuth.instance.signOut();
}

@riverpod
//get user email
Future<String?> getUserEmail(GetUserEmailRef ref) async {
  final user = await FirebaseAuth.instance.getUser();
  return user.email;
}
