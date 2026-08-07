enum DifficultyLevel {
  beginner,
  intermediate,
  advanced,
}

enum InputType {
  word,
  phrase,
  sentence,
}

class TranslationDataModel {
  final String originalText;

  final String translatedText;

  final String pronunciation;

  final String meaning;

  final String category;

  final DifficultyLevel difficulty;

  final InputType inputType;

  TranslationDataModel({
    required this.originalText,
    required this.translatedText,
    required this.pronunciation,
    required this.meaning,
    required this.category,
    required this.difficulty,
    required this.inputType,
  });

  factory TranslationDataModel.fromJson(
      Map<String, dynamic> json) {
    return TranslationDataModel(
      originalText: json["originalText"] ?? "",

      translatedText:
      json["translatedText"] ?? "",

      pronunciation:
      json["pronunciation"] ?? "",

      meaning:
      json["meaning"] ?? "",

      category:
      json["category"] ?? "",

      difficulty: DifficultyLevel.values.firstWhere(
            (e) =>
        e.name ==
            (json["difficulty"] ??
                "beginner"),
        orElse: () =>
        DifficultyLevel.beginner,
      ),

      inputType: InputType.values.firstWhere(
            (e) =>
        e.name ==
            (json["inputType"] ??
                "word"),
        orElse: () => InputType.word,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "originalText": originalText,
      "translatedText": translatedText,
      "pronunciation": pronunciation,
      "meaning": meaning,
      "category": category,
      "difficulty": difficulty.name,
      "inputType": inputType.name,
    };
  }
}