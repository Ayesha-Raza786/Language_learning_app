import '../models/api/translation_response_model.dart';
import '../services/gemini_service.dart';

class TranslationRepository {

  final GeminiService service;

  TranslationRepository(this.service);

  Future<TranslationResponseModel> translate({

    required String word,

    required String sourceLanguage,

    required String targetLanguage,

  }) {

    return service.translate(

      word: word,

      sourceLanguage: sourceLanguage,

      targetLanguage: targetLanguage,

    );
  }

}