// To parse this JSON data, do
//
//     final predmedPlanModel = predmedPlanModelFromJson(jsonString);

import 'dart:convert';

List<PredmedPlanModel> predmedPlanModelFromJson(String str) =>
    List<PredmedPlanModel>.from(
        json.decode(str).map((x) => PredmedPlanModel.fromJson(x)));

String predmedPlanModelToJson(List<PredmedPlanModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PredmedPlanModel {
  int id;
  String title;
  String sagat;

  PredmedPlanModel({
    required this.id,
    required this.title,
    required this.sagat,
  });

  factory PredmedPlanModel.fromJson(Map<String, dynamic> json) =>
      PredmedPlanModel(
        id: json["id"],
        title: json["title"],
        sagat: json["sagat"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "sagat": sagat,
      };
}
