import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import './../models/topic.dart';
import './../utils/constants.dart';

class DBTopic {
  static Database _db;
  static const String TABLE = 'Topic';
  static const String DB_NAME = 'db_topic.db';

  static const String ID = 'id';
  static const String UID = 'uid';
  static const String NAME = 'name';
  static const String DESCRIPTION = 'description';
  static const String PHOTO = 'photo';
  static const String CREATED_AT = 'createdAt';
  static const String UPDATED_AT = 'updatedAt';
  static const String TOTAL_STORIES = 'totalStories';

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
    await db.execute("CREATE TABLE $TABLE ($ID INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, $UID TEXT, $NAME TEXT, $DESCRIPTION TEXT, $PHOTO TEXT, $CREATED_AT TEXT, $UPDATED_AT TEXT, $TOTAL_STORIES INTEGER)");
  }

  Future<Topic> save(Topic topic) async {
    var dbClient = await db;
    topic.id = await dbClient.insert(TABLE, topic.toMap());
    return topic;
  }

  Future<List<Topic>> getTopics() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, columns: [ID, UID, NAME, DESCRIPTION, PHOTO, CREATED_AT, UPDATED_AT, TOTAL_STORIES]);
    List<Topic> topics = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        topics.add(Topic.fromMap(maps[i]));
      }
    }
    return topics;
  }

  Future<int> delete(String uid) async {
    var dbClient = await db;
    return await dbClient.delete(TABLE, where: '$UID = ?', whereArgs: [uid]);
  }

  Future<int> update(Topic topic) async {
    var dbClient = await db;
    return await dbClient.update(TABLE, topic.toMap(),
        where: '$UID = ?', whereArgs: [topic.uid]);
  }

  Future<Topic> show(String uid) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, where: '$UID = ?', whereArgs: [uid], columns: [ID, UID, NAME, DESCRIPTION, PHOTO, CREATED_AT, UPDATED_AT, TOTAL_STORIES]);
    if (maps.length != 0) {
      return Topic.fromMap(maps[0]);
    } else {
      return null;
    }
  }

  Future<dynamic> insertOrUpdate(Topic topic) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(TABLE, where: '$UID = ?', whereArgs: [topic.uid], columns: [ID, UID, NAME, DESCRIPTION, PHOTO, CREATED_AT, UPDATED_AT, TOTAL_STORIES]);
    if (maps.length != 0) {
      if (topic.updatedAt != maps[0]["updatedAt"]) {
        topic.id = maps[0]["id"];
        await dbClient.update(TABLE, topic.toMap(),
            where: '$UID = ?', whereArgs: [topic.uid]);
        return DATA_UPDATE;
      } else {
        return DATA_NOT_UPDATE;
      }
    } else {
      topic.id = await dbClient.insert(TABLE, topic.toMap());
      return DATA_NEW;
    }
  }

  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}