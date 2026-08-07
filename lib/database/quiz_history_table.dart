import 'package:sqflite/sqflite.dart';

import 'database_constants.dart';
import 'table_names.dart';

class QuizHistoryTable {
  QuizHistoryTable._();

  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${TableNames.quizHistory} (
        ${QuizHistoryColumns.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${QuizHistoryColumns.score} INTEGER NOT NULL,
        ${QuizHistoryColumns.totalQuestions} INTEGER NOT NULL,
        ${QuizHistoryColumns.categoryId} INTEGER NOT NULL,
        ${QuizHistoryColumns.completedAt} TEXT NOT NULL,
        FOREIGN KEY (${QuizHistoryColumns.categoryId})
          REFERENCES ${TableNames.categories} (${CategoryColumns.id})
      )
    ''');
  }
}
