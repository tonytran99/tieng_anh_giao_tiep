import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './../../../components/app_layout.dart';
import './../../../components/component_common.dart';
import './../../../db/db_topic.dart';
import './../../../localization/language_constants.dart';
import './../../../models/topic.dart';
import './../../../screens/stories_topic/stories_topic.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import './../../../utils/colors.dart';
import './../../../utils/constants.dart';

import '../../../main.dart';

class Topics extends StatefulWidget {
  final List<Topic> topicList;
  Topics({Key key, @required this.topicList}) : super(key: key);
  @override
  _TopicsState createState() => _TopicsState();
}

class _TopicsState extends State<Topics> {
  // DBTopic dbTopic;
  // List<Topic> _topicList = [];
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // width: size.width,
      // height: size.height,
      padding: EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 8.0
      ),
      // decoration: BoxDecoration(
      //   color: Color(0xFFF5F5F5),
      // ),
      child: ModalProgressHUD(
        inAsyncCall: false,
        child: SingleChildScrollView(
          child: Column(
            children: widget.topicList.map((topic) {
              File filePhoto = File(MyApp.getDirectoryApp(context, DIRECTORY_PHOTO_TOPIC).path + "/" + topic.uid + ".jpg");
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StoriesTopicScreen(
                          topic: topic
                      )));
                },
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: 8
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 16
                  ),
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: filePhoto.existsSync() ? FileImage(filePhoto) : NetworkImage(
                        topic.photo
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topic.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: googleFontNutino(
                            TextStyle(
                                color: COLOR_FFFFFF,
                                fontWeight: FontWeight.w700,
                                fontSize: 18
                            )
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child:  Text(
                          topic.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: googleFontNutino(
                              TextStyle(
                                  color: COLOR_F5F5F5,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14
                              )
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 8
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.book,
                              color: COLOR_F5F5F5,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(
                              "${topic.totalStories} ${topic.totalStories > 1 ? getTranslated(context, "home.topic.stories") : getTranslated(context, "home.topic.story")}",
                              style: googleFontNutino(
                                  TextStyle(
                                      color: COLOR_F5F5F5,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14
                                  )
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      )
    );
  }
}
