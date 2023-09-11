// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  String name;
  String surname;
  String lastname;
  String teacherFio;
  String mektep;
  String profileModelClass;
  String language;
  Parent parent1;
  Parent parent2;

  ProfileModel({
    required this.name,
    required this.surname,
    required this.lastname,
    required this.teacherFio,
    required this.mektep,
    required this.profileModelClass,
    required this.language,
    required this.parent1,
    required this.parent2,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        name: json["name"],
        surname: json["surname"],
        lastname: json["lastname"],
        teacherFio: json["teacher_fio"],
        mektep: json["mektep"],
        profileModelClass: json["class"],
        language: json["language"],
        parent1: Parent.fromJson(json["parent_1"]),
        parent2: Parent.fromJson(json["parent_2"]),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "lastname": lastname,
        "teacher_fio": teacherFio,
        "mektep": mektep,
        "class": profileModelClass,
        "language": language,
        "parent_1": parent1.toJson(),
        "parent_2": parent2.toJson(),
      };
}

class Parent {
  String name;
  String surname;
  String lastname;

  Parent({
    required this.name,
    required this.surname,
    required this.lastname,
  });

  factory Parent.fromJson(Map<String, dynamic> json) => Parent(
        name: json["name"],
        surname: json["surname"],
        lastname: json["lastname"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "lastname": lastname,
      };
}
