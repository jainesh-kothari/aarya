import 'dart:async';
import 'package:arya/language/app_translations.dart';
import 'package:arya/language/application.dart';
import 'package:flutter/material.dart';

class AppTranslationsDelegate extends LocalizationsDelegate<AppTranslations> {

  final Locale newLocale;

  const AppTranslationsDelegate({required this.newLocale});

  @override
  bool isSupported(Locale locale) {
    return application.supportedLanguagesCodes.contains(locale.languageCode);
  }

  @override
  Future<AppTranslations> load(Locale locale) {
    return AppTranslations.load(newLocale ?? locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppTranslations> old) {
    return true;
  }
}