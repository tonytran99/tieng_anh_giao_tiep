import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DictionaryEnEn extends StatefulWidget {
  @override
  _DictionaryEnEnState createState() => _DictionaryEnEnState();
}

class _DictionaryEnEnState extends State<DictionaryEnEn> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Drawer(
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
          ),
          // profile
          child: Text(
              "DictionaryEnEn"
          ),
        )
    );
  }
}
