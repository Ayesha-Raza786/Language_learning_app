class LanguageModel {
  final int? id;
  final String languageName;
  final String languageCode;
  final String flag;

  LanguageModel({
    this.id,
    required this.languageName,
    required this.languageCode,
    required this.flag,
  });

  factory LanguageModel.fromMap(Map<String, dynamic> map) {
    return LanguageModel(
      id: map['id'],
      languageName: map['languageName'],
      languageCode: map['languageCode'],
      flag: map['flag'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'languageName': languageName,
      'languageCode': languageCode,
      'flag': flag,
    };
  }

  LanguageModel copyWith({
    int? id,
    String? languageName,
    String? languageCode,
    String? flag,
  }) {
    return LanguageModel(
      id: id ?? this.id,
      languageName: languageName ?? this.languageName,
      languageCode: languageCode ?? this.languageCode,
      flag: flag ?? this.flag,
    );
  }
}