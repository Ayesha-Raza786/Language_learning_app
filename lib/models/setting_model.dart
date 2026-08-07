class SettingsModel {
  final int? id;
  final String sourceLanguageCode;
  final String targetLanguageCode;
  final String theme;
  final int dailyGoal;

  SettingsModel({
    this.id,
    required this.sourceLanguageCode,
    required this.targetLanguageCode,
    required this.theme,
    required this.dailyGoal,
  });

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    return SettingsModel(
      id: map['id'],
      sourceLanguageCode: map['sourceLanguageCode'],
      targetLanguageCode: map['targetLanguageCode'],
      theme: map['theme'],
      dailyGoal: map['dailyGoal'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'sourceLanguageCode': sourceLanguageCode,
      'targetLanguageCode': targetLanguageCode,
      'theme': theme,
      'dailyGoal': dailyGoal,
    };
  }
}
