import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class LocalDatabase {
  // Singleton instance accesibilă static
  static final LocalDatabase instance = LocalDatabase._internal();
  factory LocalDatabase() => instance;
  LocalDatabase._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await databaseFactory.getDatabasesPath();
    final path = join(dbPath, 'app_database.db');

    return await databaseFactory.openDatabase(
      path,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: _onCreate,
      ),
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        email TEXT UNIQUE,
        password TEXT,
        userType TEXT,
        familyCode TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE progress (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        userId TEXT,
        chenarId TEXT,
        timeSpent INTEGER,
        score INTEGER,
        totalQuestions INTEGER,
        completed INTEGER,
        scoruri TEXT
      )
    ''');
  }

  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
    final db = await database;
    final result = await db.query('users', where: 'email = ?', whereArgs: [email]);
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> createUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert('users', user);
  }

  Future<Map<String, dynamic>?> authenticateUser(String email, String password) async {
    final db = await database;
    final result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<Map<String, dynamic>?> getProgress(String userId, String chenarId) async {
    final db = await database;
    final result = await db.query(
      'progress',
      where: 'userId = ? AND chenarId = ?',
      whereArgs: [userId, chenarId],
    );
    return result.isNotEmpty ? result.first : null;
  }

  Future<int> insertProgress(Map<String, dynamic> progress) async {
    final db = await database;
    return await db.insert('progress', progress);
  }

  Future<int> updateProgress(String id, Map<String, dynamic> updates) async {
    final db = await database;
    return await db.update('progress', updates, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> getEleviForParinte(String familyCode) async {
    final db = await database;
    return await db.query(
      'users',
      where: 'userType = ? AND familyCode = ?',
      whereArgs: ['Elev', familyCode],
    );
  }

  Future<void> close() async {
    final db = await database;
    db.close();
  }
}
