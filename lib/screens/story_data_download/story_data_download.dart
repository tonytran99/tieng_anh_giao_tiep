import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import './../../components/component_common.dart';
import './../../components/download_component.dart';
import './../../db/db_story.dart';
import './../../db/db_topic.dart';
import './../../localization/language_constants.dart';
import './../../main.dart';
import './../../models/app_data.dart';
import './../../models/story.dart';
import './../../models/topic.dart';
import './../../router/route_constants.dart';
import './../../screens/story_view/story_view.dart';
import './../../shared/shared_app_data.dart';
import './../../shared/shared_liked.dart';
import './../../utils/colors.dart';
import './../../utils/constants.dart';
import 'package:http/http.dart' as http;
import './../../utils/functions.dart';

class StoryDataDownloadScreen extends StatefulWidget {
  // final Topic topic;
  // StoryDataDownloadScreen({Key key, @required this.topic}) : super(key: key);
  @override
  _StoryDataDownloadScreenState createState() => _StoryDataDownloadScreenState();
}

class _StoryDataDownloadScreenState extends State<StoryDataDownloadScreen> {
  DBTopic dbTopic;
  DBStory dbStory;
  // DBTopic dbTopic;
  List<Topic> _topicList = [];
  // su dung luc update lai du lieu ty internet
  List<Topic> _topicDBList = [];
  List<Story> _storyDBList = [];
  // list Uid
  List<String> _uidTopicDBList = [];
  List<String> _uidStoryDBList = [];
  bool _checkGetTopic = false;
  bool _checkGetStory = false;
  bool _loadingFromAPI = true;
  @override
  void initState() {
    super.initState();
    dbTopic = DBTopic();
    dbStory = DBStory();
    _getDataFromDB().then((value) {
      print(_checkGetTopic);
    });
  }

  Future<dynamic> _getDataStoriesFromAPI() async {
    setState(() {
      _loadingFromAPI = false;
    });
    String apiUrl = "https://tonytran99.github.io/truyen-song-ngu-data/data.json";
    try {
      final response = await http.get(apiUrl);
      var jsonData = jsonDecode(response.body);
      if (response.statusCode == 200) {
        List<String> uidTopicServerList = [];
        List<String> uidStoryServerList = [];
        jsonData.forEach((topicKey,topicValue){
          Topic topic = Topic.fromMap(topicValue);
          uidTopicServerList.add(topic.uid);
          dbTopic.insertOrUpdate(topic);
          // download topics photo
          if (topic.photo != null && topic.photo != '') {
            downloadFile(
              topic.photo,
              topic.uid + ".jpg",
              MyApp.getDirectoryApp(context, DIRECTORY_PHOTO_TOPIC) != null ?  MyApp.getDirectoryApp(context, DIRECTORY_PHOTO_TOPIC).path : ''
            );
          }
          Map<String, dynamic>  stories = Map<String, dynamic>.from(topicValue['stories']);
          stories.forEach((storyKey, storyValue) {
            Story story = Story.fromMap(storyValue);
            uidStoryServerList.add(story.uid);
            story.topicId = topicKey;
            dbStory.insertOrUpdate(story);
            // download story photo
            if (story.photo != null && story.photo != '') {
              downloadFile(
                  story.photo,
                  story.uid + ".jpg",
                  MyApp.getDirectoryApp(context, DIRECTORY_PHOTO_STORY) != null ?  MyApp.getDirectoryApp(context, DIRECTORY_PHOTO_STORY).path : ''
              );
            }
          });
        });
        _uidTopicDBList.asMap().forEach((key, uidTopic) {
          if (!uidTopicServerList.contains(uidTopic)) {
            dbTopic.delete(uidTopic);
          }
        });
        _uidStoryDBList.asMap().forEach((key, uidStory) {
          if (!uidStoryServerList.contains(uidStory)) {
            dbStory.delete(uidStory);
          }
        });
        // get api check-update
        String apiUrlCheckUpdate = "https://tonytran99.github.io/truyen-song-ngu-data/check-update.json";
        try {
          final response = await http.get(apiUrlCheckUpdate);
          var jsonData = jsonDecode(response.body);
          if (response.statusCode == 200) {
           if (jsonData["lastUpdatedAt"] != null) {
             AppData appData = MyApp.getAppDataApp(context);
             appData.lastUpdate = jsonData["lastUpdatedAt"];
             setAppData(appData).then((value) {
               MyApp.setAppDataApp(context, value);
             });
             Navigator.of(context).pushReplacementNamed(homeRoute);
           }
          } else {
            print("error2");
          }
        } catch (e) {
          print(e);
          print("catch2");
        }
      } else {
        print("error");
      }
    } catch (e) {
      print(e);
      print("catch1");
    }
  }
  Future<dynamic> _getDataFromDB() async {
    Future<List<Topic>> topics = dbTopic.getTopics();
    topics.then((value) {
      List<Topic> topicDBList = value;
      List<String> uidTopicDBList = [];
      topicDBList.asMap().forEach((key, topic) {
        uidTopicDBList.add(topic.uid);
      });
      setState(() {
        _topicDBList = topicDBList;
        _uidTopicDBList = uidTopicDBList;
        _checkGetTopic = true;
      });
    });
    Future<List<Story>> stories = dbStory.getStories(null);
    stories.then((value) {
      List<Story> storyDBList = value;
      List<String> uidStoryDBList = [];
      storyDBList.asMap().forEach((key, topic) {
        uidStoryDBList.add(topic.uid);
      });
      setState(() {
        _storyDBList = storyDBList;
        _uidStoryDBList = uidStoryDBList;
        _checkGetStory = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_checkGetTopic && _checkGetStory && _loadingFromAPI) {
      _getDataStoriesFromAPI();
    }
    return Scaffold(
      body: DownloadComponent(

      ),
    );
  }
}
