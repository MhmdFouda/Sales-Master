import 'package:firedart/firedart.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/l10n/app_localizations.dart';
import 'package:fouda_pharma/providers/theme_provider.dart';
import 'package:fouda_pharma/resources/preferences_store.dart';
import 'package:fouda_pharma/screens/navigation_view.dart';
import 'package:window_manager/window_manager.dart';

// const appId = '1:228655808143:web:7d93af7de25a4f9a70bafa';
const apiKey = 'AIzaSyCAFkGjCDiIAJxZVTcNGToCrUGVJgV94Aw';
const projectId = 'fouda-pharma';
// messagingSenderId: '228655808143',
// authDomain: 'fouda-pharma.firebaseapp.com',

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAuth.initialize(apiKey, await PreferencesStore.create());

  Firestore.initialize(projectId);
  await WindowManager.instance.ensureInitialized();
  windowManager.waitUntilReadyToShow().then((_) async {
    await windowManager.setTitleBarStyle(
      TitleBarStyle.hidden,
      windowButtonVisibility: false,
    );
    await windowManager.setMinimumSize(const Size(620, 720));
    await windowManager.show();
    await windowManager.setPreventClose(true);
    await windowManager.setSkipTaskbar(false);
  });

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FluentApp(
      // localizationsDelegates: const [
      //   AppLocalizations.delegate,
      //   GlobalMaterialLocalizations.delegate,
      //   GlobalWidgetsLocalizations.delegate,
      // ],
      // supportedLocales: const [
      //   Locale('en', ''),
      //   Locale('ar', ''),
      // ],
      locale: const Locale('ar', ''),
      debugShowCheckedModeBanner: false,
      title: 'Fouda Pharma',
      themeMode: ref.watch(themeDataProvider),
      theme: ref.watch(themeDataProvider.notifier).lightTheme(),
      darkTheme: ref.watch(themeDataProvider.notifier).darkTheme(),
      home: const NavigationPage(),
    );
  }
}
