import 'package:sqflite/sqflite.dart';
import '../database/daily_lesson_table.dart';
import '../database/database_helper.dart';
import '../database/translation_history_table.dart';
import '../models/daily_lesson_item_model.dart';
import '../models/daily_lesson_model.dart';
import '../models/translation_history_model.dart';

class ReviewMistakesRepository {
  final DatabaseHelper _databaseHelper =
      DatabaseHelper.instance;

  Future<List<DailyLessonItemModel>> getMistakes() async {
    final Database db = await _databaseHelper.database;

    final today =
    DateTime.now().toIso8601String().substring(0, 10);
    final maps = await db.rawQuery(
      '''
SELECT

dl.id AS lessonId,
dl.lessonDate,
dl.historyId,
dl.lessonOrder,
dl.reviewResult,

th.id AS translationId,
th.originalText,
th.translatedText,
th.pronunciation,
th.meaning,
th.category,
th.difficulty,
th.inputType,
th.sourceLanguageCode,
th.targetLanguageCode,
th.createdAt,
th.isFavorite,
th.isHidden,
th.practiceCount,
th.lastPracticed,
th.normalizedText,
th.sourceType
FROM ${DailyLessonTable.tableName} dl

INNER JOIN ${TranslationHistoryTable.tableName} th
ON dl.historyId = th.id

WHERE dl.reviewResult = 0
AND dl.lessonDate = ?

ORDER BY dl.lessonOrder
''',
      [today],
    );

    return maps.map((json) {
      return DailyLessonItemModel(
        lesson: DailyLessonModel(
          id: json["lessonId"] as int,
          lessonDate: json["lessonDate"] as String,
          historyId: json["historyId"] as int,
          lessonOrder: json["lessonOrder"] as int,
          reviewResult: json["reviewResult"] as int,
        ),

        translation: TranslationHistoryModel(
          id: json["translationId"] as int,
          originalText: json["originalText"] as String,
          translatedText: json["translatedText"] as String,
          pronunciation: json["pronunciation"] as String,
          meaning: json["meaning"] as String,
          category: json["category"] as String,
          difficulty: json["difficulty"] as String,
          inputType: json["inputType"] as String,
          sourceLanguageCode: json["sourceLanguageCode"] as String,
          targetLanguageCode: json["targetLanguageCode"] as String,
          createdAt: json["createdAt"] as String,
          isFavorite: (json["isFavorite"] as int) == 1,
          isHidden: (json["isHidden"] as int) == 1,
          practiceCount: json["practiceCount"] as int,
          lastPracticed: json["lastPracticed"] as String?,
          normalizedText: json["normalizedText"] as String,
          sourceType: json["sourceType"] as String,
        ),
      );
    }).toList();
  }
  Future<void> updateReviewResult({
    required int lessonId,
    required int reviewResult,
  }) async {
    final db = await _databaseHelper.database;

    await db.update(
      DailyLessonTable.tableName,
      {
        "reviewResult": reviewResult,
      },
      where: "id = ?",
      whereArgs: [lessonId],
    );
  }
}