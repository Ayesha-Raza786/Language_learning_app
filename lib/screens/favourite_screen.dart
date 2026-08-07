import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../models/translation_history_model.dart';
import '../view_models/history_vm.dart';

class FavoritesScreen extends GetView<HistoryController> {
  FavoritesScreen({super.key});
  final TextEditingController searchController =
  TextEditingController();
  final searchText = "".obs;
  final RxString selectedType = "all".obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F7FA),

      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text(
          "Favorites",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.darkGreen,
          ),
        ),
      ),

      body: Column(
        children: [

          const SizedBox(height: 18),

          /// SEARCH
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                searchText.value = value;
              },
              decoration: InputDecoration(
                hintText: "Search favorites...",
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.primaryGreen,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                const EdgeInsets.symmetric(vertical: 16),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide(
                    color: Colors.grey.shade200,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: AppColors.primaryGreen,
                    width: 1.4,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          /// FILTER CHIPS
          Obx(
                () => Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                children: [
                  _chip("all", "All"),
                  const SizedBox(width: 10),
                  _chip("word", "Words"),
                  const SizedBox(width: 10),
                  _chip("phrase", "Phrases"),
                  const SizedBox(width: 10),
                  _chip("sentence", "Sentences"),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          Expanded(
            child: Obx(() {

              List<TranslationHistoryModel> favorites = controller.history
                  .where((e) => e.isFavorite)
                  .toList();

              /// Filter by type
              if (selectedType.value != "all") {
                favorites = favorites.where((e) {
                  return e.inputType == selectedType.value;
                }).toList();
              }

              /// Search
               final query = searchText.value.trim().toLowerCase();
              if (query.isNotEmpty) {
                favorites = favorites.where((e) {
                  return e.originalText
                      .toLowerCase()
                      .contains(query) ||
                      e.translatedText
                          .toLowerCase()
                          .contains(query);
                }).toList();
              }

              if (favorites.isEmpty) {
                return _buildEmpty();
              }

              return ListView.builder(
                keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag,
                padding:
                const EdgeInsets.symmetric(horizontal: 18),
                itemCount: favorites.length,
                itemBuilder: (_, index) {
                  return _buildFavoriteCard(
                    favorites[index],
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _chip(String value, String title) {
    final selected = selectedType.value == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          selectedType.value = value;
        },
        child: AnimatedContainer(
          duration:
          const Duration(milliseconds: 250),
          padding:
          const EdgeInsets.symmetric(vertical: 12),
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
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteCard(TranslationHistoryModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color:
          AppColors.primaryGreen.withOpacity(.10),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  item.originalText,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkGreen,
                  ),
                ),

                const SizedBox(height: 6),

                Row(
                  children: [

                    const Icon(
                      Icons.record_voice_over,
                      size: 18,
                      color:
                      AppColors.primaryGreen,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      "/${item.pronunciation}/",
                      style: const TextStyle(
                        color:
                        AppColors.primaryGreen,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 14),

                Text(
                  item.translatedText,
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 18),

                Row(
                  children: [

                    _badge(
                      item.difficulty,
                      item.difficulty ==
                          "beginner"
                          ? Colors.green
                          : item.difficulty ==
                          "intermediate"
                          ? Colors.orange
                          : Colors.red,
                    ),

                    const SizedBox(width: 10),

                    _badge(
                      item.inputType,
                      Colors.blue,
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          Column(
            children: [

              CircleAvatar(
                radius: 22,
                backgroundColor:
                AppColors.primaryGreen
                    .withOpacity(.08),
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.volume_up,
                    color:
                    AppColors.primaryGreen,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              CircleAvatar(
                radius: 22,
                backgroundColor:
                Colors.red.shade50,
                child: IconButton(
                  onPressed: () {
                    controller.toggleFavorite(
                        item.id!);
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _badge(
      String text,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.12),
        borderRadius:
        BorderRadius.circular(30),
      ),
      child: Text(
        text[0].toUpperCase() +
            text.substring(1),
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildEmpty() {
    return Center(
      child: Column(
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [

          CircleAvatar(
            radius: 55,
            backgroundColor:
            Colors.red.shade50,
            child: Icon(
              Icons.favorite_border,
              size: 50,
              color: Colors.red.shade300,
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            "No Favorites Yet",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGreen,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "Your saved words, phrases and\nsentences will appear here.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade600,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 25),

          ElevatedButton.icon(
            onPressed: Get.back,
            icon:
            const Icon(Icons.school_outlined),
            label:
            const Text("Continue Learning"),
          ),
        ],
      ),
    );
  }
}