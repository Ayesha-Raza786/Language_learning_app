import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constants/api_constant.dart';
import '../models/api/translation_response_model.dart';


class GeminiService {
  Future<TranslationResponseModel> translate({
    required String word,
    required String sourceLanguage,
    required String targetLanguage,
  }) async {
    final prompt = """
Translate "$word" from $sourceLanguage to $targetLanguage.

Return ONLY valid JSON in exactly this format.

{
  "sourceLanguageCode": "$sourceLanguage",
  "targetLanguageCode": "$targetLanguage",
   "translation":{

      "originalText":"",

      "translatedText":"",

      "pronunciation":"",

      "meaning":"",

      "category":"",

      "difficulty":"beginner",

      "inputType":"word"

  },
  "example": {
    "englishSentence": "",
    "translatedSentence": ""
  }
}

You are an English-to-Turkish language tutor.

Analyze the user's input.

Determine whether it is:

- word
- phrase
- sentence
- invalid

Rules:

1. If the input is not valid English,
   return:

status = "invalid"

inputType = "invalid"

message = "The entered text is not a valid English word, phrase, or sentence."

2. If valid:

status = "success"

message = "Translation completed successfully."
3. Return ONLY JSON.
4. Do not use markdown.
5. Do not write explanations.
6. difficulty must be one of:
   beginner
   intermediate
   advanced
7. The pronunciation MUST be for the TURKISH translated word, NOT the English word.
8. Write the pronunciation in simple English phonetics so an English speaker can easily read it.
9. Do NOT use IPA symbols.

Examples:
Merhaba -> mehr-ha-bah
Teşekkür ederim -> teh-sheh-kur eh-deh-rim
Güle güle -> goo-leh goo-leh
""";

    final response = await http.post(
      Uri.parse(
        "${ApiConstants.baseUrl}?key=${ApiConstants.apiKey}",
      ),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text": prompt,
              }
            ]
          }
        ]
      }),
    );

    if (response.statusCode != 200) {
      throw Exception(
        "Gemini API Error (${response.statusCode})\n${response.body}",
      );
    }

    final responseBody = jsonDecode(response.body);

    final String text =
    responseBody["candidates"][0]["content"]["parts"][0]["text"];

    // Remove markdown if Gemini returns it
    final cleanedText = text
        .replaceAll("```json", "")
        .replaceAll("```", "")
        .trim();

    final Map<String, dynamic> jsonMap =
    jsonDecode(cleanedText);

    return TranslationResponseModel.fromJson(jsonMap);
  }
}