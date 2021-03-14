import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const String SAVED = 'saved';

Future<Map<String, dynamic>> setSaved(Map<String, dynamic> saved) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  if (saved != null) {
    await _prefs.setString(SAVED, jsonEncode(saved));
  } else {
    _prefs.remove(SAVED);
  }
  return saved;
}

Future<Map<String, dynamic>> getSaved() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String savedStr = _prefs.getString(SAVED);
  if (savedStr != null) {
    return jsonDecode(savedStr) as Map<String, dynamic>;
  }
  return null;
}