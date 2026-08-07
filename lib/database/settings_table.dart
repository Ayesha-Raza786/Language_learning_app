import 'package:sqflite/sqflite.dart';

import 'database_constants.dart';
import 'table_names.dart';

class SettingsTable {
  SettingsTable._();

  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${TableNames.settings} (
        ${SettingsColumns.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${SettingsColumns.sourceLanguageCode} TEXT NOT NULL,
        ${SettingsColumns.targetLanguageCode} TEXT NOT NULL,
        ${SettingsColumns.theme} TEXT NOT NULL,
        ${SettingsColumns.dailyGoal} INTEGER NOT NULL,
        FOREIGN KEY (${SettingsColumns.sourceLanguageCode})
          REFERENCES ${TableNames.languages} (${LanguageColumns.languageCode}),
        FOREIGN KEY (${SettingsColumns.targetLanguageCode})
          REFERENCES ${TableNames.languages} (${LanguageColumns.languageCode})
      )
    ''');
  }
}
