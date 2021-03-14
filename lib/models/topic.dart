class Topic {
  int id;
  String uid;
  String name;
  String description;
  String photo;
  String createdAt;
  String updatedAt;
  int totalStories;
  Topic(
    this.id,
    this.uid,
    this.name,
    this.description,
    this.photo,
    this.createdAt,
    this.updatedAt,
    this.totalStories
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'uid': uid,
      'name': name,
      'description': description,
      'photo': photo,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'totalStories': totalStories,
    };
    return map;
  }

  Topic.fromMap(Map<String, dynamic> map) {
    id = map['id'] ?? null;
    uid = map['uid'].toString();
    name = map['name'];
    description = map['description'];
    photo = map['photo'];
    createdAt = map['createdAt'];
    updatedAt = map['updatedAt'];
    totalStories = map['totalStories'];
  }

  @override
  String toString() {
    return '"topic":'
        '{'
        '"id": $id, '
        '"uid": $uid, '
        '"name": $name, '
        '"description": $description, '
        '"photo": $photo, '
        '"createdAt": $createdAt, '
        '"updatedAt": $updatedAt, '
        '"totalStories": $totalStories, '
        '}';
  }
}