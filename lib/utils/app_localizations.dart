import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:union_bank_mobile/features/data/datasources/local_data_source.dart';
import '../core/service/dependency_injection.dart';

class AppLocalizations {
  Locale locale;

  Map<String, String>? _localizedStrings;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Future<bool> load(Locale locale) async {
    this.locale = locale;
    // Save the language preference
    LocalDataSource appSharedData = injection<LocalDataSource>();
    appSharedData.setLanguage(locale.languageCode);

    //Files should be initially stored in the an array and not read every single time.
    String jsonString =
        await rootBundle.loadString('locales/${locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    return _localizedStrings![key]!;
  }
}

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an AppLocalizations object
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return ['en', 'si', 'ta'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    LocalDataSource appSharedData = injection<LocalDataSource>();
    final language = appSharedData.getLanguage();
    AppLocalizations localizations = AppLocalizations(
         language.isNotEmpty ? Locale.fromSubtags(languageCode: language) : locale);
    await localizations.load(
        language.isNotEmpty ? Locale.fromSubtags(languageCode: language) : locale);
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => true;
}

class LocaleNotifier extends StateNotifier<AppLocalizations> {
  static late LocaleNotifier instance;

  LocaleNotifier() : super(AppLocalizations(Locale('en'))) {
    instance = this;
    _initializeLocale();
  }

   Future<void> _initializeLocale() async {
    final appSharedData = injection<LocalDataSource>();
    final languageCode = appSharedData.getLanguage();
    final initialLocale = languageCode.isNotEmpty ? Locale(languageCode) : Locale('en');
    
    await _loadLocale(initialLocale);
  }

  Future<void> _loadLocale(Locale locale) async {
    await state.load(locale);
  }

  Future<void> setLocale(Locale locale) async {
    await _loadLocale(locale);
    state = AppLocalizations(locale);
  }

  static Future<void> changeLocale(Locale locale) async {
    await instance.setLocale(locale);
  }
}

final localeProvider = StateNotifierProvider<LocaleNotifier, AppLocalizations>(
  (ref) => LocaleNotifier(),
);