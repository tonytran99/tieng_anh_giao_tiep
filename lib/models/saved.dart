class Saved {
  String word;
  String mean;
  Saved({this.word, this.mean});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'word': word,
      'mean': mean,
    };
    return map;
  }

  Saved.fromMap(Map<String, dynamic> map) {
    word = map['word'];
    mean = map['mean'];
  }

  @override
  String toString() {
    return '"saved":'
        '{'
        '"word": $word, '
        '"mean": $mean, '
        '}';
  }
}