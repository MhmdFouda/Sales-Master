import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/theme_provider.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMod = ref.watch(themeDataProvider);
    return ScaffoldPage(
      content: Column(children: [
        ToggleSwitch(
          checked: themeMod == ThemeMode.dark,
          onChanged: (value) {
            ref.read(themeDataProvider.notifier).changeTheme(value);
          },
        ),
      ]),
    );
  }
}
