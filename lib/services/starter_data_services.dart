import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/translation_history_model.dart';
import '../repositories/history_repo.dart';

const starterLoadedKey = "starter_loaded";

class StarterDataService {
  final HistoryRepository repository = HistoryRepository();
  Future<List<TranslationHistoryModel>> loadJson(
      String path,
      String sourceType,
      ) async {

    final jsonString = await rootBundle.loadString(path);

    final List data = json.decode(jsonString);



    return data.map((e) {

      return TranslationHistoryModel.fromJson({
        ...e,
        "sourceType": sourceType,
      });
    }).toList();
  }

  Future<List<TranslationHistoryModel>> _loadStarterData() async {
    final allData = <TranslationHistoryModel>[];

    allData.addAll(await loadJson(
      'assets/data/starter_data.json',
      'system',
    ));

    allData.addAll(await loadJson(
      'assets/data/beginner_words.json',
      'system',
    ));

    allData.addAll(await loadJson(
      'assets/data/beginner_phrase.json',
      'system',
    ));

    allData.addAll(await loadJson(
      'assets/data/beginner_sentence.json',
      'system',
    ));

    allData.addAll(await loadJson(
      'assets/data/intermediate_word.json',
      'system',
    ));

    allData.addAll(await loadJson(
      'assets/data/intermediate_phrase.json',
      'system',
    ));

    allData.addAll(await loadJson(
      'assets/data/intermediate_sentence.json',
      'system',
    ));

    allData.addAll(await loadJson(
      'assets/data/advance_words.json',
      'system',
    ));

    allData.addAll(await loadJson(
      'assets/data/advance_phrase.json',
      'system',
    ));

    allData.addAll(await loadJson(
      'assets/data/advance_sentence.json',
      'system',
    ));

    return allData;
  }
  Future<void> loadStarterData() async {

    final items = await _loadStarterData();

    int inserted = 0;
    int skipped = 0;

    for (final item in items) {
      try {
        final exists = await repository.translationExists(item);

        if (!exists) {
          await repository.insertTranslation(item);
          inserted++;
        } else {
          skipped++;

        }
      } catch (e) {
        // print("FAILED: ${item.originalText}");
        // print(e);
      }
    }

  }
}