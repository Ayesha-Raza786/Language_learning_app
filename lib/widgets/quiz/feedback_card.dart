import 'package:flutter/material.dart';

class FeedbackCard extends StatelessWidget {
  final bool isCorrect;
  final String correctAnswer;

  const FeedbackCard({
    super.key,
    required this.isCorrect,
    required this.correctAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: isCorrect
            ? const Color(0xffECF9F0)
            : const Color(0xffFDECEC),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isCorrect
              ? const Color(0xffB7E7C5)
              : const Color(0xffF5B5B5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              color: isCorrect
                  ? const Color(0xff0B7A3D)
                  : Colors.red,
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCorrect
                  ? Icons.check_rounded
                  : Icons.close_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCorrect ? "Excellent!" : "Incorrect!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isCorrect
                        ? const Color(0xff0B7A3D)
                        : Colors.red,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'Correct answer: "$correctAnswer"',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  isCorrect
                      ? "Great job! Keep going."
                      : "Don't worry. You'll get it next time.",
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}