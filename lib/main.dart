import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:language_learning/constants/app_colors.dart';
import 'package:language_learning/repositories/language_repo.dart';
import 'package:language_learning/screens/ai_screen.dart';
import 'package:language_learning/screens/daily_lesson_screen.dart';
import 'package:language_learning/screens/language_screen.dart';
import 'package:language_learning/screens/main_screen.dart';
import 'package:language_learning/screens/quiz_screen.dart';
import 'package:language_learning/screens/splash.dart';
import 'package:language_learning/services/starter_data_services.dart';
import 'package:language_learning/view_models/daily_lesson_vm.dart';
import 'package:language_learning/view_models/languageVM.dart';
import 'package:language_learning/view_models/main_navigation_vm.dart';

import 'binding/ai_translation_binding.dart';
import 'binding/app_binding.dart';
import 'binding/daily_binding.dart';
import 'binding/language_binding.dart';
import 'database/database_helper.dart';
import 'database/translation_history_table.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);


  await DatabaseHelper.instance.database;

  await StarterDataService().loadStarterData();

  AppBinding().dependencies();
  await dotenv.load(fileName: ".env");
  runApp(const LinguaLearnApp());

}

class LinguaLearnApp extends StatelessWidget {
  const LinguaLearnApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      title: 'LinguaLearn',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.accentGreen,
          primary: AppColors.accentGreen,
        ),
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'Roboto',
        useMaterial3: true,
      ),
      // home:  SplashScreen(),


      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/language',
          page: () => LanguageScreen(),
          binding: InitialBinding(),
        ),
        GetPage(
          name: '/splash',
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: '/MainScreen',
          page: () => const MainScreen(),
        ),
        GetPage(
          name: '/quiz',
          page: () => const QuizScreenQuestion(),

        ),
      ],
    );
  }
}
