import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class RecentTranslationCard extends StatelessWidget {
  const RecentTranslationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Recent Translation",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),

        const SizedBox(height: 14),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: AppColors.cardWhite,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(.08),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// English
              Row(
                children: const [

                  Text(
                    "🇬🇧",
                    style: TextStyle(fontSize: 22),
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      "Good Morning",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),

                ],
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

              /// Translation
              Row(
                children: const [

                  Text(
                    "🇹🇷",
                    style: TextStyle(fontSize: 22),
                  ),

                  SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      "Günaydın",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentGreen,
                      ),
                    ),
                  ),

                ],
              ),

              const SizedBox(height: 22),

              Row(
                children: [

                  Expanded(
                    child: Text(
                      "2 minutes ago",
                      style: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),

                  _ActionButton(
                    icon: Icons.volume_up_outlined,
                    onTap: () {},
                  ),

                  const SizedBox(width: 10),

                  _ActionButton(
                    icon: Icons.copy_outlined,
                    onTap: () {},
                  ),

                  const SizedBox(width: 10),

                  _ActionButton(
                    icon: Icons.favorite_border,
                    onTap: () {},
                  ),

                ],
              ),

            ],
          ),
        ),

      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.lightGreen,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          size: 20,
          color: AppColors.accentGreen,
        ),
      ),
    );
  }
}