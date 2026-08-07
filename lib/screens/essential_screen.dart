import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../view_models/essential_learning_vm.dart';

class EssentialScreen extends StatelessWidget {
  final String inputType;

  const EssentialScreen({
    super.key,
    required this.inputType,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      EssentialController(inputType: inputType),
    );

    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        foregroundColor: AppColors.darkGreen,
        title: Text(
          inputType == "word"
              ? "Essential Words"
              : inputType == "phrase"
              ? "Common Phrases"
              : "Useful Sentences",
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.darkGreen,
          ),
        ),
      ),

      body: Column(
        children: [

          const SizedBox(height: 18),

          /// Search
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 18),
            child: TextField(
              controller: controller.searchController,
              onChanged: (_) => controller.search(),
              decoration: InputDecoration(
                hintText: "Search ${inputType}s...",
                hintStyle: TextStyle(
                  color: Colors.grey.shade500,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.primaryGreen,
                ),
                filled: true,
                fillColor: Colors.white,

                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(18),
                  borderSide: BorderSide(
                    color: Colors.grey.shade200,
                  ),
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: AppColors.primaryGreen,
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          /// Difficulty Chips
          Obx(
                () => Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [

                  _chip(
                    controller,
                    "beginner",
                    "Beginner",
                  ),

                  const SizedBox(width: 10),

                  _chip(
                    controller,
                    "intermediate",
                    "Intermediate",
                  ),

                  const SizedBox(width: 10),

                  _chip(
                    controller,
                    "advanced",
                    "Advanced",
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: Obx(() {

              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (controller.items.isEmpty) {
                return const Center(
                  child: Text(
                    "No data found",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 4,
                ),
                itemCount: controller.items.length,
                itemBuilder: (_, index) {
                  final item = controller.items[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: AppColors.primaryGreen.withOpacity(.12),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(.05),
                          blurRadius: 18,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [

                                /// Word
                                Text(
                                  item.originalText,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.darkGreen,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                /// Translation
                                Text(
                                  item.translatedText,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.grey.shade700,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                const SizedBox(height: 14),

                                /// Pronunciation Badge
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryGreen.withOpacity(.08),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.record_voice_over,
                                          size: 18,
                                          color: AppColors.primaryGreen,
                                        ),
                                        SizedBox(width: 6),
                                        Text(
                                          "Pronunciation",
                                          style: TextStyle(
                                            color: AppColors.primaryGreen,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 8),

                                    Text(
                                      "/${item.pronunciation}/",
                                      style: const TextStyle(
                                        color: AppColors.primaryGreen,
                                        height: 1.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                                const SizedBox(height: 16),


                              ],
                            ),
                          ),

                          const SizedBox(width: 14),

                          Column(
                            children: [

                              Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryGreen
                                      .withOpacity(.08),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.volume_up_rounded,
                                    color: AppColors.primaryGreen,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 10),

                              Container(
                                decoration: BoxDecoration(
                                  color: item.isFavorite
                                      ? Colors.red.shade50
                                      : Colors.grey.shade100,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    controller.toggleFavorite(
                                      item.id!,
                                    );
                                  },
                                  icon: Icon(
                                    item.isFavorite
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    color: item.isFavorite
                                        ? Colors.red
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
            );
          }),
  ),
  ],
  ),
  );
}


                  Widget _chip(
                      EssentialController controller,
                      String value,
                      String title,
                      ) {
                    final selected =
                        controller.selectedDifficulty.value == value;

                    return Expanded(
                      child: GestureDetector(
                        onTap: () => controller.changeDifficulty(value),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.symmetric(
                            vertical: 13,
                          ),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.primaryGreen
                                : Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: selected
                                  ? AppColors.primaryGreen
                                  : Colors.grey.shade300,
                            ),
                            boxShadow: selected
                                ? [
                              BoxShadow(
                                color: AppColors.primaryGreen
                                    .withOpacity(.25),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ]
                                : [],
                          ),
                          child: Center(
                            child: Text(
                              title,
                              style: TextStyle(
                                color: selected
                                    ? Colors.white
                                    : Colors.grey.shade700,
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
}