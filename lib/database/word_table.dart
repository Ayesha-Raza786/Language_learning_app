import 'package:sqflite/sqflite.dart';

import 'database_constants.dart';
import 'table_names.dart';

class WordTable {
  WordTable._();

  static const String idxWordSearch = 'idx_word_search';
  static const String idxCategory = 'idx_category';
  static const String idxFavorite = 'idx_favorite';

  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${TableNames.words}(

        ${WordColumns.id} INTEGER PRIMARY KEY AUTOINCREMENT,

        ${WordColumns.englishWord} TEXT NOT NULL,

        ${WordColumns.translatedWord} TEXT NOT NULL,

        ${WordColumns.sourceLanguageCode} TEXT NOT NULL,

        ${WordColumns.targetLanguageCode} TEXT NOT NULL,

        ${WordColumns.pronunciation} TEXT,

        ${WordColumns.meaning} TEXT,

        ${WordColumns.categoryId} INTEGER NOT NULL,

        ${WordColumns.difficulty} TEXT,

        ${WordColumns.isCached} INTEGER NOT NULL DEFAULT 0,

        ${WordColumns.isFavorite} INTEGER NOT NULL DEFAULT 0,

        ${WordColumns.lastSearchedAt} TEXT,

        ${WordColumns.createdAt} TEXT NOT NULL,

        ${WordColumns.updatedAt} TEXT NOT NULL,

        UNIQUE(
          ${WordColumns.englishWord},
          ${WordColumns.sourceLanguageCode},
          ${WordColumns.targetLanguageCode}
        ),

        FOREIGN KEY(${WordColumns.categoryId})
REFERENCES ${TableNames.categories}(${CategoryColumns.id})
ON UPDATE CASCADE
ON DELETE RESTRICT
        FOREIGN KEY(${WordColumns.sourceLanguageCode})
REFERENCES ${TableNames.languages}(${LanguageColumns.languageCode})
ON UPDATE CASCADE
ON DELETE RESTRICT

        FOREIGN KEY(${WordColumns.targetLanguageCode})
REFERENCES ${TableNames.languages}(${LanguageColumns.languageCode})
ON UPDATE CASCADE
ON DELETE RESTRICT

      )
    ''');

    await db.execute('''
      CREATE INDEX $idxWordSearch
      ON ${TableNames.words}
      (${WordColumns.englishWord})
    ''');

    await db.execute('''
      CREATE INDEX $idxCategory
      ON ${TableNames.words}
      (${WordColumns.categoryId})
    ''');

    await db.execute('''
      CREATE INDEX $idxFavorite
      ON ${TableNames.words}
      (${WordColumns.isFavorite})
    ''');
  }
}
