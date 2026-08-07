class QuizQuestionModel {
  final int historyId;

  /// Text shown to the user
  final String question;

  /// Correct answer
  final String correctAnswer;

  /// Four shuffled options
  final List<String> options;

  /// false = English → Turkish
  /// true = Turkish → English
  final bool isReverse;

  /// word | phrase | sentence
  final String inputType;

  QuizQuestionModel({
    required this.historyId,
    required this.question,
    required this.correctAnswer,
    required this.options,
    required this.isReverse,
    required this.inputType,
  });
}