import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth.g.dart';

@riverpod
FirebaseAuth auth(AuthRef ref) {
  return FirebaseAuth.instance;
}

@riverpod
Future<void> signIn(SignInRef ref,
    {required String email, required String password}) async {
  final auth = ref.watch(authProvider);
  await auth.signInWithEmailAndPassword(email: email, password: password);
}

@riverpod
void signout(
  SignoutRef ref,
) async {
  final auth = ref.watch(authProvider);
  auth.signOut();
}

@riverpod
//get user email
Future<String?> getUserEmail(GetUserEmailRef ref) async {
  final auth = ref.watch(authProvider);
  final user = auth.currentUser;
  return user!.email;
}

// get user id
@riverpod
Future<String?> getUserId(GetUserIdRef ref) async {
  final auth = ref.watch(authProvider);
  final user = auth.currentUser;
  return user!.uid;
}
