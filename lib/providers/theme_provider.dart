import 'package:fluent_ui/fluent_ui.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeData extends _$ThemeData {
  @override
  ThemeMode build() {
    return ThemeMode.dark;
  }

  void changeTheme(bool isDark) {
    if (isDark) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
  }
}
