import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/localization.dart';
import 'package:fouda_pharma/widget/chnage_local.dart';
import 'package:fouda_pharma/widget/darkmod_toggle.dart';

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
              ListTile(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: FluentTheme.of(context).borderInputColor,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(6),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Language"),
                    LocaleSegmentButton(locale: locale),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Platform.isAndroid
                  ? ListTile(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: FluentTheme.of(context).borderInputColor,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      title: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Dark Mode"),
                          DarkModToggle(),
                        ],
                      ),
                    )
                  : const SizedBox(
                      height: 1,
                    ),
            ],
          ),
        ),
      ]),
    );
  }
}
