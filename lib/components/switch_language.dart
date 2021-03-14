import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './../localization/language_constants.dart';
import './../utils/colors.dart';
import './../utils/constants.dart';

import '../main.dart';


class SwitchLanguage extends StatefulWidget {
  final Color backgroundColor;
  final Color colorActive;
  SwitchLanguage({Key key, this.backgroundColor, this.colorActive}) : super(key: key);
  @override
  _SwitchLanguageState createState() => _SwitchLanguageState();
}

class _SwitchLanguageState extends State<SwitchLanguage> with SingleTickerProviderStateMixin {
  String _languageCode = VIETNAMESE;
  final List<String> _listLanguage= [
    ENGLISH,
    VIETNAMESE,
  ];
  TabController _tabLanguageController;

  @override
  void initState() {
    super.initState();
   
    _tabLanguageController = TabController(
      vsync: this,
      length: _listLanguage.length,
      initialIndex: _listLanguage.indexOf(MyApp.getLocaleApp(context).languageCode)
    );
    _tabLanguageController.addListener(_handleTabSelection);
    setState(() {
      _languageCode = MyApp.getLocaleApp(context).languageCode;
    });
  }


  _handleTabSelection() {
    setState(() {
      _languageCode = _listLanguage[_tabLanguageController.index];
    });
    _changeLanguage(_languageCode);
  }

  @override
  void dispose() {
    _tabLanguageController.dispose();
    super.dispose();
  }
  void _changeLanguage(String languageCode) async {
    Locale _locale = await setLocale(languageCode);
    MyApp.setLocaleApp(context, _locale);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.backgroundColor != null ? widget.backgroundColor : COLOR_E6F0F2,
        borderRadius: BorderRadius.circular(9)
      ),
      width: 100,
      height: 30,
      child: TabBar(
        tabs: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 8
            ),
            decoration: BoxDecoration(
              color: _languageCode == ENGLISH ? widget.colorActive != null ? widget.colorActive : COLOR_F28256 : COLOR_TRANSPARENT,
              borderRadius: BorderRadius.circular(9)
            ),
            child: Text(
              getTranslated(context, "drawer.label.en"),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8
            ),
            decoration: BoxDecoration(
                color: _languageCode == VIETNAMESE ? widget.colorActive != null ? widget.colorActive : COLOR_F28256 : COLOR_TRANSPARENT,
                borderRadius: BorderRadius.circular(9)
            ),
            child: Text(
              getTranslated(context, "drawer.label.vi"),
            ),
          )
        ],
        controller: _tabLanguageController,
        indicatorColor: COLOR_TRANSPARENT,
        labelColor: COLOR_FFFFFF,
        unselectedLabelColor: COLOR_065063,
        labelPadding: EdgeInsets.all(0)
      ),
    );
  }
}
