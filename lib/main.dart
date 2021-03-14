import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'models/app_data.dart';
import 'shared/shared_app_data.dart';
import 'shared/shared_liked.dart';
import 'shared/shared_saved.dart';
import 'utils/colors.dart';
import 'utils/constants.dart';
import 'localization/demo_localization.dart';
import 'localization/language_constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'router/custom_router.dart';
import 'router/route_constants.dart';
import 'package:http/http.dart' as http;

import 'models/topic.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatefulWidget {
  MyApp ({Key key}):super(key: key);
  static void setLocaleApp(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocaleApp(newLocale);
  }
  static Locale getLocaleApp(BuildContext context) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    return state.getLocaleApp();
  }
  static void setLikedApp(BuildContext context, Map<String, dynamic> liked) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLikedApp(liked);
  }
  static Map<String, dynamic> getLikedApp(BuildContext context) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    return state.getLikedApp();
  }
  static void setSavedApp(BuildContext context, Map<String, dynamic> saved) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setSavedApp(saved);
  }
  static Map<String, dynamic> getSavedApp(BuildContext context) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    return state.getSavedApp();
  }
  static void setAppDataApp(BuildContext context, AppData appData) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setAppDataApp(appData);
  }
  static AppData getAppDataApp(BuildContext context) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    return state.getAppDataApp();
  }
  static Directory getDirectoryApp(BuildContext context, String directoryCode) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    return state.getDirectoryApp(directoryCode);
  }
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  Map<String, dynamic> _liked;
  Map<String, dynamic> _saved;
  AppData _appData;
  String _checkInitialRoute;
  Directory _directoryPhotoTopic;
  Directory _directoryPhotoStory;
  Directory _directoryAudioStory;

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  _setDirectory() async {
    Directory directory;
    if (await _requestPermission(Permission.storage)) {
      directory = await getExternalStorageDirectory();
    }
    if (!await directory.exists()) {
      await directory.create(recursive: true);
    }
    Directory directoryPhotoTopic = Directory(directory.path + "/photos/topics");
    Directory directoryPhotoStory = Directory(directory.path + "/photos/stories");
    Directory directoryAudioStory = Directory(directory.path + "/audios/stories");
    if (!await directoryPhotoTopic.exists()) {
      await directoryPhotoTopic.create(recursive: true);
    }
    if (!await directoryPhotoStory.exists()) {
      await directoryPhotoStory.create(recursive: true);
    }
    if (!await directoryAudioStory.exists()) {
      await directoryAudioStory.create(recursive: true);
    }
    setState(() {
      _directoryPhotoTopic = directoryPhotoTopic;
      _directoryPhotoStory = directoryPhotoStory;
      _directoryAudioStory = directoryAudioStory;
    });
    _getAppDataInfo();
  }

  Directory getDirectoryApp(String directoryCode) {
    switch(directoryCode) {
      case DIRECTORY_PHOTO_TOPIC:
        return _directoryPhotoTopic;
      case DIRECTORY_PHOTO_STORY:
        return _directoryPhotoStory;
      case DIRECTORY_AUDIO_STORY:
        return _directoryAudioStory;
      default:
        return null;
    }
  }

  @override
  void initState() {
    super.initState();
    // _setDirectory();
    // _getLikedFromShared();
    // _getSavedFromShared();
    // _getDataStories();
    setState(() {
      _checkInitialRoute = homeRoute;
    });
  }
  _getAppDataInfo() {
    getAppData().then((value) {
      // AppData appData = AppData(
      //     dictionaryEnEnOffline: false,
      //     dictionaryEnViOffline: false,
      //     lastUpdate: null
      // );
      // setAppData(appData).then((value) {
      //   setState(() {
      //     _appData = value;
      //   });
      // });
      if (value == null) {
        AppData appData = AppData(
          dictionaryEnEnOffline: false,
          dictionaryEnViOffline: false,
          lastUpdate: null
        );
        setAppData(appData).then((value) {
          setState(() {
            _appData = value;
          });
        });
      } else {
        setState(() {
          _appData = value;
          _checkInitialRoute = value.lastUpdate == null ? storyDataDownloadRoute : homeRoute;
        });
      }
    });
  }

  _getLikedFromShared() {
    getLiked().then((liked) {
      setState(() {
        _liked = liked;
      });
    });
  }
  setLikedApp(Map<String, dynamic> liked) {
    setState(() {
      _liked = liked;
    });
  }
  Map<String, dynamic> getLikedApp() {
    return _liked;
  }

  _getSavedFromShared() {
    getSaved().then((saved) {
      setState(() {
        _saved = saved;
      });
    });
  }
  setSavedApp(Map<String, dynamic> saved) {
    setState(() {
      _saved = saved;
    });
  }
  Map<String, dynamic> getSavedApp() {
    return _saved;
  }

  setLocaleApp(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }
  Locale getLocaleApp() {
    return _locale;
  }

  setAppDataApp(AppData appData) {
    setState(() {
      _appData = appData;
    });
  }

  AppData getAppDataApp() {
    return _appData;
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) {
      setState(() {
        this._locale = locale;
      });
    });
    super.didChangeDependencies();
  }


  Widget build(BuildContext context) {
    print(_checkInitialRoute);
    if (this._locale == null) {
      return Container(
        color: COLOR_E6F0F2,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: COLOR_90cdd8,
            valueColor: AlwaysStoppedAnimation<Color>(COLOR_065063)
          ),
        ),
      );
    } else {
      return MaterialApp(
        title: 'Ilico',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // primaryColor: PRIMARY_COLOR,
          // accentColor: ACCENT_COLOR,
        ),
        locale: _locale,
        supportedLocales: [
          Locale("en", "US"),
          Locale("vi", "VI")
        ],
        localizationsDelegates: [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        onGenerateRoute: CustomRouter.generatedRoute,
        initialRoute: _checkInitialRoute,
      );
    }
  }
}