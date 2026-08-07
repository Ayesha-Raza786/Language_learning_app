import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class LessonHeader extends StatelessWidget {

  final int current;
  final int total;

  const LessonHeader({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Row(

        children: [

          Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [

              const Text(
                "Today's Lesson",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: 4),

            ],
          ),

          const Spacer(),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: AppColors.lightGreen,
              borderRadius:
              BorderRadius.circular(30),
            ),
            child: Text(
              "$current / $total",
              style: const TextStyle(
                color: AppColors.darkGreen,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}