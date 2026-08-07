class AIExampleResponseModel {
  final String englishSentence;

  final String translatedSentence;

  AIExampleResponseModel({
    required this.englishSentence,
    required this.translatedSentence,
  });

  factory AIExampleResponseModel.fromJson(
      Map<String, dynamic> json) {
    return AIExampleResponseModel(
      englishSentence:
      json["englishSentence"] ?? "",

      translatedSentence:
      json["translatedSentence"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "englishSentence": englishSentence,
      "translatedSentence":
      translatedSentence,
    };
  }
}