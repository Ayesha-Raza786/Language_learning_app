import 'package:sqflite/sqflite.dart';

import 'database_constants.dart';
import 'table_names.dart';

class LanguageTable {
  LanguageTable._();

  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${TableNames.languages} (
        ${LanguageColumns.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${LanguageColumns.languageName} TEXT NOT NULL,
        ${LanguageColumns.languageCode} TEXT NOT NULL UNIQUE,
        ${LanguageColumns.flag} TEXT NOT NULL
      )
    ''');
  }
}
