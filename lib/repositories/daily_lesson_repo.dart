import 'package:sqflite/sqflite.dart';

import '../database/database_helper.dart';
import '../database/daily_lesson_table.dart';
import '../database/translation_history_table.dart';
import '../models/daily_lesson_item_model.dart';
import '../models/daily_lesson_model.dart';
import '../models/translation_history_model.dart';

class DailyLessonRepository {
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Future<bool> lessonExistsToday() async {
    final Database db = await _databaseHelper.database;

    final today = DateTime.now().toIso8601String().substring(0, 10);

    final result = await db.query(
      DailyLessonTable.tableName,
      where: "${DailyLessonTable.lessonDate} = ?",
      whereArgs: [today],
      limit: 1,
    );

    return result.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> _getItems({
    required Database db,
    required String inputType,
    required int limit,
    String? category,
  }) async {
    List<Map<String, dynamic>> result;

    if (category != null) {
      result = await db.query(
        TranslationHistoryTable.tableName,
        where:
        "${TranslationHistoryTable.inputType}=? AND "
            "${TranslationHistoryTable.category}=?",
        whereArgs: [inputType, category],
        orderBy:
        "${TranslationHistoryTable.practiceCount} ASC,"
            "${TranslationHistoryTable.lastPracticed} ASC",
        limit: limit,
      );
    } else {
      result = [];
    }

    if (result.length < limit) {
      final remain = limit - result.length;

      final extra = await db.query(
        TranslationHistoryTable.tableName,
        where:
        "${TranslationHistoryTable.inputType}=?",
        whereArgs: [inputType],
        orderBy:
        "${TranslationHistoryTable.practiceCount} ASC,"
            "${TranslationHistoryTable.lastPracticed} ASC",
        limit: remain,
      );

      result.addAll(extra);
    }

    return result;
  }

  Future<List<DailyLessonItemModel>> getTodayLesson() async {
    final Database db = await _databaseHelper.database;

    final today = DateTime.now().toIso8601String().substring(0, 10);

    final List<Map<String, dynamic>> maps = await db.rawQuery(
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

WHERE dl.lessonDate = ?

ORDER BY dl.lessonOrder ASC
''',
      [today],
    );
    if (maps.isEmpty) {
      print("No lesson found for today.");
      return [];
    }


    return maps.map((json) {
      return DailyLessonItemModel(
        lesson: DailyLessonModel(
          id: json["lessonId"],
          lessonDate: json["lessonDate"],
          historyId: json["historyId"],
          lessonOrder: json["lessonOrder"],
          reviewResult: json["reviewResult"],
        ),

        translation: TranslationHistoryModel(
          id: json["translationId"],
          originalText: json["originalText"],
          translatedText: json["translatedText"],
          pronunciation: json["pronunciation"],
          meaning: json["meaning"],
          category: json["category"],
          difficulty: json["difficulty"],
          inputType: json["inputType"],
          sourceLanguageCode: json["sourceLanguageCode"],
          targetLanguageCode: json["targetLanguageCode"],
          createdAt: json["createdAt"],
          isFavorite: json["isFavorite"] == 1,
          isHidden: json["isHidden"] == 1,
          practiceCount: json["practiceCount"],
          lastPracticed: json["lastPracticed"],
          normalizedText: json["normalizedText"],
          sourceType: json["sourceType"],
        ),
      );
    }).toList();
  }

  Future<void> insertLesson(DailyLessonModel lesson) async {
    final Database db = await _databaseHelper.database;

    await db.insert(
      DailyLessonTable.tableName,
      lesson.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateReviewResult({
    required int lessonId,
    required int reviewResult,
  }) async {
    final Database db = await _databaseHelper.database;

    final count = await db.update(
      DailyLessonTable.tableName,
      {
        DailyLessonTable.reviewResult: reviewResult,
      },
      where: "${DailyLessonTable.id} = ?",
      whereArgs: [lessonId],
    );

    final rows = await db.query(
      DailyLessonTable.tableName,
      where: "${DailyLessonTable.id} = ?",
      whereArgs: [lessonId],
    );

  }

  Future<void> deleteTodayLesson() async {
    final Database db = await _databaseHelper.database;

    final today = DateTime.now().toIso8601String().substring(0, 10);

    await db.delete(
      DailyLessonTable.tableName,

      where: "${DailyLessonTable.lessonDate} = ?",

      whereArgs: [today],
    );
  }

  Future<void> clearOldLessons() async {
    final Database db = await _databaseHelper.database;

    final today = DateTime.now().toIso8601String().substring(0, 10);

    await db.delete(
      DailyLessonTable.tableName,

      where: "${DailyLessonTable.lessonDate} != ?",

      whereArgs: [today],
    );
  }
  Future<String?> _getTodayCategory() async {
    final Database db = await _databaseHelper.database;

    final result = await db.rawQuery('''
    SELECT category
    FROM ${TranslationHistoryTable.tableName}
    WHERE isHidden = 0
      AND category IS NOT NULL
      AND category != ''
    GROUP BY category
    ORDER BY MIN(practiceCount) ASC,
             MIN(createdAt) ASC
    LIMIT 1
  ''');

    if (result.isEmpty) {
      return null;
    }

    return result.first["category"] as String;
  }

  Future<void> generateTodayLesson() async {


    await clearOldLessons();

    final exists = await lessonExistsToday();


    if (exists) {
      return;
    }

    final Database db = await _databaseHelper.database;

    final today = DateTime.now().toIso8601String().substring(0, 10);


    final category = await _getTodayCategory();

    final words = await _getItems(
      db: db,
      inputType: "word",
      limit: 4,
      category: category,
    );

    final phrases = await _getItems(
      db: db,
      inputType: "phrase",
      limit: 2,
      category: category,
    );

    final sentences = await _getItems(
      db: db,
      inputType: "sentence",
      limit: 2,
      category: category,
    );
    final translations = [
      ...words,
      ...phrases,
      ...sentences,
    ];

    translations.shuffle();
    final all = await db.rawQuery("""
SELECT
id,
originalText,
isHidden,
practiceCount,
createdAt
FROM ${TranslationHistoryTable.tableName}
ORDER BY id
""");




    int lessonSize = translations.length < 8 ? translations.length : 8;

    for (int i = 0; i < lessonSize; i++) {


      await insertLesson(
        DailyLessonModel(
          lessonDate: today,
          historyId: translations[i][TranslationHistoryTable.id] as int,
          lessonOrder: i + 1,
        ),
      );
    }

    final rows = await db.query(DailyLessonTable.tableName);

  }

  Future<void> updatePractice({
    required int historyId,
    required int increment,
  }) async {
    final Database db = await _databaseHelper.database;

    await db.rawUpdate(
      '''
    UPDATE ${TranslationHistoryTable.tableName}

    SET

    ${TranslationHistoryTable.practiceCount} =
    ${TranslationHistoryTable.practiceCount} + ?,

    ${TranslationHistoryTable.lastPracticed} = ?

    WHERE

    ${TranslationHistoryTable.id} = ?
    ''',
      [increment, DateTime.now().toIso8601String(), historyId],
    );
  }

  Future<DailyLessonItemModel?> getFirstLesson() async {

    final lessons = await getTodayLesson();

    if (lessons.isEmpty) {
      return null;
    }

    return lessons.first;
  }
  Future<int> getResumeIndex() async {
    final db = await _databaseHelper.database;

    final today = DateTime.now().toIso8601String().substring(0, 10);

    final rows = await db.query(
      DailyLessonTable.tableName,
      where:
      "${DailyLessonTable.lessonDate}=? AND ${DailyLessonTable.reviewResult}=-1",
      whereArgs: [today],
      orderBy: "${DailyLessonTable.lessonOrder} ASC",
      limit: 1,
    );

    if (rows.isEmpty) {
      return 0; // or another value indicating completed
    }

    return (rows.first[DailyLessonTable.lessonOrder] as int) - 1;
  }
  Future<DailyLessonItemModel?> getCurrentLesson() async {
    await generateTodayLesson();

    final lessons = await getTodayLesson();

    if (lessons.isEmpty) {
      return null;
    }

    final resumeIndex = await getResumeIndex();

    if (resumeIndex >= lessons.length) {
      return lessons.last;
    }

    return lessons[resumeIndex];
  }
  Future<bool> isLessonCompleted() async {
    final db = await _databaseHelper.database;

    final today = DateTime.now().toIso8601String().substring(0, 10);

    final result = await db.query(
      DailyLessonTable.tableName,
      where:
      "${DailyLessonTable.lessonDate} = ? AND ${DailyLessonTable.reviewResult} = ?",
      whereArgs: [today, -1],
      limit: 1,
    );

    return result.isEmpty;
  }
  Future<void> printLessonTable() async {
    final db = await _databaseHelper.database;

    final rows = await db.query(
      DailyLessonTable.tableName,
      orderBy: "${DailyLessonTable.lessonOrder} ASC",
    );

  }
}
