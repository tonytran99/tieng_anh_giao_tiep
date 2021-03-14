import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './../router/route_constants.dart';
import './../screens/home/home.dart';
import './../utils/constants.dart';

import '../main.dart';
import 'app_drawer.dart';

class AppLayout extends StatefulWidget {
  final Widget child;
  final route;
  const AppLayout({
    Key key,
    @required this.child,
    this.route
  }) : super(key: key);
  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Scaffold showScaffold() {
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
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(8.0)
            ),
            child: Text(
              "Truyện Song Ngữ",
              style: TextStyle(
                color: Color(0xFF425C5A),
              ),
            ),
          ),
        ),
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0.0,
        actions: [
          InkWell(
              onTap: () {
                _scaffoldKey.currentState.openEndDrawer();
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 16, 0),
                child: SvgPicture.asset(
                  LINK_ASSETS_IMAGES + "drawer_click.svg",
                  color: Color(0xFF425C5A),
                  height: 16,
                ),
              )
          )
        ],
        bottom: (widget.route == homeRoute) ? TabBar(
          tabs: [
            Tab(icon: Icon(Icons.directions_car)),
            Tab(icon: Icon(Icons.directions_transit)),
            Tab(icon: Icon(Icons.directions_bike)),
            Tab(icon: Icon(Icons.directions_bike)),
          ],
        ) : null,
      ),
      endDrawer: new AppDrawer(), // right side
      body: widget.child,
    );
  }
   @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (widget.route == homeRoute) {
      return DefaultTabController(
        length: 4,
        child: showScaffold()
      );
    } else {
      return showScaffold();
    }
  }
}


