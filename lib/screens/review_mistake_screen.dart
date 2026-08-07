import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../view_models/review_mistake_vm.dart';
import '../widgets/quiz/mistake_card.dart';

class ReviewMistakesScreen extends StatelessWidget {
  const ReviewMistakesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ReviewMistakesController>();

    return Scaffold(
      backgroundColor: const Color(0xffF8F9FB),

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        titleSpacing: 0,
        title: const Text(
          "LinguaLearn",
          style: TextStyle(
            color: AppColors.darkGreen,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.mistakes.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    const Icon(
                      Icons.verified_rounded,
                      size: 80,
                      color: Colors.green,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Excellent!",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "You don't have any mistakes to review.",
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 30),

                    ElevatedButton(
                      onPressed: Get.back,
                      child: const Text("Back"),
                    ),
                  ],
                ),
              );
            }

            final mistake = controller.mistakes[controller.currentIndex.value];

            return Column(
              children: [
                /// Progress
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Reviewing mistakes",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),

                    Text(
                      "${controller.currentIndex.value + 1}/${controller.totalMistakes}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                Expanded(
                  child: Center(child: MistakeCard(lesson: mistake)),
                ),

                const SizedBox(height: 20),
                //
                // SizedBox(
                //   width: double.infinity,
                //   height: 52,
                //   child: ElevatedButton.icon(
                //     onPressed: controller.practiceAgain,
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: AppColors.darkGreen,
                //       foregroundColor: Colors.white,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(30),
                //       ),
                //     ),
                //     icon: const Icon(Icons.refresh),
                //     label: const Text("Practice Again"),
                //   ),
                // ),
                //
                // const SizedBox(height: 12),

                // SizedBox(
                //   width: double.infinity,
                //   height: 50,
                //   child: OutlinedButton.icon(
                //     onPressed: controller.nextWord,
                //     icon: const Icon(Icons.arrow_forward),
                //     label: Text(
                //       controller.hasNext ? "Next Word" : "Finish Review",
                //     ),
                //     style: OutlinedButton.styleFrom(
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(30),
                //       ),
                //     ),
                //   ),
                // ),
                Row(
                  children: [

                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: controller.hasPrevious
                            ? controller.previousWord
                            : null,
                        icon: const Icon(Icons.arrow_back),
                        label: const Text("Previous"),
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: controller.nextWord,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.darkGreen,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        icon: Icon(
                          controller.hasNext
                              ? Icons.arrow_forward
                              : Icons.check,
                        ),
                        label: Text(
                          controller.hasNext
                              ? "Next"
                              : "Finish",
                        ),
                      ),
                    ),

                  ],
                ),
                const SizedBox(height: 12),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: controller.practiceAgain,
                    icon: const Icon(Icons.refresh),
                    label: const Text("Restart Review"),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
