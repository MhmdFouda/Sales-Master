import 'dart:math';

import 'package:flutter/material.dart ' as material;
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
      scrollbarTheme: const ScrollbarThemeData(scrollbarColor: lightAccent),

      dividerTheme: DividerThemeData(
        thickness: 1,
        decoration: BoxDecoration(
          color: lightAccent.withOpacity(.2),
        ),
      ),

      cardColor: lightcard,

      scaffoldBackgroundColor: lightBackground,

      acrylicBackgroundColor: lightPrimary,

      menuColor: lightPrimary,

      brightness: Brightness.light,

      accentColor: lightAccent.toAccentColor(),
      // // fontFamily: 'Cairo',
      // typography: Typography.fromBrightness(
      //   brightness: Brightness.light,
      // color: Colors.purple.darkest.toAccentColor(darkestFactor: .9),
      // ),

      dialogTheme: ContentDialogThemeData(
        actionsDecoration: BoxDecoration(
          color: lightPrimary,
          borderRadius: BorderRadius.circular(8.0),
        ),
        decoration: BoxDecoration(
          color: lightBackground,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),

      navigationPaneTheme: NavigationPaneThemeData(
        selectedIconColor: ButtonState.all(lightAccent),
        unselectedTextStyle: ButtonState.all(
          const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 17.0,
          ),
        ),
        selectedTextStyle: ButtonState.all(
          const TextStyle(
            color: lightAccent,
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),
        ),
        highlightColor: lightAccent,
        backgroundColor: lightBackground,
      ),
    );
  }

  FluentThemeData darkTheme() {
    return FluentThemeData(
      scrollbarTheme: const ScrollbarThemeData(scrollbarColor: darckAccent),

      dividerTheme: DividerThemeData(
        thickness: 1,
        decoration: BoxDecoration(
          color: darckAccent.withOpacity(.2),
        ),
      ),

      cardColor: darckCard,

      scaffoldBackgroundColor: darkBackground,

      acrylicBackgroundColor: darkPrimary,

      menuColor: darkPrimary,

      brightness: Brightness.dark,

      accentColor: darckAccent.toAccentColor(),

      // typography: Typography.fromBrightness(
      //   brightness: Brightness.light,
      //   color: Colors.white.toAccentColor(),
      // ),

      dialogTheme: ContentDialogThemeData(
        actionsDecoration: BoxDecoration(
          color: darkBackground,
          borderRadius: BorderRadius.circular(8.0),
        ),
        decoration: BoxDecoration(
          color: darkPrimary,
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),

      navigationPaneTheme: NavigationPaneThemeData(
        selectedIconColor: ButtonState.all(darckAccent),
        unselectedTextStyle: ButtonState.all(
          const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 17.0,
          ),
        ),
        selectedTextStyle: ButtonState.all(
          const TextStyle(
            color: darckAccent,
            fontWeight: FontWeight.w600,
            fontSize: 20.0,
          ),
        ),
        highlightColor: darckAccent,
        backgroundColor: darkBackground,
      ),
    );
  }

  material.Color? getColor(BuildContext context, int colorIndex) {
    final brightness = FluentTheme.of(context).brightness;

    final colors =
        brightness == Brightness.light ? lightModeColors : darkModeColors;

    return colors[colorIndex];
  }
}

@Riverpod(keepAlive: true)
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
  material.Colors.red[600],
];

const darkPrimary = Color(0xFF2d2a4b);
const darkBackground = Color(0xFF000032);
const darckAccent = Color(0xFF70D9BC);
const darckCard = Color(0xFF2d2a4b);

const lightPrimary = Color(0xFFffffff);
const lightBackground = Color(0xFFf3f3f3);
const lightAccent = Color(0xFFf76794);
const lightcard = Color(0xFFffffff);
