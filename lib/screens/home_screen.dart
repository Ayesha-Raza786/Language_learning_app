import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:language_learning/constants/app_colors.dart';
import '../view_models/daily_lesson_vm.dart';
import '../view_models/home_vm.dart';
import '../view_models/main_navigation_vm.dart';
import 'essential_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;
  final HomeController controller = Get.find<HomeController>();
  RxString todayCategory = "".obs;
  final RxBool isLessonLoading = false.obs;
  static const _categories = ['Vocabulary', 'Grammar', 'Phrases'];

  final DailyLessonController lessonController =
      Get.find<DailyLessonController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _buildHeader()),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildFeaturedLessonCard(),
                const SizedBox(height: 16),
                _buildDailyProgressCard(),
                const SizedBox(height: 24),
                _buildContinueSection(),
                const SizedBox(height: 10),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "LinguaLearn",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: AppColors.darkGreen,
                    ),
                  ),

                  SizedBox(height: 2),

                  Text(
                    "Learn Something New Today in Turkish",
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),

            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: AppColors.primaryGreen.withOpacity(.12),
                borderRadius: BorderRadius.circular(14),
              ),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_none_rounded,
                  color: AppColors.darkGreen,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildFeaturedLessonCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF34D399), Color(0xFF10B981)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: -8,
            top: -8,
            child: Icon(
              Icons.menu_book_outlined,
              size: 100,
              color: Colors.white.withValues(alpha: 0.15),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.darkGreen.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  "FEATURED LESSON",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final lesson = controller.todayLesson.value;

                if (lesson == null) {
                  return const Text(
                    "No lesson available",
                    style: TextStyle(color: Colors.white),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.18),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              const Icon(
                                Icons.category_outlined,
                                color: Colors.white,
                                size: 15,
                              ),

                              const SizedBox(width: 6),

                              Text(
                                controller.getTodayCategory(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        Text(
                          lesson.translation.originalText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          lesson.translation.translatedText,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),

                        const SizedBox(height: 10),

                        Text(
                          lesson.translation.meaning,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),

                  ],
                );
              }),
              const SizedBox(height: 16),
              Obx(() {
                final completed = lessonController.lessonCompleted.value;

                return FilledButton.icon(
                  onPressed: () async {
                    if (completed) {
                      await lessonController.restartLesson();
                    }

                    Get.find<MainNavigationController>().changeTab(1);
                  },
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.darkGreen,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: Icon(
                    completed
                        ? Icons.refresh_rounded
                        : Icons.play_arrow_rounded,
                  ),
                  label: Text(
                    completed ? "Review Again" : "Start Lesson",
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDailyProgressCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardWhite,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Daily Progress',
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),

                /// Lesson Status
                Obx(
                  () => Text(
                    lessonController.lessonCompleted.value
                        ? "Today's Lesson Completed"
                        : "Today's Lesson",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),

                const SizedBox(height: 6),

                /// Progress Text
                Obx(() {
                  if (lessonController.lessonCompleted.value) {
                    return const Text(
                      "Completed",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentGreen,
                      ),
                    );
                  }

                  return RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                      children: [
                        TextSpan(
                          text: "${lessonController.currentIndex.value + 1}",
                          style: const TextStyle(color: AppColors.accentGreen),
                        ),
                        TextSpan(
                          text: " / ${lessonController.lesson.length}",
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          const SizedBox(width: 16),

          SizedBox(
            width: 72,
            height: 72,
            child: Stack(
              alignment: Alignment.center,
              children: [
                /// Progress Circle
                Obx(
                  () => SizedBox(
                    width: 72,
                    height: 72,
                    child: CircularProgressIndicator(
                      value: lessonController.lessonProgress.value,
                      strokeWidth: 6,
                      backgroundColor: AppColors.lightGreen,
                      color: AppColors.accentGreen,
                      strokeCap: StrokeCap.round,
                    ),
                  ),
                ),

                /// Percentage
                Obx(
                  () => Text(
                    "${(lessonController.lessonProgress.value * 100).round()}%",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppColors.accentGreen,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContinueSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Pick up where you left off',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: AppColors.accentGreen,
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: const Text(
                'View all',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildContinueItem(
        icon: Icons.menu_book_rounded,
        iconColor: Colors.green,
        iconBg: Colors.green.shade100,
        title: "Words",
        subtitle: "Essential words",
        inputType: "word",
        ),
        const SizedBox(height: 10),
        _buildContinueItem(
          icon: Icons.chat_bubble_outline,
          iconColor: Colors.orange,
          iconBg: Colors.orange.shade100,
          title: "Phrases",
          subtitle: "Common daily phrases",
          inputType: "phrase",
        ),
        const SizedBox(height: 10),
        _buildContinueItem(
          icon: Icons.subject,
          iconColor: Colors.blue,
          iconBg: Colors.blue.shade100,
          title: "Sentences",
          subtitle: "Practice complete sentences",
          inputType: "sentence",
        ),
      ],
    );
  }

  Widget _buildContinueItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required String inputType,
  }) {
    return Material(
      color: AppColors.cardWhite,
      borderRadius: BorderRadius.circular(16),
      elevation: 0,
      child: InkWell(
        onTap: () {
          Get.to(
                () => EssentialScreen(
              inputType: inputType,
            ),
          );
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: const Color(0xFFF3F4F6),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  icon,
                  color: iconColor,
                  size: 24,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              const Icon(
                Icons.chevron_right_rounded,
                color: AppColors.textMuted,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeeklyMomentumCard() {
    const barData = [
      ('MON', 0.35),
      ('TUE', 0.45),
      ('WED', 0.55),
      ('THU', 0.65),
      ('FRI', 1.0),
      ('SAT', 0.5),
      ('SUN', 0.4),
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.momentumBg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            child: Icon(
              Icons.show_chart_rounded,
              size: 80,
              color: AppColors.accentGreen.withValues(alpha: 0.12),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Weekly Momentum',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: barData.map((item) {
                    final isPeak = item.$2 == 1.0;
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              height: 70 * item.$2,
                              decoration: BoxDecoration(
                                color: isPeak
                                    ? AppColors.darkGreen
                                    : AppColors.accentGreen.withValues(
                                        alpha: 0.35,
                                      ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.$1,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: isPeak
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: isPeak
                                    ? AppColors.darkGreen
                                    : AppColors.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
