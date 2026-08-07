import 'package:get/get.dart';

import '../models/daily_lesson_item_model.dart';

import '../repositories/daily_lesson_repo.dart';
import '../screens/lesson_completed.dart';

class DailyLessonController extends GetxController {

  final DailyLessonRepository repository = Get.find<DailyLessonRepository>();
  final RxList<DailyLessonItemModel> lesson = <DailyLessonItemModel>[].obs;
  final RxBool isLoading = false.obs;

  final RxInt currentIndex = 0.obs;

  final RxBool isCardFlipped = false.obs;
  final RxBool showAnswer = false.obs;

  final RxInt forgotCount = 0.obs;
  final RxInt goodCount = 0.obs;
  final RxInt easyCount = 0.obs;
  final RxBool lessonCompleted = false.obs;

  final RxDouble lessonProgress = 0.0.obs;
  @override
  void onInit() {
    super.onInit();

    loadLesson();
  }

  Future<void> loadLesson() async {
    currentIndex.value = 0;

    isCardFlipped.value = false;

    showAnswer.value = false;

    forgotCount.value = 0;
    goodCount.value = 0;
    easyCount.value = 0;
    isLoading.value = true;


    await repository.printLessonTable();
    lesson.value = await repository.getTodayLesson();

    currentIndex.value =
    await repository.getResumeIndex();
    if (lesson.isNotEmpty) {
      lessonProgress.value =
          currentIndex.value / lesson.length;
    }

    lessonCompleted.value =
    await repository.isLessonCompleted();
    if (lessonCompleted.value) {
      lessonProgress.value = 1.0;
    } else if (lesson.isNotEmpty) {
      lessonProgress.value =
          currentIndex.value / lesson.length;
    }
    isCardFlipped.value = false;

    isLoading.value = false;

  }

  DailyLessonItemModel? get currentLesson {
    if (lesson.isEmpty) {
      return null;
    }

    return lesson[currentIndex.value];
  }

  void flipCard() {
    isCardFlipped.toggle();
  }

  void toggleAnswer() {
    showAnswer.toggle();
  }

  void nextCard() {

    if (currentIndex.value < lesson.length - 1) {

      currentIndex.value++;

      isCardFlipped.value = false;

      showAnswer.value = false;

      lessonProgress.value =
          currentIndex.value / lesson.length;
    }
  }

  void previousCard() {
    if (currentIndex.value > 0) {
      currentIndex.value--;

      isCardFlipped.value = false;
    }
  }

  double get progress {
    if (lesson.isEmpty) {
      return 0;
    }

    return (currentIndex.value + 1) / lesson.length;
  }

  Future<void> _reviewCard(int result) async {

    final card = currentLesson;

    if (card == null) return;

    switch (result) {

      case 0:
        forgotCount.value++;
        break;

      case 1:
        goodCount.value++;
        break;

      case 2:
        easyCount.value++;
        break;
    }

    await repository.updateReviewResult(
      lessonId: card.lesson.id!,
      reviewResult: result,
    );

    int increment = 0;

    switch (result) {
      case 0:
        increment = 0;
        break;

      case 1:
        increment = 1;
        break;

      case 2:
        increment = 2;
        break;
    }

    await repository.updatePractice(
      historyId: card.lesson.historyId,
      increment: increment,
    );

    if (currentIndex.value == lesson.length - 1) {

      lessonCompleted.value = true;

      lessonProgress.value = 1.0;

      Get.to(() => const LessonCompleteScreen());

      return;
    }

    nextCard();
  }
  Future<void> markForgot() async {
    await _reviewCard(0);
  }

  Future<void> markGood() async {
    await _reviewCard(1);
  }

  Future<void> markEasy() async {
    await _reviewCard(2);
  }

  Future<void> restartLesson() async {

    currentIndex.value = 0;

    showAnswer.value = false;

    isCardFlipped.value = false;

    forgotCount.value = 0;

    goodCount.value = 0;

    easyCount.value = 0;

    lessonCompleted.value = false;

    lessonProgress.value = 0;
  }
}
