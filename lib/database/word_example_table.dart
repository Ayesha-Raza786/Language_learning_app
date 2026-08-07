import 'package:sqflite/sqflite.dart';

import 'database_constants.dart';
import 'table_names.dart';

class WordExampleTable {
  WordExampleTable._();

  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${TableNames.wordExamples} (
        ${WordExampleColumns.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${WordExampleColumns.wordId} INTEGER NOT NULL,
        ${WordExampleColumns.englishSentence} TEXT NOT NULL,
        ${WordExampleColumns.translatedSentence} TEXT NOT NULL,
        FOREIGN KEY (${WordExampleColumns.wordId})
          REFERENCES ${TableNames.words} (${WordColumns.id})
          ON DELETE CASCADE
      )
    ''');
  }
}
