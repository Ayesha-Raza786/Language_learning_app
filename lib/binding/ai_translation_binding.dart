// import 'package:get/get.dart';
//
// import '../repositories/ai_repo.dart';
// import '../repositories/history_repo.dart';
// import '../services/gemini_service.dart';
// import '../view_models/ai_vm.dart';
// import '../view_models/history_vm.dart';
//
// class TranslationBinding extends Bindings {
//   @override
//   void dependencies() {
//
//     Get.lazyPut<GeminiService>(
//           ()=>GeminiService(),
//     );
//
//     Get.lazyPut<TranslationRepository>(
//           ()=>TranslationRepository(
//         Get.find<GeminiService>(),
//       ),
//     );
//
//     Get.lazyPut<HistoryRepository>(
//           ()=>HistoryRepository(),
//     );
//
//     Get.lazyPut<TranslationController>(
//           ()=>TranslationController(
//
//         Get.find<TranslationRepository>(),
//
//         Get.find<HistoryRepository>(),
//
//       ),
//     );
//
//     Get.lazyPut<HistoryController>(
//           ()=>HistoryController(
//         Get.find<HistoryRepository>(),
//       ),
//     );
//   }
// }