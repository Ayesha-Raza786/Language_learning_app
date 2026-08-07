import 'package:language_learning/database/translation_history_table.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'category_table.dart';
import 'daily_lesson_table.dart';
import 'database_constants.dart';
import 'language_table.dart';
import 'learning_progress_table.dart';
import 'quiz_history_table.dart';
import 'settings_table.dart';
import 'word_example_table.dart';
import 'word_table.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DatabaseConstants.databaseName);

    return openDatabase(
      path,
      version: DatabaseConstants.databaseVersion,
      onConfigure: _onConfigure,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    await LanguageTable.createTable(db);
    await CategoryTable.createTable(db);
    await WordTable.createTable(db);
    await WordExampleTable.createTable(db);
    await LearningProgressTable.createTable(db);
    await QuizHistoryTable.createTable(db);
    await SettingsTable.createTable(db);
    await TranslationHistoryTable.createTable(db);
    await DailyLessonTable.createTable(db);
  }

  Future<void> _onUpgrade(
      Database db,
      int oldVersion,
      int newVersion,
      ) async {
    if (oldVersion < 4) {
      await DailyLessonTable.createTable(db);
    }
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  Future<void> deleteDatabase() async {
    await closeDatabase();

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, DatabaseConstants.databaseName);
    await databaseFactory.deleteDatabase(path);
  }
}
