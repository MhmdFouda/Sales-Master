import 'package:fluent_ui/fluent_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
part 'localization.g.dart';

@riverpod
class Localization extends _$Localization {
  @override
  Locale build() => const Locale('ar', '');

  // change locale to english
  void changeLocale(bool isEnglish) {
    if (isEnglish) {
      state = const Locale('en', '');
    } else {
      state = const Locale('ar', '');
    }
  }
}

@riverpod
AppLocalizations appLocalizations(AppLocalizationsRef ref) {
  final binding = WidgetsBinding.instance;
  ref.state = lookupAppLocalizations(basicLocaleListResolution(
      [binding.platformDispatcher.locale], AppLocalizations.supportedLocales));
  // update afterwards
  final observer = _LocaleObserver((locales) {
    ref.state = lookupAppLocalizations(basicLocaleListResolution(
        [binding.platformDispatcher.locale],
        AppLocalizations.supportedLocales));
  });

  binding.addObserver(observer);
  ref.onDispose(() => binding.removeObserver(observer));
  return ref.state;
}

/// observed used to notify the caller when the locale changes
class _LocaleObserver extends WidgetsBindingObserver {
  _LocaleObserver(this._didChangeLocales);
  final void Function(List<Locale>? locales) _didChangeLocales;
  @override
  void didChangeLocales(List<Locale>? locales) {
    _didChangeLocales(locales);
  }
}
