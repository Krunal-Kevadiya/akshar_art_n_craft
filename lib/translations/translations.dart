import 'package:flutter/material.dart';

class Translations {
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('hi'),
    Locale('gu')
  ];
  static const String path = 'assets/translations';
  static const Locale fallbackLocale = Locale('en', '');
}
