import 'package:flutter/material.dart';

class LessonRatingButtons extends StatelessWidget {
  final VoidCallback onForgot;
  final VoidCallback onGood;
  final VoidCallback onEasy;

  const LessonRatingButtons({
    super.key,
    required this.onForgot,
    required this.onGood,
    required this.onEasy,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        20,
        0,
        20,
        0,
      ),
      child: Row(
        children: [
          Expanded(
            child: _button(
              label: "Forgot",
              icon: Icons.refresh_rounded,
              background: const Color(0xFFFFF3F2),
              iconColor: const Color(0xFFE74C3C),
              borderColor: const Color(0xFFF3C5C2),
              onTap: onForgot,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: _button(
              label: "Good",
              icon: Icons.sentiment_satisfied_alt_rounded,
              background: const Color(0xFFEAF2FF),
              iconColor: const Color(0xFF006D3C),
              borderColor: const Color(0xFFD2E3FF),
              onTap: onGood,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: _button(
              label: "Easy",
              icon: Icons.check_circle,
              background: const Color(0xFFEAFBF0),
              iconColor: const Color(0xFF22C55E),
              borderColor: const Color(0xFFD5F3DF),
              onTap: onEasy,
            ),
          ),
        ],
      ),
    );
  }

  Widget _button({
    required String label,
    required IconData icon,
    required Color background,
    required Color iconColor,
    required Color borderColor,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          height: 80,
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: borderColor,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconColor,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: iconColor.withOpacity(.18),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 18,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: iconColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}