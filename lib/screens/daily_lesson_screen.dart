import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../view_models/daily_lesson_vm.dart';
import '../widgets/daily_lesson/lesson_flashcard.dart';
import '../widgets/daily_lesson/lesson_header.dart';
import '../widgets/daily_lesson/lesson_progress.dart';
import '../widgets/daily_lesson/lesson_rating_button.dart';

class FlashcardsScreen extends GetView<DailyLessonController> {
  const FlashcardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.lesson.isEmpty) {
          return const Center(
            child: Text("No lesson available"),
          );
        }

        final lesson = controller.currentLesson!;

        return Column(
          children: [
            _buildHeader(context),

            const SizedBox(height: 10),

            LessonHeader(
              current: controller.currentIndex.value + 1,
              total: controller.lesson.length,
            ),

            const SizedBox(height: 15),

            LessonProgress(
              current: controller.currentIndex.value + 1,
              total: controller.lesson.length,
            ),

            const SizedBox(height: 25),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: LessonFlashcard(
                  lesson: lesson,
                ),
              ),
            ),

            Obx(() {
              if (!controller.showAnswer.value) {
                return const SizedBox();
              }

              return LessonRatingButtons(
                onForgot: controller.markForgot,
                onGood: controller.markGood,
                onEasy: controller.markEasy,
              );
            }),

            const SizedBox(height: 5),
          ],
        );
      }),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
        bottom: 14,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xffE5E7EB),
          ),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.language_outlined,
              color: AppColors.darkGreen,
            ),
          ),

          const SizedBox(width: 12),

          const Text(
            "LinguaLearn",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGreen,
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}