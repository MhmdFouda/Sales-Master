import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:firedart/firedart.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/config.dart';

import 'package:fouda_pharma/providers/localization.dart';
import 'package:fouda_pharma/providers/theme_provider.dart';
import 'package:fouda_pharma/resources/firebase_options.dart';
// import 'package:fouda_pharma/resources/preferences_store.dart';
import 'package:fouda_pharma/widget/auth_state.dart';
import 'package:window_manager/window_manager.dart';

var indexes = [
  Index(
    collectionGroup: 'orders',
    fields: [IndexField(fieldPath: 'confirmTime', order: Order.descending)],
    queryScope: QueryScope.collection,
  ),
  Index(
    collectionGroup: 'orders',
    fields: [
      IndexField(fieldPath: 'clientName', arrayConfig: ArrayConfig.contains),
      IndexField(fieldPath: 'confirmTime', order: Order.descending)
    ],
    queryScope: QueryScope.collection,
  ),
];
const apiKey = Config.apiKey;
const projectId = Config.projectId;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  await FirebaseFirestore.instance.setIndexConfiguration(indexes: indexes);
  // FirebaseAuth.initialize(
  //   apiKey,
  //   await PreferencesStore.create(),
  // );
  if (Platform.isWindows) {
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
        windowButtonVisibility: false,
      );
      await windowManager.setMinimumSize(const Size(1100, 720));
      await windowManager.show();
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }
  // Firestore.initialize(projectId);

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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge,
        overlays: [SystemUiOverlay.top]);
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
    return FluentApp(
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
