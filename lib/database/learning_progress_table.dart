import 'package:sqflite/sqflite.dart';

import 'database_constants.dart';
import 'table_names.dart';

class LearningProgressTable {
  LearningProgressTable._();

  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${TableNames.learningProgress} (
        ${LearningProgressColumns.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${LearningProgressColumns.wordId} INTEGER NOT NULL UNIQUE,
        ${LearningProgressColumns.isLearned} INTEGER NOT NULL DEFAULT 0,
        ${LearningProgressColumns.revisionCount} INTEGER NOT NULL DEFAULT 0,
        ${LearningProgressColumns.correctAnswers} INTEGER NOT NULL DEFAULT 0,
        ${LearningProgressColumns.wrongAnswers} INTEGER NOT NULL DEFAULT 0,
        ${LearningProgressColumns.lastReviewed} TEXT,
        FOREIGN KEY (${LearningProgressColumns.wordId})
          REFERENCES ${TableNames.words} (${WordColumns.id})
          ON DELETE CASCADE
      )
    ''');
  }
}
