import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../database/translation_history_table.dart';
import '../models/translation_history_model.dart';

class EssentialLearningRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<List<TranslationHistoryModel>> getItems({
    required String inputType,
    required String difficulty,
    String keyword = "",
  }) async {

    final Database db = await _databaseHelper.database;

    final maps = await db.query(
      TranslationHistoryTable.tableName,
      where:
      "${TranslationHistoryTable.sourceType} = ? "
          "AND ${TranslationHistoryTable.inputType} = ? "
          "AND LOWER(${TranslationHistoryTable.difficulty}) = LOWER(?) "
          "AND ${TranslationHistoryTable.originalText} LIKE ?",
      whereArgs: [
        "system",
        inputType,
        difficulty,
        "%$keyword%",
      ],
      orderBy: "${TranslationHistoryTable.originalText} ASC",
    );



    return maps
        .map((e) => TranslationHistoryModel.fromJson(e))
        .toList();
  }

  Future<void> toggleFavorite(int id) async {
    final db = await _databaseHelper.database;

    final result = await db.query(
      TranslationHistoryTable.tableName,
      columns: [TranslationHistoryTable.isFavorite],
      where: "id = ?",
      whereArgs: [id],
    );

    if (result.isEmpty) return;

    final current = (result.first[TranslationHistoryTable.isFavorite] as int);

    await db.update(
      TranslationHistoryTable.tableName,
      {TranslationHistoryTable.isFavorite: current == 1 ? 0 : 1},
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
