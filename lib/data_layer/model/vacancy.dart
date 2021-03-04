// To parse this JSON data, do
//
//     final vacancy = vacancyFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'util.dart';
import 'experience_type.dart';
import 'experience_duration.dart';
import 'scroll.dart';

Vacancy vacancyFromJson(String str) => Vacancy.fromJson(json.decode(str));

String vacancyToJson(Vacancy data) => json.encode(data.toJson());

class Vacancy extends Equatable {
  Vacancy({
    this.id,
    this.userId,
    this.vacancyName,
    this.industry,
    this.grade,
    this.salary,
    this.workType,
    this.exp,
    this.tags,
    this.address,
    this.pubDate,
    this.leading,
    this.trailing,
    this.body,
  });

  final int id;
  final int userId;
  final String vacancyName;
  final String industry;
  final ExperienceType grade;
  final int salary;
  final List<String> workType;
  final ExperienceDuration exp;
  final List<String> tags;
  final String address;
  final DateTime pubDate;
  final String leading;
  final String trailing;
  final List<Scroll> body;

  Vacancy copyWith({
    int userId,
    String vacancyName,
    String industry,
    ExperienceType grade,
    int salary,
    List<String> workType,
    ExperienceDuration exp,
    List<String> tags,
    String address,
    DateTime pubDate,
    String leading,
    String trailing,
    List<Scroll> body,
  }) =>
      Vacancy(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        vacancyName: vacancyName ?? this.vacancyName,
        industry: industry ?? this.industry,
        grade: grade ?? this.grade,
        // dunno how to workaround it yet
        salary: salary,
        workType: workType ?? this.workType,
        exp: exp ?? this.exp,
        tags: tags ?? this.tags,
        address: address ?? this.address,
        pubDate: pubDate ?? this.pubDate,
        leading: leading ?? this.leading,
        trailing: trailing ?? this.trailing,
        body: body ?? this.body,
      );

  factory Vacancy.fromJson(Map<String, dynamic> json) => Vacancy(
        id: json["id"],
        userId: json["user_id"],
        vacancyName: json["vacancy_name"],
        industry: json["industry"],
        grade: experienceTypeFromJson(json["grade"]),
        salary: json["salary"],
        workType: List<String>.from(json["work_type"].map((x) => x)),
        exp: experienceDurationFromJson(json["exp"]),
        tags: List<String>.from(json["tags"].map((x) => x)),
        address: json["address"],
        pubDate: dateFromJson(json["pub_date"]),
        leading: json["leading"],
        trailing: json["trailing"],
        body: List<Scroll>.from(json["body"].map((x) => Scroll.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "vacancy_name": vacancyName,
        "industry": industry,
        "grade": experienceTypeToJson(grade),
        "salary": salary,
        "work_type": List<dynamic>.from(workType.map((x) => x)),
        "exp": experienceDurationToJson(exp),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "address": address,
        "pub_date": dateToJson(pubDate),
        "leading": leading,
        "trailing": trailing,
        "body": List<dynamic>.from(body.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [
        this.id,
        this.userId,
        this.vacancyName,
        this.industry,
        this.grade,
        this.salary,
        this.workType,
        this.exp,
        this.tags,
        this.address,
        this.pubDate,
        this.leading,
        this.trailing,
        this.body,
      ];
}
