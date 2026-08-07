import 'package:get/get.dart';

import '../models/translation_history_model.dart';
import '../repositories/history_repo.dart';
import '../widgets/history/history_filter_chips.dart';

class HistoryController extends GetxController {

  final HistoryRepository repository;

  HistoryController(this.repository);

  final RxList<TranslationHistoryModel> history =
      <TranslationHistoryModel>[].obs;
  final RxList<TranslationHistoryModel>
  recentLearning =
      <TranslationHistoryModel>[].obs;

  final RxBool isLoading = false.obs;
  final Rx<HistoryFilter>
  selectedFilter =
      HistoryFilter.all.obs;

  @override
  void onInit() {
    super.onInit();
    loadHistory();
  }

  Future<void> loadHistory() async {

    isLoading.value = true;

    history.value =
    await repository.getAllTranslations();

    recentLearning.value =
    await repository.getRecentLearning();

    isLoading.value = false;
  }
  /// Hide one translation from History
  Future<void> deleteHistory(int id) async {

    await repository.hideTranslation(id);

    history.removeWhere((item) => item.id == id);
  }

  /// Hide all translations from History
  Future<void> clearHistory() async {

    await repository.hideAllHistory();

    history.clear();
  }

  /// Restore all hidden history (optional)
  Future<void> restoreHistory() async {

    await repository.restoreAllHistory();

    await loadHistory();
  }

  Future<void> filterHistory(
      HistoryFilter filter) async {

    selectedFilter.value = filter;

    switch (filter) {

      case HistoryFilter.all:

        history.value =
        await repository.getAllTranslations();

        break;

      case HistoryFilter.favorites:

        history.value =
        await repository.getFavorites();

        break;

      case HistoryFilter.words:

        history.value =
            (await repository.getAllTranslations())
                .where(
                  (e) =>
              e.inputType == "word",
            )
                .toList();

        break;

      case HistoryFilter.phrases:

        history.value =
            (await repository.getAllTranslations())
                .where(
                  (e) =>
              e.inputType == "phrase",
            )
                .toList();

        break;

      case HistoryFilter.sentences:

        history.value =
            (await repository.getAllTranslations())
                .where(
                  (e) =>
              e.inputType ==
                  "sentence",
            )
                .toList();

        break;
    }
  }
  Future<void> searchHistory(
      String keyword) async {

    if (keyword.trim().isEmpty) {

      await loadHistory();

      return;
    }

    history.value =
    await repository.searchHistory(
      keyword,
    );
  }
  Future<void> toggleFavorite(int id) async {

    await repository.toggleFavorite(id);

    await loadHistory();
  }

}