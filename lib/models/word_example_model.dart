class WordExampleModel {
  final int? id;
  final int wordId;
  final String englishSentence;
  final String translatedSentence;

  WordExampleModel({
    this.id,
    required this.wordId,
    required this.englishSentence,
    required this.translatedSentence,
  });

  factory WordExampleModel.fromMap(Map<String, dynamic> map) {
    return WordExampleModel(
      id: map['id'],
      wordId: map['wordId'],
      englishSentence: map['englishSentence'],
      translatedSentence: map['translatedSentence'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'wordId': wordId,
      'englishSentence': englishSentence,
      'translatedSentence': translatedSentence,
    };
  }
}