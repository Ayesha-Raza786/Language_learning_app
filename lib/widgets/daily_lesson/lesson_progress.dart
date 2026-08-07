import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class LessonProgress extends StatelessWidget {

  final int current;
  final int total;

  const LessonProgress({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {

    final double progress =
    total == 0 ? 0 : current / total;

    return Padding(

      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Row(

            children: [

              const Text(
                "Lesson Progress",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),

              const Spacer(),

              Text(
                "${(progress * 100).round()}%",
                style: const TextStyle(
                  color: AppColors.darkGreen,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          ClipRRect(

            borderRadius:
            BorderRadius.circular(20),

            child: TweenAnimationBuilder<double>(

              tween: Tween(
                begin: 0,
                end: progress,
              ),

              duration:
              const Duration(milliseconds: 500),

              builder:
                  (context, value, child) {

                return LinearProgressIndicator(

                  value: value,

                  minHeight: 10,

                  backgroundColor:
                  Colors.grey.shade300,

                  valueColor:
                  const AlwaysStoppedAnimation(
                    AppColors.primaryGreen,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}