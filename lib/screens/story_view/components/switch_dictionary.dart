import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './../../../localization/language_constants.dart';
import './../../../utils/colors.dart';
import './../../../utils/constants.dart';


class SwitchDictionary extends StatefulWidget {
  final String dictionary;
  final Function changeDictionary;
  SwitchDictionary({Key key, @required this.dictionary, this.changeDictionary}) : super(key: key);
  @override
  _SwitchDictionaryState createState() => _SwitchDictionaryState();
}

class _SwitchDictionaryState extends State<SwitchDictionary> with SingleTickerProviderStateMixin {
  String _dictionary;
  TabController _tabController;
  List<String> _listDictionary = [
    DICTIONARY_EN_EN,
    DICTIONARY_EN_VI
  ];
  // Map<String, String>
  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 2,
      initialIndex: _listDictionary.indexOf(widget.dictionary)
    );
    _tabController.addListener(_handleTabSelection);
    print(widget.dictionary);
    setState(() {
      _dictionary = widget.dictionary;
    });
  }


  _handleTabSelection() {
    setState(() {
      _dictionary = _listDictionary[_tabController.index];
    });
    widget.changeDictionary(_dictionary);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: COLOR_FFFFFF,
          borderRadius: BorderRadius.circular(9)
      ),
      width: 120,
      height: 30,
      child: TabBar(
          tabs: _listDictionary.map((e) {
            return Container(
              padding: EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 8
              ),
              decoration: BoxDecoration(
                  color: _dictionary == e ? COLOR_065063 : COLOR_TRANSPARENT,
                  borderRadius: BorderRadius.circular(9)
              ),
              child: Text(
                e == DICTIONARY_EN_EN ? getTranslated(context, "story_view.label.en_en") : getTranslated(context, "story_view.label.en_vi"),
              ),
            );
          }).toList(),
          controller: _tabController,
          indicatorColor: COLOR_TRANSPARENT,
          labelColor: COLOR_FFFFFF,
          unselectedLabelColor: COLOR_065063,
          labelPadding: EdgeInsets.all(0)
      ),
    );
  }
}
