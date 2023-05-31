import 'package:firedart/firedart.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth.g.dart';

@riverpod
Future<void> signIn(SignInRef ref,
    {required String email, required String password}) async {
  await FirebaseAuth.instance.signIn(email, password);
}

@riverpod
Future<void> signout(
  SignoutRef ref,
) async {
  FirebaseAuth.instance.signOut();
}

@riverpod
bool authState(AuthStateRef ref) => FirebaseAuth.instance.isSignedIn;
