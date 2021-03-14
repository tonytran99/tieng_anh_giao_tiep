import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './../components/component_common.dart';
import './../db/db_conversation.dart';
import './../localization/language_constants.dart';
import './../main.dart';
import './../models/story.dart';
import './../models/topic.dart';
import './../screens/story_view/story_view.dart';
import './../shared/shared_liked.dart';
import './../utils/colors.dart';
import './../utils/constants.dart';

class DownloadComponent extends StatefulWidget {
  // final Topic topic;
  // DownloadComponent({Key key, @required this.topic}) : super(key: key);
  @override
  _DownloadComponentState createState() => _DownloadComponentState();
}

class _DownloadComponentState extends State<DownloadComponent> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      color: COLOR_E6F0F2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(
                LINK_ASSETS_IMAGES + "tonytran_logo.png"
            ),
            width: 90,
            height: 90,
          ),
          Text(
            getTranslated(context, "title"),
            style: googleFontNutino(
                TextStyle(
                    color: COLOR_065063,
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                )
            ),
          ),
          SizedBox(
            height: 80,
          ),
          Container(
            child: CircularProgressIndicator(
                backgroundColor: COLOR_90cdd8,
                valueColor: AlwaysStoppedAnimation<Color>(COLOR_065063)
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            getTranslated(context, "label.loading"),
            style: googleFontNutino(
                TextStyle(
                    color: COLOR_065063,
                    fontWeight: FontWeight.w500,
                    fontSize: 16
                )
            ),
          )
        ],
      ),
    );
  }
}
