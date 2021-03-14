class Story {
  int id;
  String uid;
  String nameEn;
  String nameVi;
  String descriptionEn;
  String descriptionVi;
  String contentEn;
  String contentVi;
  String photo;
  String audio;
  String createdAt;
  String updatedAt;
  String topicId;
  Story(
    this.id,
    this.uid,
    this.nameEn,
    this.nameVi,
    this.descriptionEn,
    this.descriptionVi,
    this.contentEn,
    this.contentVi,
    this.photo,
    this.audio,
    this.createdAt,
    this.updatedAt,
    this.topicId,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'uid': uid,
      'nameEn': nameEn,
      'nameVi': nameVi,
      'descriptionEn': descriptionEn,
      'descriptionVi': descriptionVi,
      'contentEn': contentEn,
      'contentVi': contentVi,
      'photo': photo,
      'audio': audio,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'topicId': topicId,
    };
    return map;
  }

  Story.fromMap(Map<String, dynamic> map) {
    id = map['id'] ?? null;
    uid = map['uid'].toString();
    nameEn = map['nameEn'];
    nameVi = map['nameVi'];
    descriptionEn = map['descriptionEn'];
    descriptionVi = map['descriptionVi'];
    contentEn = map['contentEn'];
    contentVi = map['contentVi'];
    photo = map['photo'];
    audio = map['audio'];
    createdAt = map['createdAt'];
    updatedAt = map['updatedAt'];
    topicId = map['topicId'];
  }

  @override
  String toString() {
    return '"story":'
        '{'
        '"id": $id, '
        '"uid": $uid, '
        '"nameEn": $nameEn, '
        '"nameVi": $nameVi, '
        '"descriptionEn": $descriptionEn, '
        '"descriptionVi": $descriptionVi, '
        '"contentEn": $contentEn, '
        '"contentVi": $contentVi, '
        '"photo": $photo, '
        '"audio": $audio, '
        '"createdAt": $createdAt, '
        '"updatedAt": $updatedAt, '
        '"topicId": $topicId, '
        '}';
  }
}