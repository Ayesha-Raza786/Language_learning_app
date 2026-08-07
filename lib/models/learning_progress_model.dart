class LearningProgressModel {
  final int? id;
  final int wordId;
  final bool isLearned;
  final int revisionCount;
  final int correctAnswers;
  final int wrongAnswers;
  final String? lastReviewed;

  LearningProgressModel({
    this.id,
    required this.wordId,
    this.isLearned = false,
    this.revisionCount = 0,
    this.correctAnswers = 0,
    this.wrongAnswers = 0,
    this.lastReviewed,
  });

  factory LearningProgressModel.fromMap(Map<String, dynamic> map) {
    return LearningProgressModel(
      id: map['id'],
      wordId: map['wordId'],
      isLearned: map['isLearned'] == 1,
      revisionCount: map['revisionCount'],
      correctAnswers: map['correctAnswers'],
      wrongAnswers: map['wrongAnswers'],
      lastReviewed: map['lastReviewed'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'wordId': wordId,
      'isLearned': isLearned ? 1 : 0,
      'revisionCount': revisionCount,
      'correctAnswers': correctAnswers,
      'wrongAnswers': wrongAnswers,
      'lastReviewed': lastReviewed,
    };
  }
}