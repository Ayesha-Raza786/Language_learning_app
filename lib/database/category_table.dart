import 'package:sqflite/sqflite.dart';

import 'database_constants.dart';
import 'table_names.dart';

class CategoryTable {
  CategoryTable._();

  static Future<void> createTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${TableNames.categories} (
        ${CategoryColumns.id} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${CategoryColumns.name} TEXT NOT NULL,
        ${CategoryColumns.icon} TEXT NOT NULL
      )
    ''');
  }
}
