import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:language_learning/constants/app_colors.dart';
import 'package:language_learning/screens/home_screen.dart';
import 'package:language_learning/screens/ai_screen.dart';
import 'package:language_learning/screens/quiz_screen_main.dart';
import '../view_models/home_vm.dart';
import '../view_models/main_navigation_vm.dart';
import 'daily_lesson_screen.dart';
import 'history_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  late final MainNavigationController navController;
  late final HomeController homeController;
  static final _screens = [
    const HomeScreen(),
    const FlashcardsScreen(),
    const QuizScreen(),
    const AIScreen(),
    HistoryScreen(),
  ];
  @override

  void initState() {
    super.initState();

    navController = Get.find<MainNavigationController>();
    homeController = Get.find<HomeController>();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(
            () => IndexedStack(
          index: navController.currentIndex.value,
          children: _screens,
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Obx(
                    () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(0, Icons.home_rounded, 'Home'),
                    _buildNavItem(1, Icons.style_rounded, 'Lessons'),
                    _buildNavItem(2, Icons.quiz_outlined, 'Quiz'),
                    _buildNavItem(3, Icons.chat_bubble_outline_outlined, 'AI'),
                    _buildNavItem(4, Icons.history, 'History'),
                  ],
                ),
              ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected =
        navController.currentIndex.value == index;

    return GestureDetector(
      onTap: () {
        navController.changeTab(index);
      },
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 48 : 40,
            height: isSelected ? 48 : 40,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.darkGreen : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 24,
              color: isSelected ? Colors.white : AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? AppColors.darkGreen : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
