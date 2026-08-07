import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view_models/quiz_vm.dart';
import '../widgets/quiz/feedback_card.dart';
import '../widgets/quiz/option_tile.dart';
import '../widgets/quiz/word_card.dart';

class QuizScreenQuestion extends GetView<QuizController> {
  const QuizScreenQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAF9),

      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.questions.isEmpty) {
          return const Center(child: Text("No quiz available."));
        }

        return SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HEADER
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      borderRadius: BorderRadius.circular(14),
                      child: Container(
                        height: 48,
                        width: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                    ),

                    const Spacer(),
                    Obx(
                      () => Text(
                        controller.currentQuestion.inputType.toUpperCase(),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),

                    const SizedBox(width: 48),
                  ],
                ),

                const SizedBox(height: 28),

                /// PROGRESS BAR
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: LinearProgressIndicator(
                    value:
                        (controller.currentIndex.value + 1) /
                        controller.questions.length,
                    minHeight: 8,
                    backgroundColor: Colors.grey.shade200,
                    valueColor: const AlwaysStoppedAnimation(Color(0xff0B7A3D)),
                  ),
                ),

                const SizedBox(height: 28),

                /// WORD BADGE
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xffDDF8DF),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child:  Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.language,
                          color: Color(0xff0B7A3D),
                          size: 18,
                        ),
                        SizedBox(width: 8),
                        Obx(
                              () => Text(
                            "Question ${controller.currentIndex.value + 1} / ${controller.questions.length}",
                                style: TextStyle(
                                  color: Color(0xff0B7A3D),
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                /// WORD CARD
                Obx(
                      () => WordCard(
                    word: controller.currentQuestion.question,
                  ),
                ),

                const SizedBox(height: 26),

                /// OPTIONS
                Obx(() {
                  return Column(
                    children: List.generate(
                      controller.currentQuestion.options.length,
                          (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 14),
                          child: OptionTile(
                            letter: String.fromCharCode(65 + index), // A,B,C,D

                            text: controller.currentQuestion.options[index],

                            selected:
                            controller.selectedOption.value == index,

                            correct:
                            controller.answered.value &&
                                controller.currentQuestion.options[index] ==
                                    controller.currentQuestion.correctAnswer,

                            onTap: () {
                              controller.checkAnswer(index);
                            },
                          ),
                        );
                      },
                    ),
                  );
                }),

                /// FEEDBACK
                Obx(() {

                  if (!controller.answered.value) {
                    return const SizedBox();
                  }

                  return FeedbackCard(
                    isCorrect: controller.answerCorrect.value,
                    correctAnswer: controller.currentQuestion.correctAnswer,
                  );

                }),

                const SizedBox(height: 26),

                /// NEXT BUTTON
                Obx(
                      () => SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton(
                      onPressed: controller.answered.value
                          ? controller.nextQuestion
                          : null,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xff0B7A3D),
                        disabledBackgroundColor: Colors.grey.shade300,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            controller.currentIndex.value ==
                                controller.questions.length - 1
                                ? "Finish"
                                : "Next",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
