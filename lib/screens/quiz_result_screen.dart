import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:language_learning/screens/quiz_screen.dart';
import 'package:language_learning/screens/review_mistake_screen.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../constants/app_colors.dart';
import '../view_models/quiz_vm.dart';

class QuizResultScreen extends StatelessWidget {
  const QuizResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<QuizController>();
    const int totalQuestions = 16;
    const int correctAnswers = 14;

    final double percentage =
        correctAnswers / totalQuestions;

    return Scaffold(
      backgroundColor: const Color(0xffF7F9FC),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          "Quiz Results",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 12,
          ),
          child: Column(
            children: [

              //----------------------------------
              // Trophy
              //----------------------------------

              const Icon(
                Icons.emoji_events,
                color: Colors.orange,
                size: 54,
              ),

              const SizedBox(height: 14),

              const Text(
                "Quiz Completed!",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0F172A),
                ),
              ),

              const SizedBox(height: 8),

              Text(
                "You've reached a new milestone in your\nlanguage journey.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 35),

              //----------------------------------
              // Circular Score
              //----------------------------------

              CircularPercentIndicator(
                radius: 72,
                lineWidth: 8,
                  percent: controller.percentage,
                animation: true,
                animationDuration: 1200,
                circularStrokeCap:
                CircularStrokeCap.round,

                progressColor: AppColors.darkGreen,

                backgroundColor:
                Colors.green.shade100,

                center: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [

                    Text(
                      "${(controller.percentage * 100).round()}%",

                      style: const TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGreen,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      "${controller.correctAnswers} / ${controller.questions.length}",
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              //-----------------------------------------------------
// Performance Card
//-----------------------------------------------------

              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        controller.stars,
                            (index) => const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 1),
                          child: Icon(
                            Icons.star,
                            size: 18,
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                     Text(
                      controller.performanceTitle,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkGreen,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

//-----------------------------------------------------
// Correct / Wrong
//-----------------------------------------------------

              Row(
                children: [

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.green.shade200,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [

                              Icon(
                                Icons.check_circle,
                                color: Colors.green,
                                size: 18,
                              ),

                              const SizedBox(width: 6),

                              Text(
                                "Correct",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                           Text(
                              controller.correctAnswers.toString(),
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.red.shade200,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: [

                              Icon(
                                Icons.cancel,
                                color: Colors.red,
                                size: 18,
                              ),

                              const SizedBox(width: 6),

                              Text(
                                "Wrong",
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                           Text(
                              controller.wrongAnswers.toString(),
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

//-----------------------------------------------------
// Breakdown
//-----------------------------------------------------

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Breakdown by Type",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

               SizedBox(height: 14),

              _buildProgressItem(
                title: "Words",
                icon: Icons.translate,
                value: controller.wordProgress,
                label: controller.wordsLabel,
              ),

              const SizedBox(height: 10),

              _buildProgressItem(
                title: "Phrases",
                icon: Icons.short_text,
                value: controller.phraseProgress,
                label: controller.phrasesLabel,
              ),

              const SizedBox(height: 10),

              _buildProgressItem(
                title: "Sentences",
                icon: Icons.notes,
                value: controller.sentenceProgress,
                label: controller.sentencesLabel,
              ),

              //-----------------------------------------------------
// Review Mistakes Button
//-----------------------------------------------------

              // SizedBox(
              //   width: double.infinity,
              //   height: 56,
              //   child: ElevatedButton.icon(
              //     onPressed: () {
              //       Get.off(() => const ReviewMistakesScreen());
              //     },
              //     icon: const Icon(Icons.tune, color: Colors.white),
              //     label: const Text(
              //       "Review Mistakes",
              //       style: TextStyle(
              //         fontSize: 16,
              //         fontWeight: FontWeight.w600,
              //       ),
              //     ),
              //     style: ElevatedButton.styleFrom(
              //       backgroundColor: AppColors.darkGreen,
              //       foregroundColor: Colors.white,
              //       elevation: 0,
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(30),
              //       ),
              //     ),
              //   ),
              // ),

              const SizedBox(height: 14),

//-----------------------------------------------------
// Play Again Button
//-----------------------------------------------------

              SizedBox(
                width: double.infinity,
                height: 56,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    final controller = Get.find<QuizController>();

                    await controller.restartQuiz();

                    Get.off(() => const QuizScreenQuestion());
                  },
                  icon: const Icon(
                    Icons.replay,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Play Again",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    backgroundColor:  AppColors.darkGreen,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

//-----------------------------------------------------
// Back Home
//-----------------------------------------------------

              TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.home_outlined,
                  color: AppColors.darkGreen,
                ),
                label: const Text(
                  "Back Home",
                  style: TextStyle(
                    color: AppColors.darkGreen,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildProgressItem({
    required String title,
    required IconData icon,
    required double value,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [

          Icon(
            icon,
            color: AppColors.darkGreen,
            size: 18,
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 6),

                LinearProgressIndicator(
                  value: value,
                  minHeight: 6,
                  borderRadius:
                  BorderRadius.circular(20),
                  backgroundColor:
                  Colors.green.shade100,
                  valueColor:
                  const AlwaysStoppedAnimation(
                    AppColors.primaryGreen,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.darkGreen,
            ),
          ),
        ],
      ),
    );
  }
}