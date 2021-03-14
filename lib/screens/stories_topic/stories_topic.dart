import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './../../components/app_layout.dart';
import './../../components/component_common.dart';
import './../../db/db_conversation.dart';
import './../../localization/language_constants.dart';
import './../../main.dart';
import './../../models/story.dart';
import './../../models/topic.dart';
import './../../screens/story_view/story_view.dart';
import './../../shared/shared_liked.dart';
import './../../utils/colors.dart';
import './../../utils/constants.dart';

class StoriesTopicScreen extends StatefulWidget {
  final Topic topic;
  StoriesTopicScreen({Key key, @required this.topic}) : super(key: key);
  @override
  _StoriesTopicScreenState createState() => _StoriesTopicScreenState();
}

class _StoriesTopicScreenState extends State<StoriesTopicScreen> {
  DBStory dbStory;
  List<Story> _storyList = [];

  @override
  void initState() {
    super.initState();

    dbStory = DBStory();
    dbStory.getStories(widget.topic.uid).then((value) {
      setState(() {
        _storyList = value;
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
      } else {
        liked[story.uid] = story.uid;
      }
    }

    setLiked(liked).then((value) {
      MyApp.setLikedApp(context, liked);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Map<String, dynamic> liked = MyApp.getLikedApp(context);
    File fileTopicPhoto = File(MyApp.getDirectoryApp(context, DIRECTORY_PHOTO_TOPIC).path + "/" + widget.topic.uid + ".jpg");

    return Scaffold(
      appBar: AppBar(
        // title: Text('Search App'),
        backgroundColor: COLOR_065063,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),
              onPressed: () {
                // showSearch(context: context, delegate: DataSearch(listWords));
              })
        ],
      ),
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          color: COLOR_E6F0F2,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  bottom: 8
              ),
              padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 16
              ),
              height: 180,
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: fileTopicPhoto.existsSync() ? FileImage(
                    fileTopicPhoto
                  ) : NetworkImage(
                    widget.topic.photo
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.topic.name,
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
                      widget.topic.description,
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
                          "${widget.topic.totalStories} ${widget.topic.totalStories > 1 ? getTranslated(context, "home.topic.stories") : getTranslated(context, "home.topic.story")}",
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
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 8
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: _storyList.map((story) {
                      File fileStoryPhoto = File(MyApp.getDirectoryApp(context, DIRECTORY_PHOTO_STORY).path + "/" + story.uid + ".jpg");
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => StoryViewScreen(
                                story: story,
                              )));
                        },
                        child: Container(
                            height: 110,
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
                                    ) : Image.network(
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
                                          '---'
                                        ),
                                        Expanded(
                                          child: Text(
                                            story.descriptionVi,
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
