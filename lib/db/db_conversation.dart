import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import './../models/story.dart';
import './../models/topic.dart';
import './../utils/constants.dart';

class DBStory {
  static Database _db;
  static const String TABLE = 'Story';
  static const String DB_NAME = 'db_story.db';

  static const String ID = 'id';
  static const String UID = 'uid';
  static const String NAME_EN = 'nameEn';
  static const String NAME_VI = 'nameVi';
  static const String DESCRIPTION_EN = 'descriptionEn';
  static const String DESCRIPTION_VI = 'descriptionVi';
  static const String PHOTO = 'photo';
  static const String NORMAL_AUDIO = 'normalAudio';
  static const String SPEED_AUDIO = 'speedAudio';
  static const String HAS_AUDIO_SENTENCES = 'hasAudioSentences';
  static const String LIST_PERSON = 'listPerson';
  static const String CREATED_AT = 'createdAt';
  static const String UPDATED_AT = 'updatedAt';
  static const String TOPIC_ID = 'topicId';

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, DB_NAME);
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $TABLE ( $ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $UID TEXT, $NAME_EN TEXT, $NAME_VI TEXT, $DESCRIPTION_EN TEXT, $DESCRIPTION_VI TEXT, $CONTENT_EN TEXT, $CONTENT_VI TEXT, $PHOTO TEXT, $AUDIO TEXT, $CREATED_AT TEXT, $UPDATED_AT TEXT, $TOPIC_ID TEXT)");
  }

  Future<Story> save(Story story) async {
    var dbClient = await db;
    story.id = await dbClient.insert(TABLE, story.toMap());
    return story;
  }

  Future<List<Story>> getStories(String topicId) async {
    var dbClient = await db;

    List<Map> maps = topicId != null ? await dbClient.query(
        TABLE,
        where: '$TOPIC_ID = ?',
        whereArgs: [topicId],
        columns: [ID, UID, NAME_EN, NAME_VI, DESCRIPTION_EN, DESCRIPTION_VI, CONTENT_EN, CONTENT_VI, PHOTO, AUDIO, CREATED_AT, UPDATED_AT, TOPIC_ID]
    ) : await dbClient.query(
        TABLE,
        columns: [ID, UID, NAME_EN, NAME_VI, DESCRIPTION_EN, DESCRIPTION_VI, CONTENT_EN, CONTENT_VI, PHOTO, AUDIO, CREATED_AT, UPDATED_AT, TOPIC_ID]
    );
    List<Story> stories = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        stories.add(Story.fromMap(maps[i]));
      }
    }
    return stories;
  }

  Future<List<Story>> getStoriesWithListUid(List<String> listUid) async {
    var dbClient = await db;
    String uidListStr = '(';
    listUid.asMap().forEach((key, uid) {
      if (key == 0) {
        uidListStr += uid;
      } else {
        uidListStr += ', $uid';
      }
    });
    uidListStr += ')';
    List<Map> maps = await dbClient.query(
        TABLE,
        where: '$UID IN $uidListStr',
        columns: [ID, UID, NAME_EN, NAME_VI, DESCRIPTION_EN, DESCRIPTION_VI, CONTENT_EN, CONTENT_VI, PHOTO, AUDIO, CREATED_AT, UPDATED_AT, TOPIC_ID]
    );
    List<Story> stories = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        stories.add(Story.fromMap(maps[i]));
      }
    }
    return stories;
  }

  Future<int> delete(String uid) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$UID = ?', whereArgs: [uid]);
  }

  Future<int> update(Story story) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, story.toMap(),
        where: '$UID = ?', whereArgs: [story.uid]);
  }

  Future<dynamic> insertOrUpdate(Story story) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, where: '$UID = ?', whereArgs: [story.uid], columns: [ID, UID, NAME_EN, NAME_VI, DESCRIPTION_EN, DESCRIPTION_VI, CONTENT_EN, CONTENT_VI, PHOTO, AUDIO, CREATED_AT, UPDATED_AT, TOPIC_ID]);
    if (maps.length != 0) {
      if (story.updatedAt != maps[0]["updatedAt"]) {
        story.id = maps[0]["id"];
        await dbClient.update(TABLE, story.toMap(),
            where: '$UID = ?', whereArgs: [story.uid]);
        return DATA_UPDATE;
      } else {
        return DATA_NOT_UPDATE;
      }
    } else {
      await dbClient.insert(TABLE, story.toMap());
      return DATA_NEW;
    }
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}