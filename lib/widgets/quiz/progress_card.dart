import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../view_models/quiz_vm.dart';

Widget buildProgressCard() {
  final controller = Get.find<QuizController>();
  return Obx(() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [

          Stack(
            alignment: Alignment.center,
            children: [

              SizedBox(
                width: 180,
                height: 180,
                child: CircularProgressIndicator(
                  value: controller.progress,
                  strokeWidth: 12,
                  backgroundColor: Colors.grey.shade200,
                  color: AppColors.accentGreen,
                  strokeCap: StrokeCap.round,
                ),
              ),

              Column(
                children: [

                  Text(
                    "${(controller.progress * 100).toStringAsFixed(0)}%",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),

                  Text(
                    "COMPLETE",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w600,
                    ),
                  )

                ],
              )

            ],
          ),

          const SizedBox(height: 22),

          Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.darkGreen,
              borderRadius: BorderRadius.circular(25),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [

                Icon(
                  Icons.schedule,
                  color: Colors.white,
                  size: 18,
                ),

                SizedBox(width: 8),

                Text(
                  "Estimated Time • 3-5 min",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                )

              ],
            ),
          )

        ],
      ),
    );
  });
}