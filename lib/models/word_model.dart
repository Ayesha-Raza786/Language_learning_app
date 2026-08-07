class WordModel {
  final int? id;
  final String englishWord;
  final String translatedWord;
  final String sourceLanguageCode;
  final String targetLanguageCode;
  final String pronunciation;
  final String meaning;
  final int categoryId;
  final String difficulty;
  final bool isCached;
  final bool isFavorite;
  final String? lastSearchedAt;
  final String createdAt;
  final String updatedAt;

  WordModel({
    this.id,
    required this.englishWord,
    required this.translatedWord,
    required this.sourceLanguageCode,
    required this.targetLanguageCode,
    required this.pronunciation,
    required this.meaning,
    required this.categoryId,
    required this.difficulty,
    this.isCached = false,
    this.isFavorite = false,
    this.lastSearchedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory WordModel.fromMap(Map<String, dynamic> map) {
    return WordModel(
      id: map['id'],
      englishWord: map['englishWord'],
      translatedWord: map['translatedWord'],
      sourceLanguageCode: map['sourceLanguageCode'],
      targetLanguageCode: map['targetLanguageCode'],
      pronunciation: map['pronunciation'],
      meaning: map['meaning'],
      categoryId: map['categoryId'],
      difficulty: map['difficulty'],
      isCached: map['isCached'] == 1,
      isFavorite: map['isFavorite'] == 1,
      lastSearchedAt: map['lastSearchedAt'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'englishWord': englishWord,
      'translatedWord': translatedWord,
      'sourceLanguageCode': sourceLanguageCode,
      'targetLanguageCode': targetLanguageCode,
      'pronunciation': pronunciation,
      'meaning': meaning,
      'categoryId': categoryId,
      'difficulty': difficulty,
      'isCached': isCached ? 1 : 0,
      'isFavorite': isFavorite ? 1 : 0,
      'lastSearchedAt': lastSearchedAt,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  WordModel copyWith({
    int? id,
    String? englishWord,
    String? translatedWord,
    String? sourceLanguageCode,
    String? targetLanguageCode,
    String? pronunciation,
    String? meaning,
    int? categoryId,
    String? difficulty,
    bool? isCached,
    bool? isFavorite,
    String? lastSearchedAt,
    String? createdAt,
    String? updatedAt,
  }) {
    return WordModel(
      id: id ?? this.id,
      englishWord: englishWord ?? this.englishWord,
      translatedWord: translatedWord ?? this.translatedWord,
      sourceLanguageCode: sourceLanguageCode ?? this.sourceLanguageCode,
      targetLanguageCode: targetLanguageCode ?? this.targetLanguageCode,
      pronunciation: pronunciation ?? this.pronunciation,
      meaning: meaning ?? this.meaning,
      categoryId: categoryId ?? this.categoryId,
      difficulty: difficulty ?? this.difficulty,
      isCached: isCached ?? this.isCached,
      isFavorite: isFavorite ?? this.isFavorite,
      lastSearchedAt: lastSearchedAt ?? this.lastSearchedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
