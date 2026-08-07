import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  final String word;

  const WordCard({
    super.key,
    required this.word,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 34,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(26),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: Colors.green.shade200,
                  thickness: 1.2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  "TRANSLATE THE WORD",
                  style: TextStyle(
                    fontSize: 13,
                    letterSpacing: 1,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: Divider(
                  color: Colors.green.shade200,
                  thickness: 1.2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 30),

          Text(
            word,
            style: const TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.bold,
              color: Color(0xff0B7A3D),
            ),
          ),
        ],
      ),
    );
  }
}