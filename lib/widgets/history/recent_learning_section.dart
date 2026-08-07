import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../models/translation_history_model.dart';

class RecentLearningSection extends StatelessWidget {
  final List<TranslationHistoryModel> recentItems;

  final Function(TranslationHistoryModel)? onTap;

  const RecentLearningSection({
    super.key,
    required this.recentItems,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    if (recentItems.isEmpty) {
      return const SizedBox();
    }

    return Column(

      crossAxisAlignment:
      CrossAxisAlignment.start,

      children: [

        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Text(
            "Recently Learned",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),

        const SizedBox(height: 14),

        SizedBox(
          height: 125,

          child: ListView.builder(

            scrollDirection: Axis.horizontal,

            padding:
            const EdgeInsets.symmetric(
              horizontal: 20,
            ),

            itemCount: recentItems.length > 5
                ? 5
                : recentItems.length,

              itemBuilder: (context, index) {
                final item = recentItems[index];

                return TweenAnimationBuilder<double>(
                  duration: Duration(
                    milliseconds: 250 + (index * 120),
                  ),
                  curve: Curves.easeOutCubic,
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(
                        30 * (1 - value),
                        0,
                      ),
                      child: Transform.scale(
                        scale: 0.95 + (0.05 * value),
                        child: Opacity(
                          opacity: value,
                          child: child,
                        ),
                      ),
                    );
                  },
                  child: GestureDetector(
                    onTap: () => onTap?.call(item),

                    child: AnimatedContainer(
                      duration: const Duration(
                        milliseconds: 250,
                      ),
                      curve: Curves.easeOut,

                      width: 170,

                      margin: const EdgeInsets.only(
                        right: 14,
                      ),

                      padding: const EdgeInsets.all(16),

                      decoration: BoxDecoration(
                        color: Colors.white,

                        borderRadius:
                        BorderRadius.circular(20),

                        boxShadow: [
                          BoxShadow(
                            color:
                            Colors.black.withOpacity(.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          Text(
                            item.originalText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            item.translatedText,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color:
                              AppColors.primaryGreen,
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),

                          const Spacer(),

                          AnimatedContainer(
                            duration: const Duration(
                              milliseconds: 300,
                            ),

                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),

                            decoration: BoxDecoration(
                              color:
                              AppColors.lightGreen,
                              borderRadius:
                              BorderRadius.circular(
                                30,
                              ),
                            ),

                            child: Text(
                              item.difficulty.toUpperCase(),
                              style: const TextStyle(
                                color:
                                AppColors.darkGreen,
                                fontSize: 11,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
          ),
        ),
      ],
    );
  }
}