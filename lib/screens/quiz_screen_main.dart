import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../view_models/quiz_vm.dart';
import '../widgets/quiz/progress_card.dart';
import '../widgets/quiz/start_quiz_button.dart';
import '../widgets/quiz/statistics_grid.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {

  String selectedDifficulty = "Beginner";
  final QuizController controller = Get.find<QuizController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              _buildHeader(),

              const SizedBox(height: 24),

              buildProgressCard(),

              const SizedBox(height: 18),

              buildStatisticsGrid(controller),

              const SizedBox(height: 24),


              const SizedBox(height: 28),

              buildStartQuizButton(),

              const SizedBox(height: 28),



            ],
          ),
        ),
      ),
    );
  }

  //======================================================
  // HEADER
  //======================================================

  Widget _buildHeader() {
    return Row(
      children: [

        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Daily Quiz",
              style: TextStyle(
                color: AppColors.darkGreen,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),

            SizedBox(height: 4),

            Text(
              "Today's Practice",
              style: TextStyle(
                color: AppColors.textMuted,
              ),
            ),

          ],
        ),

        const Spacer(),

        Container(
          padding:
          const EdgeInsets.symmetric(horizontal: 14, vertical: 8),

          decoration: BoxDecoration(
            color: AppColors.lightGreen,
            borderRadius: BorderRadius.circular(25),
          ),

          child:  Row(
            children: [

              Icon(
                Icons.flag_circle,
                color: AppColors.darkGreen,
                size: 18,
              ),

              SizedBox(width: 6),

              Obx(() {
                final total = Get.find<QuizController>().questions.length;

                return Text(
                  "$total Questions",
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.darkGreen,
                  ),
                );
              }),

            ],
          ),
        ),

      ],
    );
  }
}