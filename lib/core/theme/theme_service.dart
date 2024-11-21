// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: constant_identifier_names

import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:union_bank_mobile/core/theme/theme_data.dart';

class AppTheme {
  ThemeData themeData;
  ThemeType themeType;
  AppTheme({
    required this.themeData,
    required this.themeType,
  });
}

enum ThemeType { LIGHT, DARK, RED }


final List<AppTheme> themes = [
  AppTheme(themeData: getAppTheme(ThemeType.LIGHT), themeType: ThemeType.LIGHT),
  AppTheme(themeData: getAppTheme(ThemeType.DARK), themeType: ThemeType.DARK),
  AppTheme(themeData: getAppTheme(ThemeType.RED), themeType: ThemeType.RED)
];

final themeProvider = StateNotifierProvider<ThemeNotifier, AppTheme>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<AppTheme> {
  late SharedPreferences _prefs;

  ThemeNotifier() : super(themes.first) {
    _loadThemePreference();
  }

  void switchTheme(ThemeType themeType) {
    state = themes.firstWhere((theme) => theme.themeType == themeType,orElse: () => AppTheme(themeData: getAppTheme(ThemeType.LIGHT), themeType: ThemeType.LIGHT));
    _saveThemePreference(state);
  }

  Future<void> _saveThemePreference(AppTheme theme) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setString('theme', theme.themeType.toString());
  }

  Future<void> _loadThemePreference() async {
    _prefs = await SharedPreferences.getInstance();
    final defaultTheme = PlatformDispatcher.instance.platformBrightness == Brightness.light ? ThemeType.LIGHT.toString() : ThemeType.DARK.toString();
    log(defaultTheme);
    final themeTypeString = _prefs.getString('theme') ?? defaultTheme;
    final themeType = ThemeType.values.firstWhere((e) => e.toString() == themeTypeString,orElse: () => ThemeType.LIGHT,);
    state = themes.firstWhere((theme) => theme.themeType == themeType,orElse: () => AppTheme(themeData: getAppTheme(ThemeType.LIGHT), themeType: ThemeType.LIGHT),);
  }
}