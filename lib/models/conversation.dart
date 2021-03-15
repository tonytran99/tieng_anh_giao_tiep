import 'package:tieng_anh_giao_tiep/models/sentences.dart';

class Conversation {
  int id;
  String uid;
  String nameEn;
  String nameVi;
  String descriptionEn;
  String descriptionVi;
  String photo;
  String normalAudio;
  String speedAudio;
  bool hasAudioSentences;
  List<String> listPerson;
  List<Sentences> sentences;
  String createdAt;
  String updatedAt;
  Conversation(
      this.id,
      this.uid,
      this.nameEn,
      this.nameVi,
      this.descriptionEn,
      this.descriptionVi,
      this.photo,
      this.normalAudio,
      this.speedAudio,
      this.hasAudioSentences,
      this.listPerson,
      this.sentences,
      this.createdAt,
      this.updatedAt,
      );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'uid': uid,
      'nameEn': nameEn,
      'nameVi': nameVi,
      'descriptionEn': descriptionEn,
      'descriptionVi': descriptionVi,
      'photo': photo,
      'normalAudio': normalAudio,
      'speedAudio': speedAudio,
      'hasAudioSentences': hasAudioSentences,
      'listPerson': listPerson,
      'sentences': sentences,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
    return map;
  }

  Conversation.fromMap(Map<String, dynamic> map) {
    id = map['id'] ?? null;
    uid = map['uid'].toString();
    nameEn = map['nameEn'];
    nameVi = map['nameVi'];
    descriptionEn = map['descriptionEn'];
    descriptionVi = map['descriptionVi'];
    photo = map['photo'];
    normalAudio = map['normalAudio'];
    speedAudio = map['speedAudio'];
    hasAudioSentences = map['hasAudioSentences'];
    listPerson = map['listPerson'];
    // sentences = map['sentences'];
    createdAt = map['createdAt'];
    updatedAt = map['updatedAt'];
  }

  @override
  String toString() {
    return '"topic":'
        '{'
        '"id": $id, '
        '"uid": $uid, '
        '"nameEn": $nameEn, '
        '"nameVi": $nameVi, '
        '"descriptionEn": $descriptionEn, '
        '"descriptionVi": $descriptionVi, '
        '"normalAudio": $normalAudio, '
        '"speedAudio": $speedAudio, '
        '"hasAudioSentences": $hasAudioSentences, '
        '"createdAt": $createdAt, '
        '"updatedAt": $updatedAt, '
        '}';
  }
}