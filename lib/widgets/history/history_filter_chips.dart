import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

enum HistoryFilter { all, words, phrases, sentences, favorites }

class HistoryFilterChips extends StatelessWidget {
  final HistoryFilter selectedFilter;
  final ValueChanged<HistoryFilter> onChanged;

  const HistoryFilterChips({
    super.key,
    required this.selectedFilter,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 46,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          _chip("All", HistoryFilter.all),
          _chip("Words", HistoryFilter.words),
          _chip("Phrases", HistoryFilter.phrases),
          _chip("Sentences", HistoryFilter.sentences),
          _chip(" Favorites", HistoryFilter.favorites),
        ],
      ),
    );
  }

  Widget _chip(
      String title,
      HistoryFilter filter,
      ) {
    final bool selected = selectedFilter == filter;

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        scale: selected ? 1.05 : 1.0,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => onChanged(filter),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 10,
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
              boxShadow: [
                if (selected)
                  BoxShadow(
                    color: AppColors.primaryGreen.withOpacity(.25),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              child: Text(title),
            ),
          ),
        ),
      ),
    );
  }
}
