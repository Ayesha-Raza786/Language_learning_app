import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../models/translation_history_model.dart';

class HistoryBottomSheet extends StatelessWidget {
  final TranslationHistoryModel history;

  final VoidCallback? onFavorite;

  const HistoryBottomSheet({
    super.key,
    required this.history,
    this.onFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .82,

      padding: const EdgeInsets.all(24),

      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(30),
        ),
      ),

      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [

            Center(
              child: Container(
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius:
                  BorderRadius.circular(20),
                ),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              children: [

                Expanded(
                  child: Text(
                    history.originalText,
                    style: const TextStyle(
                      fontSize: 28,
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
              ],
            ),

            Text(
              history.translatedText,
              style: const TextStyle(
                fontSize: 24,
                color: AppColors.primaryGreen,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            _title("Pronunciation"),
            _value(history.pronunciation),

            _title("Meaning"),
            _value(history.meaning),

            _title("Category"),
            _value(history.category),

            _title("Difficulty"),
            _value(history.difficulty),

            _title("Input Type"),
            _value(history.inputType),

            _title("Languages"),
            _value(
              "${history.sourceLanguageCode.toUpperCase()} → ${history.targetLanguageCode.toUpperCase()}",
            ),

            _title("Practice Count"),
            _value(
              history.practiceCount.toString(),
            ),

            if (history.lastPracticed != null) ...[
              _title("Last Practiced"),
              _value(history.lastPracticed!),
            ],

            _title("Created"),
            _value(history.createdAt),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _title(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _value(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        text,
        style: const TextStyle(fontSize: 17),
      ),
    );
  }
}