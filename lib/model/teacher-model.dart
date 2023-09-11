// To parse this JSON data, do
//
//     final teacherModel = teacherModelFromJson(jsonString);

import 'dart:convert';

List<TeacherModel> teacherModelFromJson(String str) => List<TeacherModel>.from(
    json.decode(str).map((x) => TeacherModel.fromJson(x)));

String teacherModelToJson(List<TeacherModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TeacherModel {
  int id;
  String surname;
  String name;
  String birthday;
  String lastVisit;
  String predmetName;

  TeacherModel({
    required this.id,
    required this.surname,
    required this.name,
    required this.birthday,
    required this.lastVisit,
    required this.predmetName,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
        id: json["id"],
        surname: json["surname"],
        name: json["name"],
        birthday: json["birthday"],
        lastVisit: json["last_visit"],
        predmetName: json["predmet_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "surname": surname,
        "name": name,
        "birthday": birthday,
        "last_visit": lastVisit,
        "predmet_name": predmetName,
      };
}
