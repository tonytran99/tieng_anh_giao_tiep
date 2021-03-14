import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import './../models/app_data.dart';
import './../models/story_view_options.dart';

const String APP_DATA = 'appData';

Future<AppData> setAppData(AppData appData) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  if (appData != null) {
    await _prefs.setString(APP_DATA, jsonEncode(appData));
  } else {
    await _prefs.remove(APP_DATA);
  }
  return appData;
}

Future<AppData> getAppData() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String appDataStr = _prefs.getString(APP_DATA);
  Map<String, dynamic> appDataMap;
  if (appDataStr != null) {
    appDataMap = jsonDecode(appDataStr) as Map<dynamic, dynamic>;
  }
  if (appDataMap != null) {
    final AppData storyViewOptions = AppData.fromMap(appDataMap);
    return storyViewOptions;
  }
  return null;
}

