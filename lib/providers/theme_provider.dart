import 'package:fluent_ui/fluent_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      accentColor: Colors.blue,
      visualDensity: VisualDensity.standard,
      focusTheme: const FocusThemeData(
        glowFactor: 0,
      ),
    );
  }

  FluentThemeData darkTheme() {
    return FluentThemeData(
      brightness: Brightness.dark,
      accentColor: Colors.blue,
      visualDensity: VisualDensity.standard,
      focusTheme: const FocusThemeData(
        glowFactor: 0,
      ),
    );
  }
}
