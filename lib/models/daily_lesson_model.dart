class DailyLessonModel {
  final int? id;

  final String lessonDate;

  final int historyId;

  final int lessonOrder;

  /// -1 = Not Reviewed
  /// 0 = Forgot
  /// 1 = Good
  /// 2 = Easy
  final int reviewResult;

  const DailyLessonModel({
    this.id,
    required this.lessonDate,
    required this.historyId,
    required this.lessonOrder,
    this.reviewResult = -1,
  });

  factory DailyLessonModel.fromJson(
      Map<String, dynamic> json) {
    return DailyLessonModel(
      id: json["lessonId"],
      lessonDate:
      json["lessonDate"] ?? "",

      historyId:
      json["historyId"] ?? 0,

      lessonOrder:
      json["lessonOrder"] ?? 0,

      reviewResult:
      json["reviewResult"] ?? -1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,

      "lessonDate": lessonDate,

      "historyId": historyId,

      "lessonOrder": lessonOrder,

      "reviewResult": reviewResult,
    };
  }
}