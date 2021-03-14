import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DictionaryEnVi extends StatefulWidget {
  @override
  _DictionaryEnViState createState() => _DictionaryEnViState();
}

class _DictionaryEnViState extends State<DictionaryEnVi> {
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
              "DictionaryEnVi"
          ),
        )
    );
  }
}
