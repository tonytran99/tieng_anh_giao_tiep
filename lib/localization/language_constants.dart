import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './../utils/constants.dart';
import 'demo_localization.dart';

const String LANGUAGE_CODE = 'languageCode';



Future<Locale> setLocale(String languageCode) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LANGUAGE_CODE, languageCode);
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String languageCode = _prefs.getString(LANGUAGE_CODE) ?? "en";
  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return Locale(ENGLISH, 'US');
    case VIETNAMESE:
      return Locale(VIETNAMESE, "VI");
    default:
      return Locale(VIETNAMESE, 'VI');
  }
}

String getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context).translate(key);
}
