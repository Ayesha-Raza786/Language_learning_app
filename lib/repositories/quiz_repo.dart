import 'dart:math';

import '../models/daily_lesson_item_model.dart';

import '../models/quiz_model.dart';
import 'daily_lesson_repo.dart';

class QuizRepository {

  final DailyLessonRepository repository =
  DailyLessonRepository();
  Future<List<QuizQuestionModel>> generateQuiz() async {
    final lesson = await repository.getTodayLesson();

    if (lesson.isEmpty) {
      return [];
    }

    final List<QuizQuestionModel> questions = [];

    for (final item in lesson) {
      questions.add(
        _forwardQuestion(item, lesson),
      );

      questions.add(
        _reverseQuestion(item, lesson),
      );
    }

    questions.shuffle();

    return questions;
  }
  QuizQuestionModel _forwardQuestion(
      DailyLessonItemModel item,
      List<DailyLessonItemModel> lesson,
      ) {
    return QuizQuestionModel(
      historyId: item.translation.id!,
      question: item.translation.originalText,
      correctAnswer: item.translation.translatedText,
      options: _generateOptions(
        lesson,
        item.translation.translatedText,
        false,
      ),
      isReverse: false,
      inputType: item.translation.inputType,
    );
  }
  QuizQuestionModel _reverseQuestion(
      DailyLessonItemModel item,
      List<DailyLessonItemModel> lesson,
      ) {
    return QuizQuestionModel(
      historyId: item.translation.id!,
      question: item.translation.translatedText,
      correctAnswer: item.translation.originalText,
      options: _generateOptions(
        lesson,
        item.translation.originalText,
        true,
      ),
      isReverse: true,
      inputType: item.translation.inputType,
    );
  }
  List<String> _generateOptions(
      List<DailyLessonItemModel> lesson,
      String correctAnswer,
      bool reverse,
      ) {
    final options = <String>{};

    options.add(correctAnswer);

    for (final item in lesson) {
      final value = reverse
          ? item.translation.originalText
          : item.translation.translatedText;

      if (value != correctAnswer) {
        options.add(value);
      }

      if (options.length == 4) {
        break;
      }
    }

    final list = options.toList();

    list.shuffle();

    return list;
  }
  Future<int> totalQuestions() async {
    final lesson = await repository.getTodayLesson();

    return lesson.length * 2;
  }
  Future<int> totalWords() async {
    final lesson = await repository.getTodayLesson();

    return lesson
        .where((e) => e.translation.inputType == "word")
        .length;
  }
  Future<int> totalPhrases() async {
    final lesson = await repository.getTodayLesson();

    return lesson
        .where((e) => e.translation.inputType == "phrase")
        .length;
  }
  Future<int> totalSentences() async {
    final lesson = await repository.getTodayLesson();

    return lesson
        .where((e) => e.translation.inputType == "sentence")
        .length;
  }
}