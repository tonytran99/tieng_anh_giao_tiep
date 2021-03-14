import 'package:flutter/material.dart';
import './../screens/home/home.dart';
import './../screens/settings/settings.dart';
import './../screens/story_data_download/story_data_download.dart';
import './../screens/story_view/story_view.dart';
import 'route_constants.dart';

class CustomRouter {
  static Route<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case homeRoute:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case settingsRoute:
        return MaterialPageRoute(builder: (_) => SettingsScreen());
      case storyDataDownloadRoute:
        return MaterialPageRoute(builder: (_) => StoryDataDownloadScreen());
      default:
        return MaterialPageRoute(builder: (_) => HomeScreen());
    }
  }
}
