// To parse this JSON data, do
//
//     final resModel = resModelFromJson(jsonString);

import 'dart:convert';

List<ResModel> resModelFromJson(String str) =>
    List<ResModel>.from(json.decode(str).map((x) => ResModel.fromJson(x)));

String resModelToJson(List<ResModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResModel {
  String name;
  String type;
  String description;
  String logo;
  String url;

  ResModel({
    required this.name,
    required this.type,
    required this.description,
    required this.logo,
    required this.url,
  });

  factory ResModel.fromJson(Map<String, dynamic> json) => ResModel(
        name: json["name"],
        type: json["type"],
        description: json["description"],
        logo: json["logo"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "type": type,
        "description": description,
        "logo": logo,
        "url": url,
      };
}
