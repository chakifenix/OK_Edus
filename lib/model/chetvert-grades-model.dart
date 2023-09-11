// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Chetvert> welcomeFromJson(String str) =>
    List<Chetvert>.from(json.decode(str).map((x) => Chetvert.fromJson(x)));

String welcomeToJson(List<Chetvert> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Chetvert {
  String predmetName;
  List<Grade> grades;

  Chetvert({
    required this.predmetName,
    required this.grades,
  });

  factory Chetvert.fromJson(Map<String, dynamic> json) => Chetvert(
        predmetName: json["predmet_name"],
        grades: List<Grade>.from(json["grades"].map((x) => Grade.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "predmet_name": predmetName,
        "grades": List<dynamic>.from(grades.map((x) => x.toJson())),
      };
}

class Grade {
  int chetvert;
  String? grade;

  Grade({
    required this.chetvert,
    required this.grade,
  });

  factory Grade.fromJson(Map<String, dynamic> json) => Grade(
        chetvert: json["chetvert"],
        grade: json["grade"],
      );

  Map<String, dynamic> toJson() => {
        "chetvert": chetvert,
        "grade": grade,
      };
}
