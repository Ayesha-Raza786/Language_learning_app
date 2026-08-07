import 'package:sqflite/sqflite.dart';

abstract final class DailyLessonTable {
  static const tableName = "daily_lessons";

  static const id = "id";

  /// YYYY-MM-DD
  static const lessonDate = "lessonDate";

  /// FK -> translation_history.id
  static const historyId = "historyId";

  /// Order of flashcards
  static const lessonOrder = "lessonOrder";

  /// -1 = Not Reviewed
  ///  0 = Forgot
  ///  1 = Good
  ///  2 = Easy
  static const reviewResult = "reviewResult";

  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE $tableName(

        $id INTEGER PRIMARY KEY AUTOINCREMENT,

        $lessonDate TEXT NOT NULL,

        $historyId INTEGER NOT NULL,

        $lessonOrder INTEGER NOT NULL,

        $reviewResult INTEGER NOT NULL DEFAULT -1,
        UNIQUE(lessonDate, lessonOrder)

      )
    ''');
  }
}