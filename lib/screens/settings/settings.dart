import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './../../components/app_layout.dart';
import './../../components/component_common.dart';
import './../../components/switch_language.dart';
import './../../localization/language_constants.dart';
import './../../models/story_view_options.dart';
import './../../screens/story_view/components/switch_dictionary.dart';
import './../../shared/shared_story_view_options.dart';
import './../../utils/colors.dart';
import './../../utils/constants.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  StoryViewOptions _storyViewOptions;
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

  TextStyle textStyleLabel() {
    return googleFontNutino(
        TextStyle(
            color: COLOR_001529,
            fontWeight: FontWeight.w700,
            fontSize: 12
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: COLOR_E6F0F2,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: COLOR_065063, //change your color here
        ),
        title: Text(
          getTranslated(context, "drawer.label.settings"),
          style: googleFontMontserrat(
              TextStyle(
                  color: COLOR_001034,
                  fontWeight: FontWeight.w500
              )
          ),
        ),
        // actions: [
        //   SwitchLanguage()
        // ],
      ),
      body: Container(
        color: COLOR_E6F0F2,
        width: size.width,
        child: Column(
          children: [
            Container(
              child: Text(
                getTranslated(context, "settings.label.title"),
                style: googleFontNutino(
                  TextStyle(
                    color: COLOR_065063,
                    fontWeight: FontWeight.w700,
                    fontSize: 18
                  )
                ),
              ),
            ),
            Container(
              child: Text(
                "---",
                style: googleFontNutino(
                    TextStyle(
                        color: COLOR_065063,
                        fontWeight: FontWeight.w700,
                        fontSize: 14
                    )
                ),
              ),
            ),
            Expanded(
              child:  Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 32
                ),
                child: SingleChildScrollView(
                  child: Table(
                    columnWidths: {
                      0: FlexColumnWidth(3),
                      1: FlexColumnWidth(7),
                    },
                    children: [
                      TableRow(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 16
                            ),
                            child: Text(
                              getTranslated(context, "settings.label.language").toUpperCase(),
                              style: textStyleLabel(),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 8
                            ),
                            child:  Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SwitchLanguage(
                                  backgroundColor: COLOR_FFFFFF,
                                  colorActive: COLOR_065063
                                ),
                              ],
                            ),
                          )
                        ]
                      ),
                      TableRow(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 16
                            ),
                            child: Text(
                              getTranslated(context, "settings.label.dictionary").toUpperCase(),
                              style: textStyleLabel(),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 16,
                                horizontal: 8
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _storyViewOptions != null ? SwitchDictionary(
                                    dictionary: _storyViewOptions.dictionary,
                                    changeDictionary: (dictionary) {
                                      _changeOptionsDictionary(dictionary);
                                    }
                                ) : SizedBox(),
                              ],
                            ),
                          )
                        ]
                      ),
                      TableRow(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16
                              ),
                              child: Text(
                                getTranslated(context, "settings.label.storyFontSize").toUpperCase(),
                                style: textStyleLabel(),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 8
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _storyViewOptions != null ? Container(
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
                                              size: 30,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ) : SizedBox(),
                                  _storyViewOptions != null ? Container(
                                    child: Text(
                                      getTranslated(context, "settings.label.textTestFontSize"),
                                      style: googleFontNutino(
                                          TextStyle(
                                              color: COLOR_001529,
                                              fontSize: _storyViewOptions.fontSize
                                          )
                                      ),
                                    ),
                                  ) : SizedBox()
                                ],
                              ),
                            )
                          ]
                      ),
                      TableRow(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16
                              ),
                              child: Text(
                                getTranslated(context, "settings.label.dictionary_en_en_offline").toUpperCase(),
                                style: textStyleLabel(),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 8
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print("download en-en");
                                    },
                                    child: Container(
                                      width: 80,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4,
                                          horizontal: 16
                                      ),
                                      decoration: BoxDecoration(
                                          color: COLOR_065063,
                                          borderRadius: BorderRadius.circular(7)
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            getTranslated(context, "story_view.label.en_en"),
                                            style: googleFontNutino(
                                                TextStyle(
                                                  color: COLOR_FFFFFF,
                                                  fontWeight: FontWeight.w700,
                                                )
                                            ),
                                          ),
                                          Icon(
                                              Icons.download_sharp,
                                              color: COLOR_FFFFFF
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.download_done_sharp,
                                    color: COLOR_065063,
                                  )
                                ],
                              ),
                            )
                          ]
                      ),
                      TableRow(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16
                              ),
                              child: Text(
                                getTranslated(context, "settings.label.dictionary_en_vi_offline").toUpperCase(),
                                style: textStyleLabel(),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 16,
                                  horizontal: 8
                              ),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      print("download en-vi");
                                    },
                                    child: Container(
                                      width: 80,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 4,
                                          horizontal: 16
                                      ),
                                      decoration: BoxDecoration(
                                          color: COLOR_065063,
                                          borderRadius: BorderRadius.circular(7)
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            getTranslated(context, "story_view.label.en_vi"),
                                            style: googleFontNutino(
                                                TextStyle(
                                                  color: COLOR_FFFFFF,
                                                  fontWeight: FontWeight.w700,
                                                )
                                            ),
                                          ),
                                          Icon(
                                              Icons.download_sharp,
                                              color: COLOR_FFFFFF
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.download_done_sharp,
                                    color: COLOR_065063,
                                  )
                                ],
                              ),
                            )
                          ]
                      ),
                    ],
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
