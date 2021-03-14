import 'package:flutter/material.dart';
import './../components/switch_language.dart';
import './../localization/language_constants.dart';
import './../router/route_constants.dart';
import './../utils/colors.dart';
import './../utils/constants.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}




class _AppDrawerState extends State<AppDrawer> {

  final List<ListTileData> listTileDataList = ListTileData.listTileDataList();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<ListTile> _showAllListTile() {
    return listTileDataList.map((ListTileData listTileData) {
      return ListTile(
        leading: Icon(
          listTileData.icon,
          color: COLOR_E6F0F2,
        ),
        title: Text(
          getTranslated(context, listTileData.label),
          style: TextStyle(
            color: COLOR_FFFFFF,
            fontSize: 14
          ),
        ),
        onTap: () {
          switch(listTileData.code) {
            case LIST_TILE_HOME:
              Navigator.pop(context, false);
          // Navigator.of(context).pushNamed(homeRoute);
              break;
            case LIST_TILE_SETTINGS:
              Navigator.of(context).pushNamed(settingsRoute);
              break;
            case LIST_TILE_RATE_APP:
              break;
            case LIST_TILE_SHARE:
              break;
            case LIST_TILE_PRIVACY_AND_POLICY:
              break;
            case LIST_TILE_EXIT:
              break;
          }
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: COLOR_065063
          ),
          // profile
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    vertical: 40.0,
                    horizontal: 8.0
                ),
                decoration: BoxDecoration(
                  color: COLOR_E6F0F2,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage(
                          LINK_ASSETS_IMAGES + "tonytran_logo.png"
                      ),
                      width: 60,
                      height: 60,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Tony Tran Studio",
                      style: TextStyle(
                        color: COLOR_001034,
                        fontWeight: FontWeight.w500,
                        fontSize: 14
                      ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text(
                      "tonytran99.no1@gmail.com",
                      style: TextStyle(
                        color: COLOR_065063,
                        fontSize: 13,
                        fontStyle: FontStyle.italic
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: _showAllListTile(),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              SwitchLanguage()
              // switch language
            ],
          ),
        )
    );
  }
}

const String LIST_TILE_HOME = "home";
const String LIST_TILE_SETTINGS = "settings";
const String LIST_TILE_RATE_APP = "rate_app";
const String LIST_TILE_SHARE = "share";
const String LIST_TILE_PRIVACY_AND_POLICY = "privacy_and_policy";
const String LIST_TILE_EXIT = "exit";


class ListTileData {
  String code;
  IconData icon;
  String label;

  ListTileData(
      this.code,
      this.icon,
      this.label
      );

  static List<ListTileData> listTileDataList() {
    return <ListTileData>[
      ListTileData(
        LIST_TILE_HOME,
        Icons.home,
        "drawer.label.home"
      ),
      ListTileData(
          LIST_TILE_SETTINGS,
          Icons.settings,
          "drawer.label.settings"
      ),
      ListTileData(
          LIST_TILE_RATE_APP,
          Icons.star_rate,
          "drawer.label.rate_app"
      ),
      ListTileData(
          LIST_TILE_SHARE,
          Icons.share,
          "drawer.label.share"
      ),
      ListTileData(
          LIST_TILE_PRIVACY_AND_POLICY,
          Icons.privacy_tip,
          "drawer.label.privacy_and_policy"
      ),
      ListTileData(
          LIST_TILE_EXIT,
          Icons.exit_to_app,
          "drawer.label.exit"
      )
    ];
  }
}