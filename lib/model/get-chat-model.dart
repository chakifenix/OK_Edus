// To parse this JSON data, do
//
//     final getChatModel = getChatModelFromJson(jsonString);

import 'dart:convert';

List<GetChatModel> getChatModelFromJson(String str) => List<GetChatModel>.from(
    json.decode(str).map((x) => GetChatModel.fromJson(x)));

String getChatModelToJson(List<GetChatModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetChatModel {
  String channelId;
  String username;
  String sender;
  String message;
  DateTime date;
  int unreadCount;

  GetChatModel({
    required this.channelId,
    required this.username,
    required this.sender,
    required this.message,
    required this.date,
    required this.unreadCount,
  });

  factory GetChatModel.fromJson(Map<String, dynamic> json) => GetChatModel(
        channelId: json["channel_id"],
        username: json["username"],
        sender: json["sender"],
        message: json["message"],
        date: DateTime.parse(json["date"]),
        unreadCount: json["unread_count"],
      );

  Map<String, dynamic> toJson() => {
        "channel_id": channelId,
        "username": username,
        "sender": sender,
        "message": message,
        "date": date.toIso8601String(),
        "unread_count": unreadCount,
      };
}
