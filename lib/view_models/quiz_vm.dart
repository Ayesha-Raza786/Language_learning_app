import 'package:get/get.dart';
import '../models/quiz_answer_result_model.dart';
import '../models/quiz_model.dart';
import '../repositories/quiz_repo.dart';
import '../screens/quiz_result_screen.dart';

class QuizController extends GetxController {
  final QuizRepository repository;

  QuizController({
    required this.repository,
  });

  final RxList<QuizQuestionModel> questions =
      <QuizQuestionModel>[].obs;

  final RxInt currentIndex = 0.obs;

  final RxInt score = 0.obs;

  final RxBool answered = false.obs;

  final RxInt selectedOption = (-1).obs;

  final RxBool isLoading = true.obs;
  final RxBool answerCorrect = false.obs;
  final RxInt totalQuestions = 0.obs;

  final RxInt totalWords = 0.obs;

  final RxInt totalPhrases = 0.obs;

  final RxInt totalSentences = 0.obs;

  QuizQuestionModel get currentQuestion =>
      questions[currentIndex.value];
  final RxList<QuizAnswerResult> results =
      <QuizAnswerResult>[].obs;
  @override
  void onInit() {
    super.onInit();
    loadQuiz();
  }
  Future<void> loadQuiz() async {
    isLoading.value = true;

    results.clear();

    score.value = 0;

    currentIndex.value = 0;

    answered.value = false;

    selectedOption.value = -1;

    questions.value = await repository.generateQuiz();

    totalQuestions.value =
    await repository.totalQuestions();

    totalWords.value =
    await repository.totalWords();

    totalPhrases.value =
    await repository.totalPhrases();

    totalSentences.value =
    await repository.totalSentences();

    isLoading.value = false;
  }
  Future<void> checkAnswer(int index) async {
    if (answered.value) return;

    answered.value = true;
    selectedOption.value = index;
    answerCorrect.value =
        currentQuestion.options[index] ==
            currentQuestion.correctAnswer;

    results.add(
      QuizAnswerResult(
        question: currentQuestion,
        correct: answerCorrect.value,
      ),
    );

    if (answerCorrect.value) {
      score.value++;
    }
  }
  void nextQuestion() {
    if (currentIndex.value <
        questions.length - 1) {

      currentIndex.value++;

      answered.value = false;

      selectedOption.value = -1;
      answerCorrect.value = false;
      return;
    }

    finishQuiz();
  }
  void finishQuiz() {
    print(
      "Quiz Finished: "
          "${score.value}/${questions.length}",
    );
    Get.off(() => const QuizResultScreen());
  }
  Future<void> restartQuiz() async {
    await loadQuiz();
  }

  double get accuracy {
    if (questions.isEmpty) {
      return 0;
    }

    return score.value / questions.length;
  }
  double get progress {
    if (questions.isEmpty) {
      return 0;
    }

    return (currentIndex.value + 1) / questions.length;
  }

  int get remainingQuestions {
    if (questions.isEmpty) {
      return 0;
    }

    return questions.length - currentIndex.value;
  }

  bool get quizCompleted {
    return currentIndex.value >= questions.length;
  }


  int get correctAnswers => score.value;

  int get wrongAnswers =>
      questions.length - correctAnswers;

  double get percentage {
    if (questions.isEmpty) return 0;

    return correctAnswers / questions.length;
  }
  double get wordProgress {
    if (quizWords == 0) return 0;

    return correctWords / quizWords;
  }

  double get phraseProgress {
    if (quizPhrases == 0) return 0;

    return correctPhrases / quizPhrases;
  }

  double get sentenceProgress {
    if (quizSentences == 0) return 0;

    return correctSentences / quizSentences;
  }
  String get performanceTitle {
    if (percentage >= .90) {
      return "Excellent Performance";
    }

    if (percentage >= .75) {
      return "Great Job";
    }

    if (percentage >= .50) {
      return "Good Progress";
    }

    return "Keep Practicing";
  }
  int get stars {
    if (percentage >= .90) return 5;
    if (percentage >= .75) return 4;
    if (percentage >= .60) return 3;
    if (percentage >= .40) return 2;

    return 1;
  }
  String get wordsLabel =>
      "$correctWords/$quizWords";

  String get phrasesLabel =>
      "$correctPhrases/$quizPhrases";

  String get sentencesLabel =>
      "$correctSentences/$quizSentences";
  int get quizWords =>
      questions.where((q) => q.inputType == "word").length;

  int get quizPhrases =>
      questions.where((q) => q.inputType == "phrase").length;

  int get quizSentences =>
      questions.where((q) => q.inputType == "sentence").length;
  int get correctWords =>
      results.where((r) =>
      r.question.inputType == "word" &&
          r.correct).length;

  int get correctPhrases =>
      results.where((r) =>
      r.question.inputType == "phrase" &&
          r.correct).length;

  int get correctSentences =>
      results.where((r) =>
      r.question.inputType == "sentence" &&
          r.correct).length;

}