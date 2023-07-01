import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:fouda_pharma/screens/auth_screen.dart';
import 'package:fouda_pharma/screens/navigation_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthState extends StatefulWidget {
  const AuthState({Key? key}) : super(key: key);

  @override
  State<AuthState> createState() => _AuthStateState();
}

class _AuthStateState extends State<AuthState> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      setState(() {
        _isSignedIn = user != null;
        _storeAuthStatus();
      });
    });
  }

  Future<void> _checkAuthStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _isSignedIn = user != null;
    });
  }

  Future<void> _storeAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isSignedIn', _isSignedIn);
  }

  @override
  Widget build(BuildContext context) {
    return _isSignedIn ? const NavigationPage() : const AuthPage();
  }
}
