import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/localization.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localizationProvider);
    return ScaffoldPage(
      content: Column(children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Arabic"),
                  ToggleSwitch(
                    checked: locale != const Locale('ar', ''),
                    onChanged: (value) {
                      ref
                          .read(localizationProvider.notifier)
                          .changeLocale(value);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
