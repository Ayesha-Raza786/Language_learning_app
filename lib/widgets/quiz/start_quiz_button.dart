import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../screens/quiz_screen.dart';

Widget buildStartQuizButton() {
  return SizedBox(
    width: double.infinity,
    height: 58,
    child: FilledButton.icon(
      onPressed: () {

        Get.to(
              () => QuizScreenQuestion(),
        );

      },

      style: FilledButton.styleFrom(
        backgroundColor: AppColors.darkGreen,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),

      icon: const Icon(
        Icons.play_arrow_rounded,
        size: 24,
      ),

      label: const Text(
        "Start Quiz",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}