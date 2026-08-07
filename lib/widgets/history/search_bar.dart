import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';

class HistorySearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  const HistorySearchBar({
    super.key,
    required this.controller,
    this.onChanged,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText:
          "Search words, phrases or sentences...",
          hintStyle: const TextStyle(
            color: AppColors.textMuted,
          ),
          border: InputBorder.none,
          prefixIcon: const Icon(
            Icons.search_rounded,
            color: AppColors.primaryGreen,
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
            onPressed: onClear,
            icon: const Icon(
              Icons.close_rounded,
              color: AppColors.textSecondary,
            ),
          )
              : null,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 16),
        ),
      ),
    );
  }
}