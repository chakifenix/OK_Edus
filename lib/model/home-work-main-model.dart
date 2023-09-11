// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<HomeWorkModel> welcomeFromJson(String str) => List<HomeWorkModel>.from(
    json.decode(str).map((x) => HomeWorkModel.fromJson(x)));

String welcomeToJson(List<HomeWorkModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HomeWorkModel {
  int id;
  DateTime date;
  int predmetId;
  int distanceAccess;
  String predmetName;
  String tema;
  DateTime createdAt;
  bool isAnswered;
  String teacherFio;

  HomeWorkModel({
    required this.id,
    required this.date,
    required this.predmetId,
    required this.distanceAccess,
    required this.predmetName,
    required this.tema,
    required this.createdAt,
    required this.isAnswered,
    required this.teacherFio,
  });

  factory HomeWorkModel.fromJson(Map<String, dynamic> json) => HomeWorkModel(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        predmetId: json["predmet_id"],
        distanceAccess: json["distance_access"],
        predmetName: json["predmet_name"],
        tema: json["tema"],
        createdAt: DateTime.parse(json["created_at"]),
        isAnswered: json["is_answered"],
        teacherFio: json["teacher_fio"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "predmet_id": predmetId,
        "distance_access": distanceAccess,
        "predmet_name": predmetName,
        "tema": tema,
        "created_at": createdAt.toIso8601String(),
        "is_answered": isAnswered,
        "teacher_fio": teacherFio,
      };
}
