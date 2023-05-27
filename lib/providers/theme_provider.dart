import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = StateNotifierProvider<ThemeData, ThemeMode>(
  (ref) => ThemeData(),
);

class ThemeData extends StateNotifier<ThemeMode> {
  ThemeData() : super(ThemeMode.dark);

  void changeTheme(bool isDark) {
    if (isDark) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
  }
}
