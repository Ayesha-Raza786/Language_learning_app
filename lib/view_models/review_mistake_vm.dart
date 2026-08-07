import 'package:get/get.dart';
import '../models/daily_lesson_item_model.dart';
import '../repositories/review_mistake_repo.dart';


class ReviewMistakesController extends GetxController {
  final ReviewMistakesRepository repository;

  ReviewMistakesController({
    required this.repository,
  });

  final RxList<DailyLessonItemModel> mistakes =
      <DailyLessonItemModel>[].obs;

  final RxInt currentIndex = 0.obs;

  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadMistakes();
  }

  Future<void> loadMistakes() async {
    isLoading.value = true;

    mistakes.value = await repository.getMistakes();

    currentIndex.value = 0;

    isLoading.value = false;
  }
  bool get hasNext =>
      currentIndex.value < mistakes.length - 1;

  bool get hasPrevious =>
      currentIndex.value > 0;

  int get totalMistakes =>
      mistakes.length;
  void previousWord() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
    }
  }


  DailyLessonItemModel? get currentMistake {
    if (mistakes.isEmpty) return null;

    return mistakes[currentIndex.value];
  }

  void nextWord() {
    if (currentIndex.value < mistakes.length - 1) {
      currentIndex.value++;
      return;
    }

    Get.back();
  }

  Future<void> practiceAgain() async {
    await loadMistakes();
  }

  double get progress {
    if (mistakes.isEmpty) return 0;

    return (currentIndex.value + 1) / mistakes.length;
  }
  void reset() {
    currentIndex.value = 0;
    mistakes.clear();
  }
}