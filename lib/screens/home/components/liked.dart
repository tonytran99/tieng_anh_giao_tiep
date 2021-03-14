import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './../../../components/app_layout.dart';
import './../../../components/component_common.dart';
import './../../../db/db_conversation.dart';
import './../../../main.dart';
import './../../../models/story.dart';
import './../../../models/topic.dart';
import './../../../screens/story_view/story_view.dart';
import './../../../shared/shared_liked.dart';
import './../../../utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';
import './../../../utils/constants.dart';

class Liked extends StatefulWidget {
  final List<Topic> topicList;
  Liked({Key key, @required this.topicList}) : super(key: key);
  @override
  _LikedState createState() => _LikedState();
}

class _LikedState extends State<Liked> {
  List<Story> _likedStories = [];
  DBStory dbStory;

  void initState() {
    super.initState();
    dbStory = DBStory();
    Map<String, dynamic> liked = MyApp.getLikedApp(context);
    List<String> uidList = liked != null ? liked.keys.toList() : [];
    dbStory.getStoriesWithListUid(uidList).then((value) {
      setState(() {
        _likedStories = value;
        // _isLoading = false;
      });
    });
  }
  _toggleLiked(Story story) {
    Map<String, dynamic> liked = MyApp.getLikedApp(context);
    if (liked == null) {
      liked = {
        story.uid: story.uid
      };
    } else {
      if (liked.containsKey(story.uid)) {
        liked.remove(story.uid);
        setState(() {
          _likedStories.removeWhere((likedStory) {
            return likedStory.uid == story.uid;
          });
        });
      } else {
        liked[story.uid] = story.uid;
      }
    }

    setLiked(liked).then((value) {
      MyApp.setLikedApp(context, liked);
    });
  }

  String _showTopicName(story) {
    List<Topic> topic = widget.topicList.where((topic) {
      return topic.uid == story.topicId;
    }).toList();
    if (topic.length == 0) {
      return '';
    } else {
      return topic[0].name;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // cac uid story like duoc luu vao array va luu vao share prefernce...
    Map<String, dynamic> liked = MyApp.getLikedApp(context);

    return Container(
      // width: size.width,
      // height: size.height,
        padding: EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 8.0
        ),
        decoration: BoxDecoration(
          color: COLOR_E6F0F2,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: _likedStories.map((story) {
              File fileStoryPhoto = File(MyApp.getDirectoryApp(context, DIRECTORY_PHOTO_STORY).path + "/" + story.uid + ".jpg");

              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => StoryViewScreen(
                        story: story
                      )));
                },
                child: Container(
                    height: 130,
                    margin: EdgeInsets.only(
                        bottom: 8
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8
                    ),
                    decoration: BoxDecoration(
                      color: COLOR_FFFFFF,
                      borderRadius: BorderRadius.circular(16.0),
                      // border: Border.all(
                      //   color: COLOR_F5F5F5,
                      //   width: 2
                      // )
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      // mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: fileStoryPhoto.existsSync() ? Image.file(
                              fileStoryPhoto,
                              width: 90,
                              height: 90,
                            ) :Image.network(
                              story.photo,
                              width: 90,
                              height: 90,
                            )
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (story.nameEn + " / " + story.nameVi).toUpperCase(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: googleFontNutino(
                                      TextStyle(
                                          color: COLOR_333333,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 13,
                                      )
                                  )
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Expanded(
                                  child: Text(
                                    _showTopicName(story),
                                    style: googleFontNutino(
                                        TextStyle(
                                            color: COLOR_1D243E.withOpacity(0.6),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12
                                        )
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Expanded(
                                  child: Text(
                                    story.descriptionEn,
                                    overflow: TextOverflow.ellipsis,
                                    style: googleFontNutino(
                                        TextStyle(
                                            color: COLOR_333333,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            fontStyle: FontStyle.italic
                                        )
                                    ),
                                  ),
                                ),
                                Text(
                                    '---',
                                  style: TextStyle(
                                      color: COLOR_425C5A,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    story.descriptionEn,
                                    overflow: TextOverflow.ellipsis,
                                    style: googleFontNutino(
                                        TextStyle(
                                            color: COLOR_333333,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            fontStyle: FontStyle.italic
                                        )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // unliked
                        IconButton(
                          icon: Icon(
                            liked != null && liked.containsKey(story.uid) ? Icons.favorite : Icons.favorite_outline,
                            color: COLOR_fb6767,
                          ),
                          onPressed: () {
                            _toggleLiked(story);
                          },
                        )
                      ],
                    )
                ),
              );
            }).toList(),
          ),
        )
    );
  }
}
