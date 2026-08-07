import 'dart:convert';

import 'package:flutter/services.dart';
import '../models/translation_history_model.dart';
import '../repositories/history_repo.dart';

const starterLoadedKey = "starter_loaded";

class StarterDataService {
  final HistoryRepository repository = HistoryRepository();

  Future<List<TranslationHistoryModel>>
  loadJson(
      String path,
      String source,
      ) async {

    final jsonString=
    await rootBundle.loadString(path);

    final List<dynamic> jsonList=
    jsonDecode(jsonString);

    return jsonList.map((e){

      return TranslationHistoryModel.fromJson(
        e,
        sourceType:source,
      );

    }).toList();
  }

}