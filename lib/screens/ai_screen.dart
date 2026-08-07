import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../view_models/ai_vm.dart';
import '../widgets/ai_respose.dart';
import '../widgets/quick_action.dart';
import '../widgets/translator_card.dart';
import '../widgets/insight_card.dart';

class AIScreen extends GetView<TranslationController> {
  const AIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _buildHeader(context),

            const SizedBox(height: 10),
            const InsightCard(),
            const SizedBox(height: 20),
            const TranslatorCard(),

            const SizedBox(height: 20),


            Obx(() {

              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.translation.value == null) {
                return const SizedBox.shrink();
              }

              final data = controller.translation.value!;

              return AIResponseCard(
                originalText: data.translation.originalText,
                translatedText: data.translation.translatedText,
                pronunciation: data.translation.pronunciation,
                meaning: data.translation.meaning,
                exampleEnglish: data.example.englishSentence,
                exampleTranslated: data.example.translatedSentence,
                category: data.translation.category,
                difficulty: data.translation.difficulty.name,
                inputType: data.translation.inputType.name,
              );
            }),

            const SizedBox(height: 20),

            const QuickActions(),

            const SizedBox(height: 20),

          ],
        ),
      ),
    );
  }
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
        bottom: 14,
      ),

      decoration: const BoxDecoration(
        // color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Color(0xffE5E7EB),
          ),
        ),
      ),

      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryGreen.withOpacity(.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.language_outlined,
              color: AppColors.darkGreen,
            ),
          ),

          const SizedBox(width: 12),

          const Text(
            "LinguaLearn",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGreen,
            ),
          ),

          const Spacer(),

          // IconButton(
          //   onPressed: () {},
          //   icon: const Icon(Icons.notifications_none_rounded),
          // ),
        ],
      ),
    );
  }

}