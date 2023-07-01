import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/auth.dart';
import 'package:fouda_pharma/providers/localization.dart';
import 'package:fouda_pharma/screens/custom_container.dart';
import 'package:fouda_pharma/widget/chnage_local.dart';
import 'package:fouda_pharma/widget/Reusable/darkmod_toggle.dart';
import 'package:nil/nil.dart';

class SettingPage extends ConsumerWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localizationProvider);
    // final userId = ref.watch(getUserIdProvider.future);
    return ScaffoldPage(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      content: Column(
        children: [
          // Button(
          //   child: Text('transfear'),
          //   onPressed: () async {
          //     // final id = await userId;
          //     // moveCollectionsToUser(id!);
          //   },
          // ),
          ReusableContainer(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Language"),
                  LocaleSegmentButton(locale: locale),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Platform.isAndroid
              ? const ReusableContainer(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Theme Mode"),
                        DarkModToggle(),
                      ],
                    ),
                  ),
                )
              : nil,
          Platform.isAndroid
              ? ReusableContainer(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Button(
                        child: const Text('Sign Out'),
                        onPressed: () {
                          ref.read(signoutProvider);
                        },
                      )),
                )
              : nil
        ],
      ),
    );
  }
}
