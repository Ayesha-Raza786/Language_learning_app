enum DifficultyLevel {
  beginner,
  intermediate,
  advanced,
}

class AIWordResponseModel {
  final String englishWord;
  final String translatedWord;

  final String pronunciation;
  final String meaning;

  final String category;

  final DifficultyLevel difficulty;

  AIWordResponseModel({
    required this.englishWord,
    required this.translatedWord,
    required this.pronunciation,
    required this.meaning,
    required this.category,
    required this.difficulty,
  });

  factory AIWordResponseModel.fromJson(
      Map<String, dynamic> json) {
    return AIWordResponseModel(
      englishWord: json["englishWord"] ?? "",

      translatedWord:
      json["translatedWord"] ?? "",

      pronunciation:
      json["pronunciation"] ?? "",

      meaning:
      json["meaning"] ?? "",

      category:
      json["category"] ?? "",

      difficulty: DifficultyLevel.values.firstWhere(
            (e) =>
        e.name ==
            (json["difficulty"] ?? "beginner"),
        orElse: () => DifficultyLevel.beginner,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "englishWord": englishWord,
      "translatedWord": translatedWord,
      "pronunciation": pronunciation,
      "meaning": meaning,
      "category": category,
      "difficulty": difficulty.name,
    };
  }
}