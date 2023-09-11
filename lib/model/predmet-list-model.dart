// To parse this JSON data, do
//
//     final predmetListModel = predmetListModelFromJson(jsonString);

import 'dart:convert';

List<PredmetListModel> predmetListModelFromJson(String str) =>
    List<PredmetListModel>.from(
        json.decode(str).map((x) => PredmetListModel.fromJson(x)));

String predmetListModelToJson(List<PredmetListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PredmetListModel {
  int id;
  int sagat;
  int subgroup;
  int idSubgroup;
  String predmetName;
  String teacherSurname;
  String teacherName;
  bool isCriterial;

  PredmetListModel({
    required this.id,
    required this.sagat,
    required this.subgroup,
    required this.idSubgroup,
    required this.predmetName,
    required this.teacherSurname,
    required this.teacherName,
    required this.isCriterial,
  });

  factory PredmetListModel.fromJson(Map<String, dynamic> json) =>
      PredmetListModel(
        id: json["id"],
        sagat: json["sagat"],
        subgroup: json["subgroup"],
        idSubgroup: json["id_subgroup"],
        predmetName: json["predmet_name"],
        teacherSurname: json["teacher_surname"],
        teacherName: json["teacher_name"],
        isCriterial: json["is_criterial"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sagat": sagat,
        "subgroup": subgroup,
        "id_subgroup": idSubgroup,
        "predmet_name": predmetName,
        "teacher_surname": teacherSurname,
        "teacher_name": teacherName,
        "is_criterial": isCriterial,
      };
}
