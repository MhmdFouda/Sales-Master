import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/screens/auth_screen.dart';
import 'package:fouda_pharma/screens/navigation_view.dart';

class AuthState extends ConsumerWidget {
  const AuthState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    return auth.tokenProvider.userId == null
        ? const NavigationPage()
        : const AuthPage();
  }
}
