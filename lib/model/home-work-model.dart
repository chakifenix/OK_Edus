// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

HomeWorkPageModel welcomeFromJson(String str) =>
    HomeWorkPageModel.fromJson(json.decode(str));

String welcomeToJson(HomeWorkPageModel data) => json.encode(data.toJson());

class HomeWorkPageModel {
  bool isAnswered;
  String diaryId;
  String predmetName;
  int sagat;
  String teacherFio;
  String title;
  String homework;
  String literatura;
  String fileUrl;
  String media;
  String link;
  String teacherComment;
  String mark;
  String studentAnswer;
  List<String> studentImages;

  HomeWorkPageModel({
    required this.isAnswered,
    required this.diaryId,
    required this.predmetName,
    required this.sagat,
    required this.teacherFio,
    required this.title,
    required this.homework,
    required this.literatura,
    required this.fileUrl,
    required this.media,
    required this.link,
    required this.teacherComment,
    required this.mark,
    required this.studentAnswer,
    required this.studentImages,
  });

  factory HomeWorkPageModel.fromJson(Map<String, dynamic> json) =>
      HomeWorkPageModel(
        isAnswered: json["is_answered"],
        diaryId: json["diary_id"],
        predmetName: json["predmet_name"],
        sagat: json["sagat"],
        teacherFio: json["teacher_fio"],
        title: json["title"],
        homework: json["homework"],
        literatura: json["literatura"],
        fileUrl: json["file_url"],
        media: json["media"],
        link: json["link"],
        teacherComment: json["teacher_comment"],
        mark: json["mark"],
        studentAnswer: json["student_answer"],
        studentImages: List<String>.from(json["student_images"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "is_answered": isAnswered,
        "diary_id": diaryId,
        "predmet_name": predmetName,
        "sagat": sagat,
        "teacher_fio": teacherFio,
        "title": title,
        "homework": homework,
        "literatura": literatura,
        "file_url": fileUrl,
        "media": media,
        "link": link,
        "teacher_comment": teacherComment,
        "mark": mark,
        "student_answer": studentAnswer,
        "student_images": List<dynamic>.from(studentImages.map((x) => x)),
      };
}
