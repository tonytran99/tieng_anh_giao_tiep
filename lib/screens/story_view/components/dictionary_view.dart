import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import './../../../localization/language_constants.dart';
import './../../../shared/shared_saved.dart';
import './../../../utils/colors.dart';
import './../../../utils/constants.dart';

import '../../../main.dart';


class DictionaryView extends StatefulWidget {
  final String word;
  DictionaryView({Key key, @required this.word}) : super(key: key);
  @override
  _DictionaryViewState createState() => _DictionaryViewState();
}

class _DictionaryViewState extends State<DictionaryView> with SingleTickerProviderStateMixin {
  Map<String, dynamic> _saved;

  @override
  void initState() {
    super.initState();
    setState(() {
      _saved = MyApp.getSavedApp(context);
    });
  }

  _removeWordSaved() {
    if (_saved != null) {
      setState(() {
        _saved.remove(widget.word);
      });
      setSaved(_saved).then((value) {
        MyApp.setSavedApp(context, _saved);
      });
    }
  }

  _addWordSaved() {
    if (_saved == null) {
      setState(() {
        _saved = {
          widget.word: "lop hoc"
        };
      });
      setSaved(_saved).then((value) {
        MyApp.setSavedApp(context, _saved);
      });
    } else {
      if (_saved.containsKey(widget.word)) {
        print("da luu roi");
      } else {
        setState(() {
          _saved[widget.word] = "nghia cua tu ${widget.word}";
        });
        setSaved(_saved).then((value) {
          MyApp.setSavedApp(context, _saved);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color: COLOR_FFFFFF,
          // borderRadius: BorderRadius.circular(9)
      ),
      child: Column(
        children: [
          Text(
              "Hien thi tu dien : ${widget.word}"
          ),
          Spacer(),
          _saved != null && _saved.containsKey(widget.word) ? GestureDetector(
            onTap: () {
              _removeWordSaved();
            },
            child: Container(
              color: Colors.blueGrey,
              child: Text(
                  "khong luu"
              ),
            ),
          ) : GestureDetector(
            onTap: () {
              _addWordSaved();
            },
            child: Container(
              color: Colors.blueGrey,
              child: Text(
                  "Save word"
              ),
            ),
          )
        ],
      ),
    );
  }
}
