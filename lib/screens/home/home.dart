import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './../../components/app_drawer.dart';
import './../../components/component_common.dart';
import './../../db/db_conversation.dart';
import './../../db/db_topic.dart';
import './../../localization/language_constants.dart';
import './../../models/tab.dart';
import './../../models/topic.dart';
import './../../utils/colors.dart';
import './../../utils/constants.dart';

import 'components/dictionary.dart';
import 'components/liked.dart';
import 'components/saved.dart';
import 'components/topics.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int _tabIndexActive = 0;
  TabController _tabController;
  final List<TabMenu> tabMenuList = TabMenu.tabMenuList();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DBTopic dbTopic;
  DBStory dbStory;
  List<Topic> _topicList = [];
  @override
  void initState() {
    super.initState();
    // dbTopic = DBTopic();
    // dbStory = DBStory();
    _tabController = TabController(vsync: this, length: tabMenuList.length);
    _tabController.addListener(_handleTabSelection);
    //
    // dbTopic = DBTopic();
    // dbTopic.getTopics().then((value) {
    //   setState(() {
    //     _topicList = value;
    //     // _isLoading = false;
    //   });
    // });
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
  Color _showTextColor(int tabIndex) {
    if (tabIndex == _tabIndexActive) {
      return Color(0xFFffffff);
    } else {
      return COLOR_065063;
    }
  }
  Color _showContainerColor(int tabIndex) {
    if (tabIndex == _tabIndexActive) {
      return COLOR_065063;
    } else {
      return COLOR_TRANSPARENT;
    }
  }
  Widget _showTriangleShape(tabIndex) {
    if (tabIndex == _tabIndexActive) {
      return ClipPath(
        clipper: TriangleClipper(),
        child: Container(
          color: COLOR_065063,
          height: 10,
          width: 15,
        ),
      );
    } else {
      return SizedBox();
    }
  }
  List<Widget> _showTabs() {
    return tabMenuList.map((TabMenu tabMenu) {
      int tabIndex = tabMenu.tabIndex;
      return Container(
        padding: EdgeInsets.only(
          top: 4
        ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 75,
              // width: 80,
              padding: EdgeInsets.symmetric(
                horizontal: 4.0,
              ),
              decoration: BoxDecoration(
                  color: _showContainerColor(tabIndex),
                  borderRadius: BorderRadius.circular(10)
              ),
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      tabMenu.tabIcon,
                      color: _showTextColor(tabIndex),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      getTranslated(context,
                          tabMenu.tabLabel)
                          .toUpperCase(),
                      style: googleFontMontserrat(
                          TextStyle(
                            color: _showTextColor(tabIndex),
                            fontSize: 9,
                            fontWeight: FontWeight.w500
                          )
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            _showTriangleShape(tabIndex),
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: new GestureDetector(
          // onTap: () {
          //   Navigator.pushReplacement(
          //       context, MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
          // },
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: 4.0,
                horizontal: 20.0
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0)
            ),
            child: Text(
              getTranslated(context, "title"),
              style: googleFontMontserrat(
                  TextStyle(
                    color: COLOR_001034,
                    fontWeight: FontWeight.w500
                  )
              ),
            ),
          ),
        ),
        backgroundColor: COLOR_E6F0F2,
        elevation: 0.0,
        actions: [
          InkWell(
            onTap: () {
              _scaffoldKey.currentState.openEndDrawer();
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 8
              ),
              child: Icon(
                Icons.format_align_right_sharp,
                color: COLOR_425C5A,
              ),
            )
          )
        ],
        // bottom: ,
      ),
      endDrawer: new AppDrawer(), // right side
      body: Container(
        decoration: BoxDecoration(
            color: COLOR_E6F0F2
        ),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: COLOR_E6F0F2
              ),
              child: TabBar(
                controller: _tabController,
                tabs: _showTabs(),
                labelPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 8
                ),
                indicatorColor: COLOR_065063
              ),
            ),
            Expanded(
              child: Container(
                child: TabBarView(
                  controller: _tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    Container(
                      width: size.width,
                      height: size.height,
                      decoration: BoxDecoration(
                        color: COLOR_E6F0F2
                      ),
                      child: Topics(
                          topicList: _topicList
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: size.height,
                      decoration: BoxDecoration(
                          color: COLOR_E6F0F2
                      ),
                      child: Liked(
                          topicList: _topicList
                      ),
                    ),
                    Container(
                      width: size.width,
                      height: size.height,
                      decoration: BoxDecoration(
                          color: COLOR_E6F0F2
                      ),
                      child: SavedBlock(

                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width / 2, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
