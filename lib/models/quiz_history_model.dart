class QuizHistoryModel {
  final int? id;
  final int score;
  final int totalQuestions;
  final int categoryId;
  final String completedAt;

  QuizHistoryModel({
    this.id,
    required this.score,
    required this.totalQuestions,
    required this.categoryId,
    required this.completedAt,
  });

  factory QuizHistoryModel.fromMap(Map<String, dynamic> map) {
    return QuizHistoryModel(
      id: map['id'],
      score: map['score'],
      totalQuestions: map['totalQuestions'],
      categoryId: map['categoryId'],
      completedAt: map['completedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'score': score,
      'totalQuestions': totalQuestions,
      'categoryId': categoryId,
      'completedAt': completedAt,
    };
  }
}