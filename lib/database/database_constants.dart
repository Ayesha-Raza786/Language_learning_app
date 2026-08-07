class DatabaseConstants {
  DatabaseConstants._();

  static const String databaseName = 'language_learning.db';
  static const int databaseVersion = 4;
}

class LanguageColumns {
  LanguageColumns._();

  static const String id = 'id';
  static const String languageName = 'languageName';
  static const String languageCode = 'languageCode';
  static const String flag = 'flag';
}

class CategoryColumns {
  CategoryColumns._();

  static const String id = 'id';
  static const String name = 'name';
  static const String icon = 'icon';
}

class WordColumns {
  WordColumns._();

  static const String id = 'id';
  static const String englishWord = 'englishWord';
  static const String translatedWord = 'translatedWord';
  static const String sourceLanguageCode = 'sourceLanguageCode';
  static const String targetLanguageCode = 'targetLanguageCode';
  static const String pronunciation = 'pronunciation';
  static const String meaning = 'meaning';
  static const String categoryId = 'categoryId';
  static const String difficulty = 'difficulty';
  static const String isCached = 'isCached';
  static const String isFavorite = 'isFavorite';
  static const String lastSearchedAt = 'lastSearchedAt';
  static const String createdAt = 'createdAt';
  static const String updatedAt = 'updatedAt';
}

class WordExampleColumns {
  WordExampleColumns._();

  static const String id = 'id';
  static const String wordId = 'wordId';
  static const String englishSentence = 'englishSentence';
  static const String translatedSentence = 'translatedSentence';
}

class LearningProgressColumns {
  LearningProgressColumns._();

  static const String id = 'id';
  static const String wordId = 'wordId';
  static const String isLearned = 'isLearned';
  static const String revisionCount = 'revisionCount';
  static const String correctAnswers = 'correctAnswers';
  static const String wrongAnswers = 'wrongAnswers';
  static const String lastReviewed = 'lastReviewed';
}

class QuizHistoryColumns {
  QuizHistoryColumns._();

  static const String id = 'id';
  static const String score = 'score';
  static const String totalQuestions = 'totalQuestions';
  static const String categoryId = 'categoryId';
  static const String completedAt = 'completedAt';
}

class SettingsColumns {
  SettingsColumns._();

  static const String id = 'id';
  static const String sourceLanguageCode = 'sourceLanguageCode';
  static const String targetLanguageCode = 'targetLanguageCode';
  static const String theme = 'theme';
  static const String dailyGoal = 'dailyGoal';
}
