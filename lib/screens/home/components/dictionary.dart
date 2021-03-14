import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import './../../../components/app_layout.dart';
import 'package:permission_handler/permission_handler.dart';
import './../../../components/component_common.dart';
import './../../../localization/language_constants.dart';
import './../../../utils/colors.dart';

import 'dictionary_en_en.dart';
import 'dictionary_en_vi.dart';

class Dictionary extends StatefulWidget {
  @override
  _DictionaryState createState() => _DictionaryState();
}

class _DictionaryState extends State<Dictionary> with SingleTickerProviderStateMixin {
  TabController _tabController;
  String _word = "";
  TextEditingController _wordController = TextEditingController();
  int _tabIndexActive = 0;
  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(_handleTabSelection);
    super.initState();

  }


  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    setState(() {
      _tabIndexActive = _tabController.index;
    });
  }

  _lookUpDictionary() {
    _setWord(_wordController.text);
    FocusScope.of(context).unfocus();
  }

  _setWord(word) {
    setState(() {
      _word = word;
    });
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
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
        ),
        child: Column(
          children: [
            Container(
              width: 160,
              child: TabBar(
                tabs: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 0
                    ),
                    child: Text(
                      getTranslated(context, "story_view.label.en_en").toUpperCase(),
                      style: TextStyle(
                          fontSize: 12
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 0
                    ),
                    child: Text(
                      getTranslated(context, "story_view.label.en_vi").toUpperCase(),
                      style: TextStyle(
                          fontSize: 12
                      ),
                    ),
                  ),
                ],
                controller: _tabController,
                indicatorColor: COLOR_065063,
                labelColor: COLOR_065063,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 68,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: COLOR_FFFFFF,
                                width: 2
                            ),
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: ListTile(
                          title: TextField(
                            // autofocus: true,
                            controller: _wordController,
                            decoration: new InputDecoration(
                                hintText: getTranslated(context, "home.dictionary.enter_word"),
                                border: InputBorder.none
                            ),
                            style: googleFontNutino(
                              TextStyle(
                                color: COLOR_001529,
                              )
                            ),
                            textInputAction: TextInputAction.go,
                            onSubmitted: (value) {
                              _setWord(value);
                            }
                          ),
                          trailing: IconButton(
                            icon: new Icon(
                              Icons.cancel,
                              color: COLOR_065063,
                            ),
                            onPressed: () {
                              _wordController.clear();
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 60,
                    width: 80,
                    child: GestureDetector(
                      onTap: () {
                        _lookUpDictionary();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8
                        ),
                        decoration: BoxDecoration(
                          color: COLOR_065063,
                          borderRadius: BorderRadius.circular(8)
                        ),
                        child: Column(
                          children: [
                            Text(
                              getTranslated(context, "home.dictionary.look_up_dictionary"),
                              style: googleFontNutino(
                                TextStyle(
                                  color: COLOR_FFFFFF,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400
                                )
                              ),
                            ),
                            Text(
                              _tabIndexActive == 0 ? getTranslated(context, "story_view.label.en_en").toUpperCase() : getTranslated(context, "story_view.label.en_vi").toUpperCase(),
                              style: googleFontNutino(
                                TextStyle(
                                  color: COLOR_FFFFFF,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700
                                )
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 4
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${getTranslated(context, "home.dictionary.word")} :".toUpperCase(),
                    style: googleFontNutino(
                      TextStyle(
                        color: COLOR_001529,
                        fontWeight: FontWeight.w600,
                      )
                    )
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    _word ?? "",
                    style: googleFontNutino(
                      TextStyle(
                        color: COLOR_001529,
                        fontWeight: FontWeight.w700
                      )
                    )
                  ),
                ],
              ),
            ),
            Text(
              "---"
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  children: [
                    DictionaryEnEn(

                    ),
                    DictionaryEnVi(

                    )
                  ],
                  controller: _tabController,
                ),
              ),
            )
          ],
        )
    );
  }
}
