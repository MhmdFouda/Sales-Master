import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firedart/firedart.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/localization.dart';
import 'package:fouda_pharma/providers/theme_provider.dart';
import 'package:fouda_pharma/resources/preferences_store.dart';
import 'package:fouda_pharma/widget/auth_state.dart';
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
    await windowManager.setMinimumSize(const Size(900, 720));
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
    final theme = ref.watch(themeDataProvider.notifier);
    return FluentApp(
      color: theme.systemAccentColor(),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: ref.watch(localizationProvider),
      debugShowCheckedModeBanner: false,
      title: 'Fouda Pharma',
      themeMode: ref.watch(themeDataProvider),
      theme: ref.watch(themeDataProvider.notifier).lightTheme(),
      darkTheme: ref.watch(themeDataProvider.notifier).darkTheme(),
      home: const AuthState(),
    );
  }
}
