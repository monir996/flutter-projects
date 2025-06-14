import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

enum AppThemeMode { system, light, dark }

class ThemeProvider extends ChangeNotifier {

  final _box = Hive.box('settings');

  AppThemeMode _appThemeMode = AppThemeMode.system;

  ThemeProvider() {
    _loadTheme();
  }

  ThemeMode get themeMode {

    switch (_appThemeMode) {

      case AppThemeMode.light:
          return ThemeMode.light;

      case AppThemeMode.dark:
          return ThemeMode.dark;

      case AppThemeMode.system:
          return ThemeMode.system;
    }
  }

  AppThemeMode get appThemeMode => _appThemeMode;

  void setTheme(AppThemeMode mode) {
    _appThemeMode = mode;
    _box.put('themeMode', mode.index);
    notifyListeners();
  }

  void _loadTheme() {
    final index = _box.get('themeMode', defaultValue: 0);
    _appThemeMode = AppThemeMode.values[index];
  }



// final _settingsBox = Hive.box('settings'); // Only once declared
  //
  // ThemeMode _themeMode = ThemeMode.light;
  //
  // ThemeProvider() {
  //   final isDark = _settingsBox.get('isDarkMode', defaultValue: false);
  //   _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
  // }
  //
  // ThemeMode get themeMode => _themeMode;
  //
  // bool get isDarkMode => _themeMode == ThemeMode.dark;
  //
  // void toggleTheme(bool isOn) {
  //   _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
  //   _settingsBox.put('isDarkMode', isOn);
  //   notifyListeners();
  // }
}
