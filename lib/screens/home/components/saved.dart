import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './../../../components/app_layout.dart';
import './../../../components/component_common.dart';
import './../../../localization/language_constants.dart';
import './../../../models/debouncer.dart';
import './../../../models/saved.dart';
import './../../../shared/shared_saved.dart';
import './../../../utils/colors.dart';

import '../../../main.dart';

class SavedBlock extends StatefulWidget {
  @override
  _SavedBlockState createState() => _SavedBlockState();
}

class _SavedBlockState extends State<SavedBlock> {
  TextEditingController _wordController = TextEditingController(text: "");
  List<Saved> _savedList;
  List<Saved> _savedFilter;
  Map<String, dynamic> _savedMap;
  final _debouncer = Debouncer(milliseconds: 500);

  void initState() {
    super.initState();
    setState(() {
      _savedMap = MyApp.getSavedApp(context);
    });
    // FocusScope.of(context).unfocus();
    _savedMapToSavedList(MyApp.getSavedApp(context));
  }

  _savedMapToSavedList(Map<String, dynamic> savedMap) {
    if (savedMap != null) {
      setState(() {
        _savedList = savedMap.entries.map((e) {
          return Saved(
            word: e.key,
            mean: e.value
          );
        }).toList();
        _savedFilter = _savedList;
      });
    }
  }

  _removeWordSaved(Saved saved) {
    if (_savedMap != null) {
      setState(() {
        _savedMap.remove(saved.word);
        //  delete word in _savedList
        // delete word in _savedFilter
        _savedList.remove(saved);
        _savedFilter.remove(saved);
      });
      setSaved(_savedMap).then((value) {
        MyApp.setSavedApp(context, _savedMap);
      });
    }
  }

  _searchWordSaved(value) {
    setState(() {
      _savedFilter = _savedList
          .where((saved) => (saved.word
          .toLowerCase()
          .contains(value.toLowerCase())))
          .toList();
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
        color: COLOR_E6F0F2,
      ),
      child: Column(
        children: [
          // searchInput
          Container(
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
                    // textInputAction: TextInputAction.go,
                  onChanged: (value) {
                    _debouncer.run(() {
                      _searchWordSaved(value);
                    });
                  },
                ),
                trailing: IconButton(
                  icon: new Icon(
                    Icons.cancel,
                    color: COLOR_065063,
                  ),
                  onPressed: () {
                    _wordController.clear();
                    setState(() {
                      _savedFilter = _savedList;
                    });
                  },
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // listView
          Expanded(
            child: Container(
              child: _savedFilter != null && _savedFilter.length != 0 ? SingleChildScrollView(
                child: Column(
                  children: _savedFilter.map((saved) {
                    return Container(
                        height: 80,
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
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.only(
                                  left: 8
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      saved.word,
                                      style: TextStyle(
                                          color: COLOR_001529,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16
                                      ),
                                    ),
                                    Expanded(
                                        child: Text(
                                          saved.mean,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                          style: googleFontNutino(
                                              TextStyle(
                                                color: COLOR_001529,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 14,
                                              )
                                          ),
                                        )
                                    )
                                  ],
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                ),
                              ),
                            ),
                            // unliked
                            IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: COLOR_065063,
                              ),
                              onPressed: () {
                                _removeWordSaved(saved);
                              },
                            )
                          ],
                        )
                    );
                  }).toList(),
                ),
              ) : Container(
                child: Text(
                  getTranslated(context, "label.no_results"),
                  style: googleFontNutino(
                    TextStyle(
                      color: COLOR_001529,
                      fontWeight: FontWeight.w500
                    )
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
