import 'package:flutter/material.dart';

class AppData {
  bool dictionaryEnEnOffline;
  bool dictionaryEnViOffline;
  String lastUpdate;

  AppData({
    this.dictionaryEnEnOffline,
    this.dictionaryEnViOffline,
    this.lastUpdate,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'dictionaryEnEnOffline': dictionaryEnEnOffline,
      'dictionaryEnViOffline': dictionaryEnViOffline,
      'lastUpdate': lastUpdate,
    };
    return map;
  }

  AppData.fromMap(Map<String, dynamic> map) {
    dictionaryEnEnOffline = map['dictionaryEnEnOffline'];
    dictionaryEnViOffline = map['dictionaryEnViOffline'];
    lastUpdate = map['lastUpdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['dictionaryEnEnOffline'] = this.dictionaryEnEnOffline;
    data['dictionaryEnViOffline'] = this.dictionaryEnViOffline;
    data['lastUpdate'] = this.lastUpdate;
    return data;
  }

  @override
  String toString() {
    return '"AppData":'
        '{'
        '"dictionaryEnEnOffline": $dictionaryEnEnOffline, '
        '"dictionaryEnViOffline": $dictionaryEnViOffline, '
        '"lastUpdate": $lastUpdate, '
        '}';
  }
}