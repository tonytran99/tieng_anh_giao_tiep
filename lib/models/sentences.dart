class Sentences {
  int id;
  String personIndex;
  int sentencesIndex;
  String sentencesEn;
  String sentencesVi;
  String seconds;
  String audio;
  String conversationId;
  Sentences(
    this.id,
    this.personIndex,
    this.sentencesIndex,
    this.sentencesEn,
    this.sentencesVi,
    this.seconds,
    this.audio,
    this.conversationId
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'personIndex': personIndex,
      'sentencesIndex': sentencesIndex,
      'sentencesEn': sentencesEn,
      'sentencesVi': sentencesVi,
      'seconds': seconds,
      'audio': audio,
      'conversationId': conversationId,
    };
    return map;
  }

  Sentences.fromMap(Map<String, dynamic> map) {
    id = map['id'] ?? null;
    personIndex = map['personIndex'].toString();
    sentencesIndex = map['sentencesIndex'];
    sentencesEn = map['sentencesEn'];
    sentencesVi = map['sentencesVi'];
    seconds = map['seconds'];
    audio = map['audio'];
    conversationId = map['conversationId'];
  }

  @override
  String toString() {
    return '"topic":'
        '{'
        '"id": $id, '
        '"personIndex": $personIndex, '
        '"sentencesIndex": $sentencesIndex, '
        '"sentencesEn": $sentencesEn, '
        '"sentencesVi": $sentencesVi, '
        '"seconds": $seconds, '
        '"audio": $audio, '
        '"conversationId": $conversationId, '
        '}';
  }
}