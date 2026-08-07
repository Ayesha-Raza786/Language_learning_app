import 'package:language_learning/models/quiz_model.dart';

class QuizAnswerResult {
  final QuizQuestionModel question;
  final bool correct;

  QuizAnswerResult({
    required this.question,
    required this.correct,
  });
}