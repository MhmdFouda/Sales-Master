import 'package:fluent_ui/fluent_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_theme/system_theme.dart';
part 'theme_provider.g.dart';

@riverpod
class ThemeData extends _$ThemeData {
  ThemeData() {
    _loadThemeMode();
  }
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
    _saveThemeMode(state);
  }

  // Define a private method that saves the current theme mode to shared preferences
  Future<void> _saveThemeMode(ThemeMode value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeMode', value.index);
  }

  // Define a private method that loads the previously saved theme mode from shared preferences
  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt('themeMode');
    if (index != null) {
      state = ThemeMode.values[index];
    }
  }

  FluentThemeData lightTheme() {
    return FluentThemeData(
      brightness: Brightness.light,
      accentColor: systemAccentColor(),
      activeColor: Colors.purple,
    );
  }

  FluentThemeData darkTheme() {
    return FluentThemeData(
      brightness: Brightness.dark,
      accentColor: systemAccentColor(),
    );
  }

  AccentColor systemAccentColor() {
    return AccentColor.swatch({
      'darkest': SystemTheme.accentColor.darkest,
      'darker': SystemTheme.accentColor.darker,
      'dark': SystemTheme.accentColor.dark,
      'normal': SystemTheme.accentColor.accent,
      'light': SystemTheme.accentColor.light,
      'lighter': SystemTheme.accentColor.lighter,
      'lightest': SystemTheme.accentColor.lightest,
    });
  }
}
