class AIQuizResponseModel {
  final String question;
  final List<String> options;
  final String correctAnswer;

  AIQuizResponseModel({
    required this.question,
    required this.options,
    required this.correctAnswer,
  });

  factory AIQuizResponseModel.fromJson(
      Map<String, dynamic> json) {
    return AIQuizResponseModel(
      question: json['question'] ?? '',
      options: List<String>.from(json['options'] ?? []),
      correctAnswer: json['correctAnswer'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'correctAnswer': correctAnswer,
    };
  }
}