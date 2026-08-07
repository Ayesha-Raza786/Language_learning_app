import 'package:get/get.dart';

import '../models/language_model.dart';
import '../repositories/language_repo.dart';

class LanguageController extends GetxController {
  final LanguageRepository repository;

  LanguageController(this.repository);

  final RxList<LanguageModel> languages =
      <LanguageModel>[].obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    print("Controller Created");

    initializeLanguages();
  }

  Future<void> initializeLanguages() async {
    try {
      isLoading.value = true;
      await repository.seedLanguages();
      languages.value = await repository.getAllLanguages();

    } catch (e) {
      // print("ERROR: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshLanguages() async {
    languages.value = await repository.getAllLanguages();
  }

  Future<void> loadLanguages() async {
    isLoading.value = true;

    languages.value =
    await repository.getAllLanguages();

    isLoading.value = false;
  }

  Future<void> addLanguage(LanguageModel language) async {
    await repository.insertLanguage(language);

    await loadLanguages();
  }

  Future<void> deleteLanguage(int id) async {
    await repository.deleteLanguage(id);

    await loadLanguages();
  }
}