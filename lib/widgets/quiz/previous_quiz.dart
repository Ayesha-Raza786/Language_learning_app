import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

Widget buildLastQuizCard() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(.05),
          blurRadius: 10,
          offset: const Offset(0, 5),
        ),
      ],
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Row(
          children: [

            const Icon(
              Icons.history,
              color: AppColors.darkGreen,
            ),

            const SizedBox(width: 10),

            const Expanded(
              child: Text(
                "Last Quiz",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: AppColors.lightGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "Today",
                style: TextStyle(
                  color: AppColors.darkGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )

          ],
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [

            _quizInfo("Score", "8 / 10"),

            _quizInfo("Accuracy", "80%"),

            _quizInfo("Time", "4 min"),

          ],
        )

      ],
    ),
  );

}
Widget _quizInfo(
    String title,
    String value,
    ) {
  return Column(
    children: [

      Text(
        value,
        style: const TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: AppColors.darkGreen,
        ),
      ),

      const SizedBox(height: 6),

      Text(
        title,
        style: const TextStyle(
          color: AppColors.textMuted,
          fontWeight: FontWeight.w500,
        ),
      ),

    ],
  );
}