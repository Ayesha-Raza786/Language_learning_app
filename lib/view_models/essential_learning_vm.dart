import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../models/translation_history_model.dart';
import '../repositories/essential_learning_repo.dart';

class EssentialController extends GetxController {
  final EssentialLearningRepository repository =
  EssentialLearningRepository();

  final String inputType;

  EssentialController({
    required this.inputType,
  });

  final RxList<TranslationHistoryModel> items =
      <TranslationHistoryModel>[].obs;

  final RxBool isLoading = false.obs;

  final searchController = TextEditingController();

  final RxString selectedDifficulty = "beginner".obs;

  @override
  void onInit() {
    super.onInit();
    loadItems();
  }

  Future<void> loadItems() async {
    isLoading.value = true;

    items.value = await repository.getItems(
      inputType: inputType,
      difficulty: selectedDifficulty.value,
      keyword: searchController.text.trim(),
    );


    isLoading.value = false;
  }

  Future<void> changeDifficulty(String difficulty) async {
    selectedDifficulty.value = difficulty;
    await loadItems();
  }

  Future<void> search() async {
    await loadItems();
  }
  Future<void> toggleFavorite(int id) async {
    await repository.toggleFavorite(id);

    await loadItems();
  }
}