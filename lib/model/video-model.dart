// To parse this JSON data, do
//
//     final vidModel = vidModelFromJson(jsonString);

import 'dart:convert';

List<VidModel> vidModelFromJson(String str) =>
    List<VidModel>.from(json.decode(str).map((x) => VidModel.fromJson(x)));

String vidModelToJson(List<VidModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class VidModel {
  String url;
  String title;
  Thumbnails thumbnails;

  VidModel({
    required this.url,
    required this.title,
    required this.thumbnails,
  });

  factory VidModel.fromJson(Map<String, dynamic> json) => VidModel(
        url: json["url"],
        title: json["title"],
        thumbnails: Thumbnails.fromJson(json["thumbnails"]),
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "title": title,
        "thumbnails": thumbnails.toJson(),
      };
}

class Thumbnails {
  Default thumbnailsDefault;
  Default medium;
  Default high;
  Default standard;
  Default maxres;

  Thumbnails({
    required this.thumbnailsDefault,
    required this.medium,
    required this.high,
    required this.standard,
    required this.maxres,
  });

  factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
        thumbnailsDefault: Default.fromJson(json["default"]),
        medium: Default.fromJson(json["medium"]),
        high: Default.fromJson(json["high"]),
        standard: Default.fromJson(json["standard"]),
        maxres: Default.fromJson(json["maxres"]),
      );

  Map<String, dynamic> toJson() => {
        "default": thumbnailsDefault.toJson(),
        "medium": medium.toJson(),
        "high": high.toJson(),
        "standard": standard.toJson(),
        "maxres": maxres.toJson(),
      };
}

class Default {
  String url;
  int width;
  int height;

  Default({
    required this.url,
    required this.width,
    required this.height,
  });

  factory Default.fromJson(Map<String, dynamic> json) => Default(
        url: json["url"],
        width: json["width"],
        height: json["height"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
      };
}
