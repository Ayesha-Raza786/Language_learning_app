import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  final String letter;
  final String text;
  final bool selected;
  final bool correct;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.letter,
    required this.text,
    required this.onTap,
    this.selected = false,
    this.correct = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xffECF9F0)
              : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected
                ? const Color(0xff0B7A3D)
                : Colors.grey.shade200,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.04),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: selected
                  ? const Color(0xff0B7A3D)
                  : const Color(0xffEDF3FF),
              child: Text(
                letter,
                style: TextStyle(
                  color: selected
                      ? Colors.white
                      : Colors.black54,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(width: 18),

            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            if (selected && correct)
              Container(
                height: 34,
                width: 34,
                decoration: const BoxDecoration(
                  color: Color(0xff0B7A3D),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 20,
                ),
              ),
          ],
        ),
      ),
    );
  }
}