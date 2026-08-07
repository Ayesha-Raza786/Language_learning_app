class TranslationHistoryModel {
  int? id;

  final String originalText;
  final String translatedText;

  final String pronunciation;
  final String meaning;

  final String category;
  final String difficulty;
  final String inputType;

  final String sourceLanguageCode;
  final String targetLanguageCode;

  final String createdAt;

  final bool isFavorite;

  final bool isHidden;

  final int practiceCount;

  final String? lastPracticed;
  final String normalizedText;
  final String sourceType;
  TranslationHistoryModel({
    this.id,
    required this.originalText,
    required this.translatedText,
    required this.pronunciation,
    required this.meaning,
    required this.category,
    required this.difficulty,
    required this.inputType,
    required this.sourceLanguageCode,
    required this.targetLanguageCode,
    required this.createdAt,
    required this.normalizedText,
    required this.sourceType,
    this.isFavorite = false,
    this.isHidden = false,
    this.practiceCount = 0,
    this.lastPracticed,

  });


  factory TranslationHistoryModel.fromJson(
      Map<String, dynamic> json, {
        String sourceType = "api",
      }) {
    return TranslationHistoryModel(
      id: json["id"],

      originalText: json["originalText"] ?? "",
      normalizedText: json["normalizedText"] ?? "",


      translatedText: json["translatedText"] ?? "",

      pronunciation: json["pronunciation"] ?? "",

      meaning: json["meaning"] ?? "",

      category: json["category"] ?? "",

      difficulty: json["difficulty"] ?? "",

      inputType: json["inputType"] ?? "word",

      sourceLanguageCode:
      json["sourceLanguageCode"] ?? "en",

      targetLanguageCode:
      json["targetLanguageCode"] ?? "tr",

      createdAt:
      json["createdAt"] ?? "",

      isFavorite:
      (json["isFavorite"] ?? 0) == 1,

      isHidden:
      (json["isHidden"] ?? 0) == 1,

      practiceCount:
      json["practiceCount"] ?? 0,

      lastPracticed:
      json["lastPracticed"],
      sourceType:
      json["sourceType"] ?? sourceType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // "id": id,
      "normalizedText": normalizedText,
      "originalText": originalText,

      "translatedText": translatedText,

      "pronunciation": pronunciation,

      "meaning": meaning,

      "category": category,

      "difficulty": difficulty,

      "inputType": inputType,

      "sourceLanguageCode":
      sourceLanguageCode,

      "targetLanguageCode":
      targetLanguageCode,

      "createdAt": createdAt,

      "isFavorite":
      isFavorite ? 1 : 0,

      "isHidden":
      isHidden ? 1 : 0,

      "practiceCount":
      practiceCount,

      "lastPracticed":
      lastPracticed,
      "sourceType":sourceType,
    };
  }
}