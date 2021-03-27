// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'user_type.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User extends Equatable {
  const User({
    this.id,
    this.name,
    this.email,
    this.userType,
  });

  final int id;
  final String name;
  final String email;
  final UserType userType;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        userType: userTypeFromJson(json["user_type"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "user_type": userTypeToJson(userType),
      };

  static const empty = User(
    id: -1,
    name: '',
    email: '',
    userType: UserType.employee,
  );

  @override
  List<Object> get props => [
        this.id,
        this.name,
        this.email,
        this.userType,
      ];
}
