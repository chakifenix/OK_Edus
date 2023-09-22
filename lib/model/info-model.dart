// To parse this JSON data, do
//
//     final infoModel = infoModelFromJson(jsonString);

import 'dart:convert';

InfoModel infoModelFromJson(String str) => InfoModel.fromJson(json.decode(str));

String infoModelToJson(InfoModel data) => json.encode(data.toJson());

class InfoModel {
  String mektepName;
  String mektepAddress;
  String phone;
  String email;
  String web;
  String directorFio;

  InfoModel({
    required this.mektepName,
    required this.mektepAddress,
    required this.phone,
    required this.email,
    required this.web,
    required this.directorFio,
  });

  factory InfoModel.fromJson(Map<String, dynamic> json) => InfoModel(
        mektepName: json["mektep_name"],
        mektepAddress: json["mektep_address"],
        phone: json["phone"],
        email: json["email"],
        web: json["web"],
        directorFio: json["director_fio"],
      );

  Map<String, dynamic> toJson() => {
        "mektep_name": mektepName,
        "mektep_address": mektepAddress,
        "phone": phone,
        "email": email,
        "web": web,
        "director_fio": directorFio,
      };
}
