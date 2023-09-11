// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

List<Classmates> welcomeFromJson(String str) =>
    List<Classmates>.from(json.decode(str).map((x) => Classmates.fromJson(x)));

String welcomeToJson(List<Classmates> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Classmates {
  int id;
  String name;
  String surname;
  String lastname;
  String birthday;
  String? email;

  Classmates({
    required this.id,
    required this.name,
    required this.surname,
    required this.lastname,
    required this.birthday,
    required this.email,
  });

  factory Classmates.fromJson(Map<String, dynamic> json) => Classmates(
        id: json["id"],
        name: json["name"],
        surname: json["surname"],
        lastname: json["lastname"],
        birthday: json["birthday"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "surname": surname,
        "lastname": lastname,
        "birthday": birthday,
        "email": email,
      };
}
