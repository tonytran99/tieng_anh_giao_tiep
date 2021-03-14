import 'package:flutter/material.dart';

class StoryViewOptions {
  double fontSize;
  String dictionary;

  StoryViewOptions(
    this.fontSize,
    this.dictionary,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'fontSize': fontSize,
      'dictionary': dictionary,
    };
    return map;
  }

  StoryViewOptions.fromMap(Map<String, dynamic> map) {
    fontSize = map['fontSize'];
    dictionary = map['dictionary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['fontSize'] = this.fontSize;
    data['dictionary'] = this.dictionary;
    return data;
  }

  @override
  String toString() {
    return '"storyViewOptions":'
      '{'
      '"fontSize": $fontSize, '
      '"dictionary": $dictionary, '
      '}';
  }
}