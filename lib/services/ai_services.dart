import '../models/api/translation_response_model.dart';

abstract class AIService {
  Future<TranslationResponseModel> translate({
    required String text,
    required String sourceLanguage,
    required String targetLanguage,
  });
}