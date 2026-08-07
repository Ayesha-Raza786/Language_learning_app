import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../view_models/history_vm.dart';
import '../widgets/history/empty_history.dart';
import '../widgets/history/history_bottom_sheet.dart';
import '../widgets/history/history_card.dart';
import '../widgets/history/history_filter_chips.dart';
import '../widgets/history/recent_learning_section.dart';
import '../widgets/history/search_bar.dart';

class HistoryScreen extends GetView<HistoryController> {
  HistoryScreen({super.key});

  final TextEditingController searchController =
  TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(() {

          final bool isSearching =
              searchController.text.trim().isNotEmpty;

          return Column(
            children: [

              const SizedBox(height: 20),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [

                    Text(
                      "Learning History",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    Spacer(),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              HistorySearchBar(
                controller: searchController,
                onChanged: controller.searchHistory,
                onClear: () {
                  searchController.clear();
                  controller.loadHistory();
                },
              ),

              const SizedBox(height: 16),

              HistoryFilterChips(
                selectedFilter:
                controller.selectedFilter.value,
                onChanged: controller.filterHistory,
              ),

              const SizedBox(height: 16),

          Expanded(
          child: AnimatedSwitcher(

          duration: const Duration(
          milliseconds: 350,
          ),

          switchInCurve: Curves.easeOut,

          switchOutCurve: Curves.easeIn,

          child: controller.history.isEmpty
          ? const EmptyHistory(
          key: ValueKey("empty"),
          )
              : ListView(
          key: ValueKey(
          "${controller.selectedFilter.value.name}_${searchController.text.trim()}",
          ),

                    padding: const EdgeInsets.only(
                      bottom: 30,
                    ),

                    children: [

                    /// Recent Learning
                    if (!isSearching) ...[

                RecentLearningSection(

                recentItems:
                controller.recentLearning,

                onTap: (item) {

                  _showBottomSheet(item);

                },
              ),

              const SizedBox(height: 22),

              Padding(

                padding:
                const EdgeInsets.symmetric(
                  horizontal: 20,
                ),

                child: Row(

                  children: [

                    const Text(

                      "History",

                      style: TextStyle(

                        fontSize: 20,

                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    TextButton.icon(

                      onPressed: () {

                        Get.defaultDialog(

                          title:
                          "Delete History",

                          middleText:

                          "Delete all history from this screen?\n\nYour learning data will not saved.",

                          textCancel:
                          "Cancel",

                          textConfirm:
                          "Delete",

                          confirmTextColor:
                          Colors.white,

                          onConfirm: () {

                            controller
                                .clearHistory();

                            Get.back();

                          },
                        );
                      },

                      icon: const Icon(

                        Icons
                            .delete_outline,

                        color: Colors.red,

                      ),

                      label: const Text(

                        "Clear All",

                        style: TextStyle(

                          color: Colors.red,

                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
            ],

          /// History Cards
                      ...controller.history.map((item) {

                        return Dismissible(

                          key: ValueKey(item.id),

                          direction: DismissDirection.endToStart,

                          background: Container(

                            margin: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),

                            decoration: BoxDecoration(

                              color: Colors.red,

                              borderRadius: BorderRadius.circular(22),
                            ),

                            alignment: Alignment.centerRight,

                            padding: const EdgeInsets.only(
                              right: 25,
                            ),

                            child: const Column(

                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [

                                Icon(
                                  Icons.visibility_off,
                                  color: Colors.white,
                                  size: 30,
                                ),

                                SizedBox(height: 4),

                                Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          confirmDismiss: (_) async {

                            return await Get.dialog<bool>(

                              AlertDialog(

                                title: const Text(
                                  "Dide Translation",
                                ),

                                content: const Text(
                                  "This translation will disappear from History.",
                                ),

                                actions: [

                                  TextButton(

                                    onPressed: () {

                                      Get.back(result: false);

                                    },

                                    child: const Text(
                                      "Cancel",
                                    ),
                                  ),

                                  ElevatedButton(

                                    onPressed: () {

                                      Get.back(result: true);

                                    },

                                    child: const Text(
                                      "Delete",
                                    ),
                                  ),
                                ],
                              ),
                            ) ??
                                false;
                          },

                          onDismissed: (_) {

                            controller.deleteHistory(item.id!);

                          },

                          child: HistoryCard(

                            history: item,

                            onFavorite: () {

                              controller.toggleFavorite(item.id!);

                            },

                            onDelete: () {

                              controller.deleteHistory(item.id!);

                            },

                            onTap: () {

                              _showBottomSheet(item);

                            },
                          ),
                        );

                      }).toList(),

                    ],
                ),
              ),
          ),
            ],
          );
        }),
    );
  }

  void _showBottomSheet(item) {

    Get.bottomSheet(

      HistoryBottomSheet(

        history: item,

        onFavorite: () {

          controller.toggleFavorite(item.id!);

          Get.back();

        },
      ),

      isScrollControlled: true,

      backgroundColor: Colors.transparent,
    );
  }
}