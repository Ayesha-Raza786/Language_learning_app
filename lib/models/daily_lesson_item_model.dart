import 'daily_lesson_model.dart';
import 'translation_history_model.dart';

class DailyLessonItemModel {

  final DailyLessonModel lesson;

  final TranslationHistoryModel translation;

  DailyLessonItemModel({
    required this.lesson,
    required this.translation,
  });

}