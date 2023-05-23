import 'package:firedart/firedart.dart';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/screens/navigation_view.dart';
import 'package:window_manager/window_manager.dart';

// const appId = '1:228655808143:web:7d93af7de25a4f9a70bafa';
const apiKey = 'AIzaSyCAFkGjCDiIAJxZVTcNGToCrUGVJgV94Aw';
const projectId = 'fouda-pharma';
// messagingSenderId: '228655808143',
// authDomain: 'fouda-pharma.firebaseapp.com',

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Firestore.initialize(projectId);
  windowManager.ensureInitialized();
  windowManager.setTitle('Fouda Pharma');
  windowManager.setBackgroundColor(Colors.transparent);
  windowManager.center();
  windowManager.show();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FluentApp(
      debugShowCheckedModeBanner: false,
      title: 'Fouda Pharma',
      theme: FluentThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: FluentThemeData(
        brightness: Brightness.dark,
      ),
      home: const NavigationPage(),
    );
  }
}
