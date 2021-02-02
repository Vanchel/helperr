// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User extends Equatable {
  User({
    this.id,
    this.name,
    this.email,
    this.userType,
  });

  final int id;
  final String name;
  final String email;
  final String userType;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        userType: json["user_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "user_type": userType,
      };

  @override
  List<Object> get props => [
        this.id,
        this.name,
        this.email,
        this.userType,
      ];
}
