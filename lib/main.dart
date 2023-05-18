import 'package:fluent_ui/fluent_ui.dart';
import 'package:fouda_pharma/screens/home.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemTheme.accentColor.load();
  windowManager.ensureInitialized();
  await windowManager.setTitle('Fouda Pharma');
  await windowManager.setBackgroundColor(Colors.transparent);
  await windowManager.center();
  await windowManager.show();

  runApp(const MyApp());
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
        accentColor: SystemTheme.accentColor.accent.toAccentColor(),
      ),
      home: const MyHomePage(),
    );
  }
}
