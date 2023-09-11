// To parse this JSON data, do
//
//     final mainPageModel = mainPageModelFromJson(jsonString);

import 'dart:convert';

MainPageModel mainPageModelFromJson(String str) =>
    MainPageModel.fromJson(json.decode(str));

String mainPageModelToJson(MainPageModel data) => json.encode(data.toJson());

class MainPageModel {
  Info info;
  List<dynamic> diary;
  List<NewsList> newsList;

  MainPageModel({
    required this.info,
    required this.diary,
    required this.newsList,
  });

  factory MainPageModel.fromJson(Map<String, dynamic> json) => MainPageModel(
        info: Info.fromJson(json["info"]),
        diary: List<dynamic>.from(json["diary"].map((x) => x)),
        newsList: List<NewsList>.from(
            json["news_list"].map((x) => NewsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "info": info.toJson(),
        "diary": List<dynamic>.from(diary.map((x) => x)),
        "news_list": List<dynamic>.from(newsList.map((x) => x.toJson())),
      };
}

class Info {
  DateTime currentTime;
  int dayNumber;
  String day;
  int messageCount;

  Info({
    required this.currentTime,
    required this.dayNumber,
    required this.day,
    required this.messageCount,
  });

  factory Info.fromJson(Map<String, dynamic> json) => Info(
        currentTime: DateTime.parse(json["current_time"]),
        dayNumber: json["day_number"],
        day: json["day"],
        messageCount: json["message_count"],
      );

  Map<String, dynamic> toJson() => {
        "current_time": currentTime.toIso8601String(),
        "day_number": dayNumber,
        "day": day,
        "message_count": messageCount,
      };
}

class NewsList {
  int id;
  String title;
  String imageUrl;
  String date;

  NewsList({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.date,
  });

  factory NewsList.fromJson(Map<String, dynamic> json) => NewsList(
        id: json["id"],
        title: json["title"],
        imageUrl: json["image_url"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image_url": imageUrl,
        "date": date,
      };
}
