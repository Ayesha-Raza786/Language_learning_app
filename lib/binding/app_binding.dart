import 'package:get/get.dart';

import '../repositories/ai_repo.dart';
import '../repositories/daily_lesson_repo.dart';
import '../repositories/history_repo.dart';
import '../repositories/language_repo.dart';
import '../repositories/quiz_repo.dart';
import '../repositories/review_mistake_repo.dart';
import '../services/gemini_service.dart';
import '../view_models/ai_vm.dart';
import '../view_models/daily_lesson_vm.dart';
import '../view_models/history_vm.dart';
import '../view_models/home_vm.dart';
import '../view_models/languageVM.dart';
import '../view_models/main_navigation_vm.dart';
import '../view_models/quiz_vm.dart';
import '../view_models/review_mistake_vm.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {

    // ---------------- Navigation ----------------

    Get.put(
      MainNavigationController(),
      permanent: true,
    );

    // ---------------- Repositories ----------------

    Get.lazyPut<DailyLessonRepository>(
          () => DailyLessonRepository(),
      fenix: true,
    );

    Get.lazyPut<HistoryRepository>(
          () => HistoryRepository(),
      fenix: true,
    );

    // Services
    Get.lazyPut<GeminiService>(
          () => GeminiService(),
      fenix: true,
    );

// Repositories
    Get.lazyPut<TranslationRepository>(
          () => TranslationRepository(
        Get.find<GeminiService>(),
      ),
      fenix: true,
    );
    Get.lazyPut<LanguageRepository>(
          () => LanguageRepository(),
      fenix: true,
    );

    // ---------------- Controllers ----------------

    Get.put(
      HomeController(
        repository: Get.find<DailyLessonRepository>(),
      ),
      permanent: true,
    );

    Get.put(
      DailyLessonController(),
      permanent: true,
    );

    Get.put(
      HistoryController(
        Get.find<HistoryRepository>(),
      ),
      permanent: true,
    );

    Get.put(
      TranslationController(
        Get.find<TranslationRepository>(),
        Get.find<HistoryRepository>(),
      ),
      permanent: true,
    );
    Get.lazyPut(
          () => QuizController(
        repository: QuizRepository(),
      ),
    );
    Get.lazyPut<ReviewMistakesRepository>(
          () => ReviewMistakesRepository(),
    );

    Get.lazyPut<ReviewMistakesController>(
          () => ReviewMistakesController(
        repository: Get.find(),
      ),
    );
  }
}