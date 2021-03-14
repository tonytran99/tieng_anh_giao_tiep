import 'dart:io';

import 'package:flutter/foundation.dart';

durationToMMSS(Duration duration) {
  List<String> params = duration.toString().split('.').first.split(':');
  return params[1] + ":" + params[2];
}

durationToHHMMSS(Duration duration) {
  return duration.toString().split('.').first.padLeft(8, "0");
}

Future<String> downloadFile(String url, String fileName, String dir) async {
  HttpClient httpClient = new HttpClient();
  File file;
  String filePath = '';
  String myUrl = '';

  try {
    myUrl = url;
    var request = await httpClient.getUrl(Uri.parse(myUrl));
    var response = await request.close();
    if(response.statusCode == 200) {
      var bytes = await consolidateHttpClientResponseBytes(response);
      filePath = '$dir/$fileName';
      file = File(filePath);
      await file.writeAsBytes(bytes);
    }
    else
      filePath = null;
  }
  catch(ex){
    filePath = null;
  }

  return filePath;
}

List<String> specialCharacters = [
  "~","`","!","@","#","\$","%","^","&","*",
  "(",")","-","_","+","=","{","}","[","]",
  "|","\\","/",":",'"',"'","<",">",",",".",
  "?", " ", "\n"
];
String cleanWord(String strWord) {
  List<String> listLetter = strWord.split("");
  List<int> listIndexRemove = [];
  for (var i = 0; i < listLetter.length; i ++) {
    if (!specialCharacters.contains(listLetter[i]) && !(listLetter[i]=="\n")) {
      break ;
    } else {
      listIndexRemove.add(i);
    }
  }
  for (var i = listLetter.length-1; i >= 0; i --) {
    if (!specialCharacters.contains(listLetter[i]) && !(listLetter[i]=="\n")) {
      break ;
    } else {
      listIndexRemove.add(i);
    }
  }
  String word = '';
  listLetter.asMap().forEach((key, value) {
    if (!listIndexRemove.contains(key)) {
      word += value;
    }
  });
  return word;
}
