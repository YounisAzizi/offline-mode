import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/user_model.dart';

class DatabaseHelper {
  final String tableName;
  static Database? _database;
  DatabaseHelper({required this.tableName});


  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'app_database.db');
    // user_database.db
    return await openDatabase(databasePath, version: 1,
        onCreate: (Database db, int version) async {
          await db.execute('''
        CREATE TABLE $tableName(
          id TEXT PRIMARY KEY,
          name TEXT,
          lastName TEXT,
          startTime TEXT,
          endTime TEXT,
          isStarted INTEGER
        )
      ''');
        },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE $tableName ADD COLUMN isStarted INTEGER DEFAULT 0');
        }
      },

    );
  }

  Future<void> insertUser(UserModel user) async {
    final db = await database;
    await db.insert(
      tableName,
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<UserModel>> getUsers() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return UserModel.fromJson(maps[i]);
    });
  }

  Future<void> updateUserEndTime(String userId, DateTime newEndTime) async {
    final db = await database;
    await db.update(
      tableName,
      {'endTime': newEndTime.toIso8601String(),
      'isStarted':0
      },
      where: 'id = ?',
      whereArgs: [userId],
    );
  }
}
