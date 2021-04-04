class Topic {
  int id;
  String uid;
  String nameEn;
  String nameVi;
  String descriptionEn;
  String descriptionVi;
  String photo;
  String createdAt;
  String updatedAt;
  String listParent;
  String parentId;
  Topic(
    this.id,
    this.uid,
    this.nameEn,
    this.nameVi,
    this.descriptionEn,
    this.descriptionVi,
    this.photo,
    this.createdAt,
    this.updatedAt,
    this.listParent,
    this.parentId
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
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'listParent': listParent,
      'parentId': parentId
    };
    return map;
  }

  Topic.fromMap(Map<String, dynamic> map) {
    id = map['id'] ?? null;
    uid = map['uid'].toString();
    nameEn = map['nameEn'];
    nameVi = map['nameVi'];
    descriptionEn = map['descriptionEn'];
    descriptionVi = map['descriptionVi'];
    photo = map['photo'];
    createdAt = map['createdAt'];
    updatedAt = map['updatedAt'];
    listParent = map['listParent'];
    parentId = map['parentId'];
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
        '"photo": $photo, '
        '"createdAt": $createdAt, '
        '"updatedAt": $updatedAt, '
        '"listParent": $listParent, '
        '"parentId": $parentId, '
        '}';
  }
}