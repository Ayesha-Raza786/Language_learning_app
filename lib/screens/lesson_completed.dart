import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../view_models/daily_lesson_vm.dart';
import '../view_models/main_navigation_vm.dart';

class LessonCompleteScreen extends GetView<DailyLessonController> {
  const LessonCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(22),

          child: Column(

            children: [

              const SizedBox(height: 20),

              _buildTrophy(),

              const SizedBox(height: 25),

              const Text(
                "Lesson Completed!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                "You completed ${controller.lesson.length} flashcards.",
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 30),

              _buildProgress(),

              const SizedBox(height: 30),

              _buildStatistics(),

              const Spacer(),

              _homeButton(),

              const SizedBox(height: 14),

              _restartButton(),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrophy() {
    return Container(

      width: 120,
      height: 120,

      decoration: const BoxDecoration(

        shape: BoxShape.circle,

        gradient: LinearGradient(

          colors: [
            Color(0xff32C36C),
            Color(0xff0A8F47),
          ],

        ),

      ),

      child: const Icon(
        Icons.emoji_events_rounded,
        size: 60,
        color: Colors.white,
      ),
    );
  }

  Widget _buildProgress() {
    return Container(

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(22),

      ),

      child: Column(

        children: [

          const Row(

            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,

            children: [

              Text("Lesson Progress"),

              Text("100%"),
            ],
          ),

          const SizedBox(height: 14),

          ClipRRect(

            borderRadius:
            BorderRadius.circular(20),

            child: LinearProgressIndicator(

              value: 1,

              minHeight: 10,

              backgroundColor:
              Colors.grey.shade200,

              color: AppColors.primaryGreen,

            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatistics() {
    return Row(

      children: [

        Expanded(
          child: _statCard(
            "Forgot",
            controller.forgotCount.value,
            Icons.refresh,
            Colors.red,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _statCard(
            "Good",
            controller.goodCount.value,
            Icons.sentiment_satisfied_alt_rounded,
            Colors.orange,
          ),
        ),

        const SizedBox(width: 12),

        Expanded(
          child: _statCard(
            "Easy",
            controller.easyCount.value,
            Icons.check_circle,
            Colors.green,
          ),
        ),

      ],
    );
  }
  Widget _statCard(
      String title,
      int count,
      IconData icon,
      Color color,
      ) {

    return Container(

      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(

        color: Colors.white,

        borderRadius: BorderRadius.circular(18),

      ),

      child: Column(

        children: [

          Icon(icon,
              color: color,
              size: 32),

          const SizedBox(height: 10),

          Text(
            "$count",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(title),
        ],
      ),
    );
  }
  Widget _homeButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: FilledButton.icon(
          onPressed: () {
            final nav = Get.find<MainNavigationController>();

            nav.changeTab(0); // Home

            Get.offAllNamed('/MainScreen');
          },
        icon: const Icon(Icons.home_rounded),
        label: const Text(
          "Back to Home",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.darkGreen,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
  Widget _restartButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton.icon(
        onPressed: () async {
          await controller.restartLesson();

          final nav = Get.find<MainNavigationController>();

          nav.changeTab(1); // Lessons

          Get.offAllNamed('/MainScreen');
        },
        icon: const Icon(Icons.refresh_rounded),
        label: const Text(
          "Start Again",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.darkGreen,
          side: BorderSide(
            color: AppColors.darkGreen,
            width: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}