import 'package:sqflite/sqflite.dart';

import '../database/database_constants.dart';
import '../database/database_helper.dart';
import '../database/table_names.dart';
import '../models/language_model.dart';


class LanguageRepository {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  Future<int> insertLanguage(LanguageModel language) async {
    final db = await _dbHelper.database;

    final id = await db.insert(
      TableNames.languages,
      language.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  Future<List<LanguageModel>> getAllLanguages() async {
    final db = await _dbHelper.database;

    final result = await db.query(
      TableNames.languages,
      orderBy: LanguageColumns.languageName,
    );

    return result
        .map((e) => LanguageModel.fromMap(e))
        .toList();
  }

  Future<LanguageModel?> getLanguageByCode(String code) async {
    final db = await _dbHelper.database;

    final result = await db.query(
      TableNames.languages,
      where: '${LanguageColumns.languageCode} = ?',
      whereArgs: [code],
    );

    if (result.isEmpty) return null;

    return LanguageModel.fromMap(result.first);
  }

  Future<int> updateLanguage(LanguageModel language) async {
    final db = await _dbHelper.database;

    return await db.update(
      TableNames.languages,
      language.toMap(),
      where: '${LanguageColumns.id} = ?',
      whereArgs: [language.id],
    );
  }

  Future<int> deleteLanguage(int id) async {
    final db = await _dbHelper.database;

    return await db.delete(
      TableNames.languages,
      where: '${LanguageColumns.id} = ?',
      whereArgs: [id],
    );
  }

  Future<bool> isEmpty() async {
    final db = await _dbHelper.database;

    final result = await db.query(TableNames.languages);

    return result.isEmpty;
  }
  Future<void> seedLanguages() async {


    if (!(await isEmpty())) {

      return;
    }

    final languages = [
      LanguageModel(languageName: "English", languageCode: "en", flag: "🇬🇧"),
      LanguageModel(languageName: "Turkish", languageCode: "tr", flag: "🇹🇷"),
      LanguageModel(languageName: "Arabic", languageCode: "ar", flag: "🇸🇦"),
      LanguageModel(languageName: "Urdu", languageCode: "ur", flag: "🇵🇰"),
      LanguageModel(languageName: "French", languageCode: "fr", flag: "🇫🇷"),
      LanguageModel(languageName: "German", languageCode: "de", flag: "🇩🇪"),
      LanguageModel(languageName: "Spanish", languageCode: "es", flag: "🇪🇸"),
      LanguageModel(languageName: "Pashto", languageCode: "ps", flag: "🏳"),
    ];

  }
}