import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../database/translation_history_table.dart';
import '../models/translation_history_model.dart';

class HistoryRepository {

  final DatabaseHelper _databaseHelper =
      DatabaseHelper.instance;

  /// Insert Translation
  Future<int> insertTranslation(
      TranslationHistoryModel translation) async {

    final Database db =
    await _databaseHelper.database;

    final existing = await db.query(
      TranslationHistoryTable.tableName,
      where: '''
    ${TranslationHistoryTable.originalText} = ?
    AND ${TranslationHistoryTable.inputType} = ?
    AND ${TranslationHistoryTable.difficulty} = ?
    AND ${TranslationHistoryTable.sourceLanguageCode} = ?
    AND ${TranslationHistoryTable.targetLanguageCode} = ?
    AND ${TranslationHistoryTable.sourceType} = ?
  ''',
      whereArgs: [
        translation.originalText,
        translation.inputType,
        translation.difficulty,
        translation.sourceLanguageCode,
        translation.targetLanguageCode,
        translation.sourceType,
      ],
    );

    if (existing.isNotEmpty) {

      final id = existing.first["id"] as int;

      final practiceCount =
      (existing.first["practiceCount"] ?? 0) as int;

      await db.update(
        TranslationHistoryTable.tableName,
        {
          TranslationHistoryTable.practiceCount:
          practiceCount + 1,

          TranslationHistoryTable.lastPracticed:
          DateTime.now().toIso8601String(),

          TranslationHistoryTable.isHidden: 0,
        },
        where: "${TranslationHistoryTable.id} = ?",
        whereArgs: [id],
      );

      return id;
    }

    return await db.insert(
      TranslationHistoryTable.tableName,
      translation.toJson(),
    );
  }
  /// Get All Translations
  Future<List<TranslationHistoryModel>>
  getAllTranslations() async {

    final Database db =
    await _databaseHelper.database;
    final List<Map<String, dynamic>> maps =
    await db.query(
      TranslationHistoryTable.tableName,
      where: "${TranslationHistoryTable.sourceType} = ?",
      whereArgs: ["api"],
      orderBy: "${TranslationHistoryTable.createdAt} DESC",
    );
    return maps
        .map(
          (e) =>
          TranslationHistoryModel.fromJson(e),
    )
        .toList();
  }

  /// Delete One Translation
  Future<void> hideTranslation(int id) async {

    final Database db =
    await _databaseHelper.database;

    await db.update(
      TranslationHistoryTable.tableName,
      {
        TranslationHistoryTable.isHidden: 1,
      },
      where: "${TranslationHistoryTable.id} = ?",
      whereArgs: [id],
    );
  }
  /// Delete All History
  Future<void> hideAllHistory() async {

    final Database db =
    await _databaseHelper.database;

    await db.update(
      TranslationHistoryTable.tableName,
      {
        TranslationHistoryTable.isHidden: 1,
      },
    );
  }
  Future<void> restoreAllHistory() async {

    final Database db =
    await _databaseHelper.database;

    await db.update(
      TranslationHistoryTable.tableName,
      {
        TranslationHistoryTable.isHidden: 0,
      },
    );
  }
  Future<void> toggleFavorite(int id) async {

    final Database db =
    await _databaseHelper.database;

    final result = await db.query(
      TranslationHistoryTable.tableName,
      columns: [
        TranslationHistoryTable.isFavorite,
      ],
      where:
      "${TranslationHistoryTable.id} = ?",
      whereArgs: [id],
    );

    if (result.isEmpty) return;

    final current =
    result.first[
    TranslationHistoryTable.isFavorite] as int;

    await db.update(
      TranslationHistoryTable.tableName,
      {
        TranslationHistoryTable.isFavorite:
        current == 1 ? 0 : 1,
      },
      where:
      "${TranslationHistoryTable.id} = ?",
      whereArgs: [id],
    );
  }
  Future<List<TranslationHistoryModel>>
  getFavorites() async {

    final Database db =
    await _databaseHelper.database;

    final maps = await db.query(

      TranslationHistoryTable.tableName,

      where:
      "isFavorite = 1 AND isHidden = 0",

      orderBy:
      "${TranslationHistoryTable.createdAt} DESC",
    );

    return maps
        .map(
          (e) =>
          TranslationHistoryModel.fromJson(e),
    )
        .toList();
  }
  Future<List<TranslationHistoryModel>>
  searchHistory(String query) async {

    final Database db =
    await _databaseHelper.database;

    final normalized =
    query.trim().toLowerCase();

    final maps = await db.query(
      TranslationHistoryTable.tableName,
      where:
      "${TranslationHistoryTable.normalizedText} LIKE ? "
          "AND ${TranslationHistoryTable.isHidden} = ?",
      whereArgs: [
        "%$normalized%",
        0,
      ],
      orderBy:
      "${TranslationHistoryTable.createdAt} DESC",
    );

    return maps
        .map(
          (e) =>
          TranslationHistoryModel.fromJson(e),
    )
        .toList();
  }
  Future<List<TranslationHistoryModel>>
  getRecentTranslations(
      int limit) async {

    final Database db =
    await _databaseHelper.database;

    final maps = await db.query(
      TranslationHistoryTable.tableName,
      where:
      "${TranslationHistoryTable.isHidden}=0",
      orderBy:
      "${TranslationHistoryTable.createdAt} DESC",
      limit: limit,
    );

    return maps
        .map(
          (e) =>
          TranslationHistoryModel.fromJson(e),
    )
        .toList();
  }
  Future<List<TranslationHistoryModel>>
  getRecentLearning() async {

    final Database db =
    await _databaseHelper.database;

    final maps = await db.query(

      TranslationHistoryTable.tableName,

      where:
      "isHidden = 0",

      orderBy:
      "${TranslationHistoryTable.createdAt} DESC",

      limit: 5,
    );

    return maps
        .map(
          (e) =>
          TranslationHistoryModel.fromJson(e),
    )
        .toList();
  }
  Future<bool> translationExists(TranslationHistoryModel item) async {
    final db = await _databaseHelper.database;

    final result = await db.query(
      TranslationHistoryTable.tableName,
      where: '''
      ${TranslationHistoryTable.originalText} = ?
      AND ${TranslationHistoryTable.inputType} = ?
      AND ${TranslationHistoryTable.difficulty} = ?
      AND ${TranslationHistoryTable.sourceType} = ?
    ''',
      whereArgs: [
        item.originalText,
        item.inputType,
        item.difficulty,
        item.sourceType,
      ],
      limit: 1,
    );

    return result.isNotEmpty;
  }
}
