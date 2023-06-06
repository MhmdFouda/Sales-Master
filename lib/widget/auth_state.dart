import 'dart:async';

import 'package:firedart/firedart.dart';
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
  late StreamSubscription<bool> _signInStateSubscription;
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus(); // Check authentication status on app start
    var auth = FirebaseAuth.instance;
    _signInStateSubscription = auth.signInState.listen((state) {
      setState(() {
        _isSignedIn = state;
        _storeAuthStatus(); // Store the authentication status when it changes
      });
    });
  }

  @override
  void dispose() {
    _signInStateSubscription.cancel();
    super.dispose();
  }

  Future<void> _checkAuthStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isSignedIn = prefs.getBool('isSignedIn');
    if (isSignedIn != null) {
      setState(() {
        _isSignedIn = isSignedIn;
      });
    }
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
