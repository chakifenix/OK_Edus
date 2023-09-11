// To parse this JSON data, do
//
//     final chatHistoryModel = chatHistoryModelFromJson(jsonString);

import 'dart:convert';

List<ChatHistoryModel> chatHistoryModelFromJson(String str) =>
    List<ChatHistoryModel>.from(
        json.decode(str).map((x) => ChatHistoryModel.fromJson(x)));

String chatHistoryModelToJson(List<ChatHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChatHistoryModel {
  int messageId;
  bool isMy;
  String text;
  String username;
  bool isRead;
  DateTime date;

  ChatHistoryModel({
    required this.messageId,
    required this.isMy,
    required this.text,
    required this.username,
    required this.isRead,
    required this.date,
  });

  factory ChatHistoryModel.fromJson(Map<String, dynamic> json) =>
      ChatHistoryModel(
        messageId: json["message_id"],
        isMy: json["is_my"],
        text: json["text"],
        username: json["username"],
        isRead: json["is_read"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "message_id": messageId,
        "is_my": isMy,
        "text": text,
        "username": username,
        "is_read": isRead,
        "date": date.toIso8601String(),
      };
}

// enum Username { EMPTY, USERNAME }

// final usernameValues = EnumValues(
//     {"НАГЫМЖАН АЛЬТАИР": Username.EMPTY, "Ахмет Асел": Username.USERNAME});

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
