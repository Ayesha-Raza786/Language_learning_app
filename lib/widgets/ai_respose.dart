import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AIResponseCard extends StatelessWidget {
  final String originalText;
  final String translatedText;
  final String pronunciation;
  final String meaning;
  final String exampleEnglish;
  final String exampleTranslated;
  final String category;
  final String difficulty;
  final String inputType;

  const AIResponseCard({
    super.key,
    required this.originalText,
    required this.translatedText,
    required this.pronunciation,
    required this.meaning,
    required this.exampleEnglish,
    required this.exampleTranslated,
    required this.category,
    required this.difficulty,
    required this.inputType,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(20),
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
      children:  [
      Icon(
      Icons.auto_awesome,
        color: AppColors.accentGreen,
      ),
      SizedBox(width: 8),
        Text(
          "${inputType[0].toUpperCase()}${inputType.substring(1)} Learning Assistant",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    ),

    const SizedBox(height: 20),

    Text(
    "🇬🇧 English",
    style: TextStyle(
    color: AppColors.textSecondary,
    fontWeight: FontWeight.w600,
    ),
    ),

    const SizedBox(height: 6),

    Text(
      originalText,
    style: const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    ),
    ),

    const SizedBox(height: 16),

    const Center(
    child: Icon(
    Icons.arrow_downward_rounded,
    color: AppColors.accentGreen,
    size: 28,
    ),
    ),

    const SizedBox(height: 16),

    Text(
    " Translation",
    style: TextStyle(
    color: AppColors.textSecondary,
    fontWeight: FontWeight.w600,
    ),
    ),

    const SizedBox(height: 6),

    Text(
    translatedText,
    style: const TextStyle(
    fontSize: 24,
    color: AppColors.accentGreen,
    fontWeight: FontWeight.bold,
    ),
    ),

    const Divider(height: 35),
    /// Pronunciation
    const Text(
    " Pronunciation",
    style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    ),
    ),

    const SizedBox(height: 8),

    Row(
    children: [
    Expanded(
    child: Text(
    pronunciation,
    style: const TextStyle(
    fontSize: 18,
    color: AppColors.textSecondary,
    fontStyle: FontStyle.italic,
    ),
    ),
    ),

    CircleAvatar(
    backgroundColor: AppColors.lightGreen,
    child: IconButton(
    onPressed: () {
    // TODO: Flutter TTS
    },
    icon: const Icon(
    Icons.volume_up,
    color: AppColors.accentGreen,
    ),
    ),
    ),
    ],
    ),

    const Divider(height: 35),

    /// Meaning
    const Text(
    "Meaning",
    style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    ),
    ),

    const SizedBox(height: 8),

    Text(
    meaning,
    style: const TextStyle(
    fontSize: 15,
    color: AppColors.textSecondary,
    height: 1.5,
    ),
    ),

    const Divider(height: 35),

    /// Example
    const Text(
    "Example Sentence",
    style: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    ),
    ),

    const SizedBox(height: 12),

    Container(
    width: double.infinity,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
    color: AppColors.background,
    borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [

    Text(
    "🇬🇧 $exampleEnglish",
    style: const TextStyle(
    fontWeight: FontWeight.w600,
    ),
    ),

    const SizedBox(height: 10),

    Text(
    " $exampleTranslated",
    style: const TextStyle(
    color: AppColors.accentGreen,
    fontWeight: FontWeight.w600,
    ),
    ),
    ],
    ),
    ),

    const Divider(height: 35),
          /// Category & Difficulty
          Row(
            children: [

              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreen,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child:/// Input Type • Category • Difficulty
                  Row(
                    children: [

                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [

                              const Text(
                                "Type",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                inputType.toUpperCase(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: AppColors.lightGreen,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [

                              const Text(
                                "Category",
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                category,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.accentGreen,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: Colors.orange.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [

                              const Text(
                                "Difficulty",
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 12,
                                ),
                              ),

                              const SizedBox(height: 4),

                              Text(
                                difficulty,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ),

            ],
          ),

          const SizedBox(height: 24),

          /// Action Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

              _actionButton(
                Icons.favorite_border,
                "Favorite",
                    () {
                  // TODO
                },
              ),

              _actionButton(
                Icons.copy,
                "Copy",
                    () {
                  // TODO
                },
              ),

              // _actionButton(
              //   Icons.volume_up,
              //   "Speak",
              //       () {
              //     // TODO Flutter TTS
              //   },
              // ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
      IconData icon,
      String title,
      VoidCallback onTap,
      ) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        width: 95,
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: AppColors.lightGreen,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          children: [

            Icon(
              icon,
              color: AppColors.accentGreen,
            ),

            const SizedBox(height: 6),

            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}