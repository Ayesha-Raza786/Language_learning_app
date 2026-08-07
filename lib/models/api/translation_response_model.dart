import 'translation_data_model.dart';
import 'ai_example_model.dart';

enum TranslationStatus {
  success,
  invalid,
}

class TranslationResponseModel {

  final TranslationStatus status;

  final String message;

  final String sourceLanguageCode;

  final String targetLanguageCode;

  final TranslationDataModel translation;

  final AIExampleResponseModel example;

  TranslationResponseModel({

    required this.status,

    required this.message,

    required this.sourceLanguageCode,

    required this.targetLanguageCode,

    required this.translation,

    required this.example,

  });

  factory TranslationResponseModel.fromJson(
      Map<String,dynamic> json){

    return TranslationResponseModel(

      status: TranslationStatus.values.firstWhere(

            (e)=>e.name==
            (json["status"] ??
                "success"),

        orElse: ()=>TranslationStatus.success,

      ),

      message: json["message"] ?? "",

      sourceLanguageCode:
      json["sourceLanguageCode"] ?? "en",

      targetLanguageCode:
      json["targetLanguageCode"] ?? "tr",

      translation:
      TranslationDataModel.fromJson(
        json["translation"] ?? {},
      ),

      example:
      AIExampleResponseModel.fromJson(
        json["example"] ?? {},
      ),
    );
  }

  Map<String,dynamic> toJson(){

    return{

      "status":status.name,

      "message":message,

      "sourceLanguageCode":
      sourceLanguageCode,

      "targetLanguageCode":
      targetLanguageCode,

      "translation":
      translation.toJson(),

      "example":
      example.toJson(),
    };
  }
}