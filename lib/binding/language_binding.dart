import 'package:get/get.dart';
import '../repositories/language_repo.dart';
import '../view_models/languageVM.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {

    Get.put(LanguageRepository());

    Get.put(
      LanguageController(
        Get.find<LanguageRepository>(),
      ),
    );
  }
}