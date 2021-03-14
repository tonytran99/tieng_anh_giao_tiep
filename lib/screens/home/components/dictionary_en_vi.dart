import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import './../../../components/app_layout.dart';
import 'package:permission_handler/permission_handler.dart';

class DictionaryEnVi extends StatefulWidget {
  @override
  _DictionaryEnViState createState() => _DictionaryEnViState();
}

class _DictionaryEnViState extends State<DictionaryEnVi> {

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
        child: Text(
          "Dictionary En Vi"
        )
    );
  }
}
