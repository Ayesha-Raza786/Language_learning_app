import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../models/translation_history_model.dart';

class HistoryCard extends StatelessWidget {
  final TranslationHistoryModel history;

  final VoidCallback? onTap;

  final VoidCallback? onDelete;

  final VoidCallback? onFavorite;

  const HistoryCard({
    super.key,

    required this.history,

    this.onTap,

    this.onDelete,

    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(

        duration: const Duration(
          milliseconds: 350,
        ),

        tween: Tween(
          begin: 0.95,
          end: 1,
        ),

        curve: Curves.easeOut,

        builder: (context, scale, child) {

          return Transform.scale(

            scale: scale,

            child: Opacity(

              opacity: scale,

              child: child,

            ),
          );
        },

        child: AnimatedContainer(
      duration: const Duration(milliseconds: 250),

      curve: Curves.easeOut,

      child: InkWell(
        borderRadius: BorderRadius.circular(22),

        onTap: onTap,

        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),

          padding: const EdgeInsets.all(18),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(22),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.05),
                blurRadius: 12,
                offset: const Offset(0, 5),
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      history.originalText,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: onFavorite,

                    icon: Icon(
                      history.isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border,

                      color: Colors.red,
                    ),
                  ),

                  IconButton(
                    onPressed: onDelete,

                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                  ),
                ],
              ),

              const SizedBox(height: 6),

              Text(
                history.translatedText,
                style: const TextStyle(
                  fontSize: 17,
                  color: AppColors.primaryGreen,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                runSpacing: 8,

                children: [
                  _chip(Icons.category_outlined, history.category),

                  _chip(Icons.bar_chart, history.difficulty),

                  _chip(Icons.translate, history.inputType),
                ],
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  const Icon(
                    Icons.record_voice_over,
                    size: 18,
                    color: AppColors.textSecondary,
                  ),

                  const SizedBox(width: 6),

                  Expanded(
                    child: Text(
                      history.pronunciation,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Row(
                children: [
                  Icon(
                    Icons.school_outlined,
                    color: Colors.orange.shade700,
                    size: 18,
                  ),

                  const SizedBox(width: 5),

                  Text(
                    "Practiced ${history.practiceCount} times",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),

                  const Spacer(),

                  Text(
                    history.createdAt.isEmpty
                        ? "-"
                        :history.createdAt.substring(0, 10),
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
        ),
    );
  }

  Widget _chip(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),

      decoration: BoxDecoration(
        color: AppColors.lightGreen,

        borderRadius: BorderRadius.circular(30),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          Icon(icon, size: 14, color: AppColors.darkGreen),

          const SizedBox(width: 5),

          Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: AppColors.darkGreen,
            ),
          ),
        ],
      ),
    );
  }
}
