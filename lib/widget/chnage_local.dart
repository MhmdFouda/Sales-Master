import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fouda_pharma/providers/localization.dart';

class LocaleSegmentButton extends ConsumerWidget {
  const LocaleSegmentButton({
    super.key,
    required this.locale,
  });

  final Locale locale;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: SegmentedButton<Locale>(
        style: const ButtonStyle(
          shape: MaterialStatePropertyAll<OutlinedBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.circular(5),
            )),
          ),
        ),
        segments: const <ButtonSegment<Locale>>[
          ButtonSegment<Locale>(
            value: Locale('ar', ''),
            label: Text('Arabic'),
          ),
          ButtonSegment<Locale>(
            value: Locale('en', ''),
            label: Text('English'),
          ),
        ],
        selected: <Locale>{locale},
        onSelectionChanged: (Set<Locale> value) {
          ref.read(localizationProvider.notifier).changeLocale(value.first);
        },
      ),
    );
  }
}
