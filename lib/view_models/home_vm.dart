import 'package:get/get.dart';
import '../models/daily_lesson_item_model.dart';
import '../repositories/daily_lesson_repo.dart';

class HomeController extends GetxController {

  final DailyLessonRepository repository;

  HomeController({
    required this.repository,
  });

  final Rx<DailyLessonItemModel?> todayLesson =
  Rx<DailyLessonItemModel?>(null);

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadTodayLesson();
  }

  Future<void> loadTodayLesson() async {

    isLoading.value = true;

    todayLesson.value =
    await repository.getCurrentLesson();

    isLoading.value = false;
  }
  String getTodayCategory() {
    final lesson = todayLesson.value;

    if (lesson == null) {
      return "Daily Lesson";
    }

    return lesson.translation.category?.isNotEmpty == true
        ? lesson.translation.category!
        : "General";
  }
}