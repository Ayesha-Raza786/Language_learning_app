import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../models/daily_lesson_item_model.dart';
import '../../view_models/daily_lesson_vm.dart';

class LessonFlashcard extends StatelessWidget {
  final DailyLessonItemModel lesson;

  const LessonFlashcard({
    super.key,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DailyLessonController>();

    return Obx(() {
      final showAnswer = controller.showAnswer.value;

      return GestureDetector(
        onTap: controller.toggleAnswer,
        child: TweenAnimationBuilder<double>(
          tween: Tween(
            begin: 0,
            end: showAnswer ? 1 : 0,
          ),
          duration: const Duration(milliseconds: 500),
          builder: (context, value, child) {
            final angle = value * pi;

            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle),
              child: angle <= pi / 2
                  ? _frontCard()
                  : Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateY(pi),
                child: _backCard(),
              ),
            );
          },
        ),
      );
    });
  }
  Widget _frontCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: AppColors.lightGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "English",
                style: TextStyle(
                  color: AppColors.darkGreen,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  fontSize: 12,
                ),
              ),
            ),

            const SizedBox(height: 40),

            Text(
              lesson.translation.normalizedText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 38,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGreen,
                fontFamily: "Georgia",
              ),
            ),

            const SizedBox(height: 30),

            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: AppColors.lightGreen,
                borderRadius: BorderRadius.circular(16),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.volume_up_rounded,
                  color: AppColors.darkGreen,
                ),
              ),
            ),

            const SizedBox(height: 55),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.touch_app,
                  size: 18,
                  color: Colors.grey.shade500,
                ),
                const SizedBox(width: 6),
                Text(
                  "Tap to see translation",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _backCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            Text(
              lesson.translation.normalizedText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: AppColors.darkGreen,
                fontFamily: "Georgia",
              ),
            ),

            const SizedBox(height: 15),

            Text(
              lesson.translation.translatedText,
              style: TextStyle(
                fontSize: 22,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 25),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const Text(
                    "Pronunciation",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkGreen
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    lesson.translation.pronunciation,
                    style: const TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                    ),
                  ),

                  const SizedBox(height: 22),

                  const Text(
                    "Meaning",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                        color: AppColors.darkGreen
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    lesson.translation.meaning,
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.lightGreen,
                borderRadius: BorderRadius.circular(16),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.volume_up_rounded,
                  color: AppColors.darkGreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}