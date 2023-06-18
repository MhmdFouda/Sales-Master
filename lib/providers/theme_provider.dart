import 'dart:math';
import 'package:flutter/material.dart ' as material;
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
      // scaffoldBackgroundColor: Colors.purple.lightest,
      acrylicBackgroundColor: Colors.purple.lightest,
      menuColor: Colors.purple.lighter.withOpacity(.7),
      brightness: Brightness.light,
      accentColor: Colors.purple,
      typography: Typography.fromBrightness(
        brightness: Brightness.light,
        color: Colors.purple.darkest.toAccentColor(darkestFactor: .9),
      ),
      dialogTheme: ContentDialogThemeData(
        barrierColor: Colors.purple.lighter,
        actionsDecoration: BoxDecoration(
          color: Colors.purple.lighter,
          borderRadius: BorderRadius.circular(8.0),
        ),
        decoration: BoxDecoration(
          color: Colors.purple.lightest,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      navigationPaneTheme: NavigationPaneThemeData(
        unselectedTextStyle: ButtonState.all(
          const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 16.0,
          ),
        ),
        selectedTextStyle: ButtonState.all(
          const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),
        highlightColor: Colors.purple.lightest,
        backgroundColor: Colors.purple.lighter,
      ),
    );
  }

  FluentThemeData darkTheme() {
    return FluentThemeData(
      // scaffoldBackgroundColor: Colors.purple.darkest,
      acrylicBackgroundColor: Colors.purple.darkest,
      menuColor: Colors.purple.darker.withOpacity(.5),
      brightness: Brightness.dark,
      accentColor: Colors.yellow,
      typography: Typography.fromBrightness(
        brightness: Brightness.light,
        color: Colors.white.toAccentColor(),
      ),
      dialogTheme: ContentDialogThemeData(
        actionsDecoration: BoxDecoration(
          color: Colors.purple.darkest,
          borderRadius: BorderRadius.circular(8.0),
        ),
        decoration: BoxDecoration(
          color: Colors.purple.darker,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      navigationPaneTheme: NavigationPaneThemeData(
        unselectedTextStyle: ButtonState.all(
          const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16.0,
          ),
        ),
        selectedTextStyle: ButtonState.all(
          const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 18.0,
          ),
        ),
        backgroundColor: Colors.purple.darkest,
        highlightColor: Colors.purple.lighter,
      ),
    );
  }

  AccentColor systemAccentColor() {
    return AccentColor.swatch(
      {
        'darkest': SystemTheme.accentColor.darkest,
        'darker': SystemTheme.accentColor.darker,
        'dark': SystemTheme.accentColor.dark,
        'normal': SystemTheme.accentColor.accent,
        'light': SystemTheme.accentColor.light,
        'lighter': SystemTheme.accentColor.lighter,
        'lightest': SystemTheme.accentColor.lightest,
      },
    );
  }

  material.Color? getColor(BuildContext context, int colorIndex) {
    final brightness = FluentTheme.of(context).brightness;

    final colors =
        brightness == Brightness.light ? lightModeColors : darkModeColors;

    return colors[colorIndex];
  }
}

@riverpod
int getRandomInt(GetRandomIntRef ref) {
  final random = Random();
  final index = random.nextInt(darkModeColors.length);
  return index;
}

final List<material.Color?> lightModeColors = [
  material.Colors.purple[100],
  material.Colors.brown[100],
  material.Colors.pink[100],
  material.Colors.blue[100],
  material.Colors.red[100],
  material.Colors.teal[100],
  material.Colors.cyan[100],
  material.Colors.indigo[100],
  material.Colors.lime[100],
];
final List<material.Color?> darkModeColors = [
  material.Colors.purple[600],
  material.Colors.purple[900],
  material.Colors.pink[700],
  material.Colors.blue[600],
  material.Colors.blueGrey[800],
  material.Colors.teal[600],
  material.Colors.cyan[600],
  material.Colors.indigo[600],
  material.Colors.lime[600],
];
