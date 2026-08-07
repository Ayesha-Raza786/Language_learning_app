import 'package:sqflite/sqflite.dart';

abstract final class TranslationHistoryTable {
  static const tableName = "translation_history";

  static const id = "id";

  static const originalText = "originalText";
  static const translatedText = "translatedText";

  static const pronunciation = "pronunciation";
  static const meaning = "meaning";

  static const category = "category";
  static const difficulty = "difficulty";

  static const inputType = "inputType";

  static const sourceLanguageCode = "sourceLanguageCode";
  static const targetLanguageCode = "targetLanguageCode";

  static const createdAt = "createdAt";

  static const isFavorite = "isFavorite";
  static const isHidden = "isHidden";

  static const practiceCount = "practiceCount";

  static const lastPracticed = "lastPracticed";
  static const normalizedText = "normalizedText";
  static const String sourceType = "sourceType";
  static Future<void> createTable(Database db) async {
    await db.execute('''

      CREATE TABLE $tableName(

      $id INTEGER PRIMARY KEY AUTOINCREMENT,

      $originalText TEXT NOT NULL,

      $translatedText TEXT NOT NULL,

      $pronunciation TEXT NOT NULL,

      $meaning TEXT NOT NULL,

      $category TEXT NOT NULL,

      $difficulty TEXT NOT NULL,

      $inputType TEXT NOT NULL,

      $sourceLanguageCode TEXT NOT NULL,

      $targetLanguageCode TEXT NOT NULL,

      $createdAt TEXT NOT NULL,

      $isFavorite INTEGER NOT NULL DEFAULT 0,
      $isHidden INTEGER NOT NULL DEFAULT 0,

$practiceCount INTEGER NOT NULL DEFAULT 0,

$lastPracticed TEXT,
$normalizedText TEXT NOT NULL,
$sourceType TEXT NOT NULL

      )

    ''');
  }
}
