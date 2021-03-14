import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import './../models/story_view_options.dart';

const String STORY_VIEW_OPTIONS = 'storyViewOptions';

Future<StoryViewOptions> setStoryViewOptions(StoryViewOptions storyViewOptions) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  if (storyViewOptions != null) {
    await _prefs.setString(STORY_VIEW_OPTIONS, jsonEncode(storyViewOptions));
  } else {
    await _prefs.remove(STORY_VIEW_OPTIONS);
  }
  return storyViewOptions;
}

Future<StoryViewOptions> getStoryViewOptions() async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String storyViewOptionsStr = _prefs.getString(STORY_VIEW_OPTIONS);
  Map<String, dynamic> storyViewOptionsMap;
  if (storyViewOptionsStr != null) {
    storyViewOptionsMap = jsonDecode(storyViewOptionsStr) as Map<dynamic, dynamic>;
  }
  if (storyViewOptionsMap != null) {
    final StoryViewOptions storyViewOptions = StoryViewOptions.fromMap(storyViewOptionsMap);
    return storyViewOptions;
  }
  return null;
}

