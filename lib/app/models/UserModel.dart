// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.id,
    this.idGoogle,
    this.name,
    this.login,
    this.passwords,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? idGoogle;
  String? name;
  String? login;
  String? passwords;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        idGoogle: json["idGoogle"],
        name: json["name"],
        login: json["login"],
        passwords: json["passwords"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "idGoogle": idGoogle,
        "name": name,
        "login": login,
        "passwords": passwords,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
