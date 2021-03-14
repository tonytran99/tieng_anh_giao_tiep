import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

const String LIKED = 'liked';

Future<Map<String, dynamic>> setLiked(Map<String, dynamic> liked) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  if (liked != null) {
    await _prefs.setString(LIKED, jsonEncode(liked));
  } else {
    _prefs.remove(LIKED);
  }
  return liked;
}

Future<Map<String, dynamic>> getLiked() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String likedStr = _prefs.getString(LIKED);
  if (likedStr != null) {
    return jsonDecode(likedStr) as Map<String, dynamic>;
  }
  return null;
}