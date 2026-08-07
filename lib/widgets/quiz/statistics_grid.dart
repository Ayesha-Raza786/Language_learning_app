import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';
import 'package:get/get.dart';
import '../../view_models/quiz_vm.dart';

Widget buildStatisticsGrid(QuizController controller) {
  return Obx(
        () => GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      childAspectRatio: 1.7,
      children: [

        _statCard(
          Icons.quiz_outlined,
          "Questions",
          controller.totalQuestions.value.toString(),
          const Color(0xffEEF4FF),
          Colors.blue,
        ),

        _statCard(
          Icons.translate,
          "Words",
          controller.totalWords.value.toString(),
          const Color(0xffFFF5E9),
          Colors.orange,
        ),

        _statCard(
          Icons.short_text,
          "Phrases",
          controller.totalPhrases.value.toString(),
          const Color(0xffEEFFF2),
          Colors.green,
        ),

        _statCard(
          Icons.notes_outlined,
          "Sentences",
          controller.totalSentences.value.toString(),
          const Color(0xffF3F3F3),
          Colors.grey,
        ),
      ],
    ),
  );
}

Widget _statCard(
    IconData icon,
    String title,
    String value,
    Color bg,
    Color iconColor,
    ) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.04),
          blurRadius: 10,
        )
      ],
    ),

    child: Row(
      children: [

        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: iconColor,
          ),
        ),

        const SizedBox(width: 14),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),

            Text(
              title,
              style: const TextStyle(
                color: AppColors.textMuted,
              ),
            )

          ],
        )

      ],
    ),
  );
}