import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './../../components/app_layout.dart';
import './../../components/component_common.dart';
import './../../localization/language_constants.dart';
import './../../models/story.dart';
import './../../models/story_view_options.dart';
import './../../models/topic.dart';
import './../../screens/story_view/components/dictionary_view.dart';
import './../../shared/shared_story_view_options.dart';
import './../../utils/colors.dart';
import './../../utils/constants.dart';
import './../../utils/functions.dart';

import 'components/play_audio.dart';
import 'components/switch_dictionary.dart';
class StoryViewScreen extends StatefulWidget {
  final Story story;
  StoryViewScreen({Key key, @required this.story}) : super(key: key);
  @override
  _StoryViewScreenState createState() => _StoryViewScreenState();
}

class _StoryViewScreenState extends State<StoryViewScreen> with SingleTickerProviderStateMixin {
  TabController _tabController;
  StoryViewOptions _storyViewOptions;

  @override
  void initState() {
    super.initState();
    getStoryViewOptions().then((value) {
      if (value != null) {
        setState(() {
          _storyViewOptions = value;
        });
      } else {
        setState(() {
          _storyViewOptions = StoryViewOptions(STORY_VIEW_FONT_SIZE_DEFAULT, STORY_VIEW_DICTIONARY_DEFAULT);
        });
        setStoryViewOptions(_storyViewOptions);
      }
    });
    // setStoryViewOptions(null);
    _tabController = TabController(vsync: this, length: 2);
  }
  _changeOptionsDictionary(dictionary) {
    setState(() {
      _storyViewOptions.dictionary = dictionary;
    });
    setStoryViewOptions(_storyViewOptions);
  }
  _changeOptionsFontSize(changeFontSize) {
    double fontSizeNew = _storyViewOptions.fontSize + changeFontSize;
    if (
      fontSizeNew >= STORY_VIEW_FONT_SIZE_MIN
      && fontSizeNew <= STORY_VIEW_FONT_SIZE_MAX
    ) {
      setState(() {
        _storyViewOptions.fontSize = fontSizeNew;
      });
      setStoryViewOptions(_storyViewOptions);
    }
  }

  List<TextSpan>_showContentEn() {
    Size size = MediaQuery.of(context).size;
    List<String> listCharacterContentEn = widget.story.contentEn.split(" ");
    List<TextSpan> listTextSpanView = [];
    listCharacterContentEn.asMap().forEach((index, item) {
      listTextSpanView.add(
          TextSpan(
              text: item,
              recognizer: new TapGestureRecognizer()..onTap = () {
                if (cleanWord(item) != '') {
                  return showDialog<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                          insetPadding: EdgeInsets.all(10),
                          child: Container(
                            height: 400,
                            width: size.width-120,
                            color: COLOR_E6F0F2,
                            child: Stack(
                                overflow: Overflow.visible,
                                children: <Widget>[
                                  Positioned(
                                    right: -15,
                                    top: -15,
                                    child: InkResponse(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: CircleAvatar(
                                        child: Icon(Icons.close),
                                        backgroundColor: COLOR_065063,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 25,
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child:  Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            _storyViewOptions.dictionary == DICTIONARY_EN_EN ? getTranslated(context, "story_view.label.dictionary_en_en").toUpperCase() : getTranslated(context, "story_view.label.dictionary_en_vi").toUpperCase(),
                                            style: googleFontNutino(
                                                TextStyle(
                                                    color: COLOR_001529,
                                                    fontWeight: FontWeight.w600
                                                )
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              width: size.width-120,
                                              color: Colors.red,
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8,
                                                  horizontal: 8
                                              ),
                                              child: DictionaryView(
                                                word: cleanWord(item)
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                          )
                      );
                    },
                  );
                }
              }
          )
      );
      listTextSpanView.add(
        TextSpan(
          text: " ",
        )
      );
    });
    return listTextSpanView;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: COLOR_E6F0F2,
        child: Column(
          children: [
            // setting view
            Container(
              padding: EdgeInsets.only(
                top: 32,
                bottom: 8,
                right: 16
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: 60,
                      child: Icon(
                        Icons.arrow_back,
                      ),
                    ),
                  ),
                  Spacer(),
                  _storyViewOptions != null ? Container(
                    // width: 160,
                    child: SwitchDictionary(
                      dictionary: _storyViewOptions.dictionary,
                      changeDictionary: (dictionary) {
                        _changeOptionsDictionary(dictionary);
                      }
                    ),
                  ) : SizedBox(),
                  SizedBox(
                    width: 16,
                  ),
                  Container(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            if (_storyViewOptions.fontSize > STORY_VIEW_FONT_SIZE_MIN) {
                              _changeOptionsFontSize(-1);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: COLOR_FFFFFF,
                                shape: BoxShape.circle
                            ),
                            child: Icon(
                              Icons.zoom_out,
                              color: COLOR_001529,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        InkWell(
                          onTap: () {
                            if (_storyViewOptions.fontSize < STORY_VIEW_FONT_SIZE_MAX) {
                              _changeOptionsFontSize(1);
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: COLOR_FFFFFF,
                                shape: BoxShape.circle
                            ),
                            child: Icon(
                              Icons.zoom_in,
                              color: COLOR_001529,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            widget.story.audio != null ? Container(
              height: 80,
              padding: EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8
              ),
              child: PlayAudio(
                audio: widget.story.audio,
                story: widget.story
              )
            ) : SizedBox(),
            Container(
              child: TabBar(
                tabs: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 0
                    ),
                    child: Text(
                      getTranslated(context, "story_view.tab.english").toUpperCase(),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 0
                    ),
                    child: Text(
                      getTranslated(context, "story_view.tab.vietnamese").toUpperCase(),
                    ),
                  ),
                ],
                controller: _tabController,
                labelColor: COLOR_001529,
                indicatorColor: COLOR_001529,
                labelStyle: googleFontNutino(
                  TextStyle(
                    fontWeight: FontWeight.w600
                  )
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 16, 8, 32),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              child: Text(
                                widget.story.nameEn,
                                style: googleFontNutino(
                                  TextStyle(
                                    color: COLOR_065063,
                                    fontSize: 21,
                                    fontWeight: FontWeight.w700
                                  )
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                  style: googleFontNutino(
                                      TextStyle(
                                          color: COLOR_001529,
                                          fontSize: _storyViewOptions != null ? _storyViewOptions.fontSize : STORY_VIEW_FONT_SIZE_DEFAULT
                                      )
                                  ),
                                  children: _showContentEn()
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(8, 16, 8, 32),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              child: Text(
                                widget.story.nameVi,
                                style: googleFontNutino(
                                    TextStyle(
                                        color: COLOR_065063,
                                        fontSize: 21,
                                        fontWeight: FontWeight.w700
                                    )
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              widget.story.contentVi,
                              style: googleFontNutino(
                                  TextStyle(
                                      color: COLOR_001529,
                                      fontSize: _storyViewOptions != null ? _storyViewOptions.fontSize : STORY_VIEW_FONT_SIZE_DEFAULT
                                  )
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                  controller: _tabController,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
