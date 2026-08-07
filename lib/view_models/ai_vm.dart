import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/api/translation_response_model.dart';
import '../models/translation_history_model.dart';
import '../repositories/ai_repo.dart';
import '../repositories/history_repo.dart';
import 'history_vm.dart';

class TranslationController extends GetxController {

  final TranslationRepository repository;
  final HistoryRepository historyRepository;

  TranslationController(
      this.repository,
      this.historyRepository,
      );

  final TextEditingController textController =
  TextEditingController();

  final RxString selectedSource = "en".obs;
  final RxString selectedTarget = "tr".obs;

  final RxBool isLoading = false.obs;

  final Rxn<TranslationResponseModel> translation =
  Rxn<TranslationResponseModel>();
  String detectInputType(String text) {

    final input = text.trim();

    if (input.contains(RegExp(r'[.!?]'))) {
      return "sentence";
    }

    final words = input.split(RegExp(r'\s+'));

    if (words.length == 1) {
      return "word";
    }

    return "phrase";
  }

  Future<void> translate() async {
    if (textController.text.trim().isEmpty) return;

    try {
      isLoading.value = true;

      translation.value = await repository.translate(
        word: textController.text.trim(),
        sourceLanguage: selectedSource.value,
        targetLanguage: selectedTarget.value,
      );
      final result = translation.value!;

      final inputType = detectInputType(
        textController.text.trim(),
      );
      /// Stop if Gemini says the input is invalid
      if (result.translation.category.toLowerCase() == "invalid") {

        Get.snackbar(
          "Invalid Input",
          result.translation.meaning,
        );

        return;
      }

      /// Save only valid translations
      await historyRepository.insertTranslation(
        TranslationHistoryModel(
          originalText:
          result.translation.originalText,

          normalizedText:
          result.translation.originalText
              .trim()
              .toLowerCase(),

          translatedText:
          result.translation.translatedText,

          pronunciation:
          result.translation.pronunciation,

          meaning:
          result.translation.meaning,

          category:
          result.translation.category,

          difficulty:
          result.translation.difficulty.name,

          inputType: inputType,

          sourceLanguageCode:
          result.sourceLanguageCode,

          targetLanguageCode:
          result.targetLanguageCode,

          createdAt:
          DateTime.now().toIso8601String(),

          isFavorite: false,

          isHidden: false,

          practiceCount: 0,

          lastPracticed: null,
          sourceType: "api",

        ),
      );

      /// Refresh History Screen
      if (Get.isRegistered<HistoryController>()) {
        Get.find<HistoryController>().loadHistory();
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
  void clear() {
    textController.clear();
    translation.value = null;
  }
}