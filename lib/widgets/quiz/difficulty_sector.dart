import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class DifficultySelector extends StatelessWidget {
  final String selectedDifficulty;
  final ValueChanged<String> onChanged;

  const DifficultySelector({
    super.key,
    required this.selectedDifficulty,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final levels = [
      "Beginner",
      "Intermediate",
      "Advanced",
    ];

    return Row(
      children: levels.map((level) {
        final selected = selectedDifficulty == level;

        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: GestureDetector(
              onTap: () => onChanged(level),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.accentGreen
                      : Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: selected
                        ? AppColors.accentGreen
                        : Colors.grey.shade300,
                  ),
                ),
                child: Center(
                  child: Text(
                    level,
                    style: TextStyle(
                      color: selected
                          ? Colors.white
                          : AppColors.textMuted,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}