import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TabMenu {
  int tabIndex;
  String tabLabel;
  IconData tabIcon;

  TabMenu(
    this.tabIndex,
    this.tabLabel,
    this.tabIcon
  );

  static List<TabMenu> tabMenuList() {
    return <TabMenu>[
      TabMenu(
          0,
          "home.tab_bar.topic",
          Icons.topic
      ),
      TabMenu(
          1,
          "home.tab_bar.liked",
          Icons.favorite
      ),
      TabMenu(
          2,
          "home.tab_bar.saved",
          Icons.turned_in
      ),
      TabMenu(
          3,
          "home.tab_bar.dictionary",
          Icons.table_view
      ),
    ];
  }
}
