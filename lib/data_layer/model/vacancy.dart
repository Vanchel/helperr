// To parse this JSON data, do
//
//     final vacancy = vacancyFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'address.dart';
import 'util.dart';
import 'experience_type.dart';
import 'work_type.dart';
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
    this.bgHeaderColor,
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
  final Set<WorkType> workType;
  final ExperienceDuration exp;
  final List<String> tags;
  final Address address;
  final String bgHeaderColor;
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
    Set<WorkType> workType,
    ExperienceDuration exp,
    List<String> tags,
    Address address,
    String bgHeaderColor,
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
        salary: salary ?? this.salary,
        workType: workType ?? this.workType,
        exp: exp ?? this.exp,
        tags: tags ?? this.tags,
        address: address ?? this.address,
        bgHeaderColor: bgHeaderColor ?? this.bgHeaderColor,
        pubDate: pubDate ?? this.pubDate,
        leading: leading ?? this.leading,
        trailing: trailing ?? this.trailing,
        body: body ?? this.body,
      );

  factory Vacancy.fromJson(Map<String, dynamic> json) => Vacancy(
        id: json["id"],
        userId: json["user"],
        vacancyName: json["vacancy_name"],
        industry: json["industry"],
        grade: experienceTypeFromJson(json["grade"]),
        salary: json["salary"],
        workType: Set<WorkType>.from(
            json["work_type"]?.map((x) => workTypeFromJson(x)) ?? []),
        exp: experienceDurationFromJson(json["experience"]),
        tags: List<String>.from(json["tags"]?.map((x) => x) ?? []),
        address: (json["address"]?.isNotEmpty ?? false)
            ? Address.fromJson(json["address"])
            : null,
        bgHeaderColor: json["bg_header_color"],
        pubDate: dateFromJson(json["pub_date"]),
        leading: json["leading"],
        trailing: json["trailing"],
        body: List<Scroll>.from(
            json["body"]?.map((x) => Scroll.fromJson(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": userId,
        "vacancy_name": vacancyName,
        "industry": industry,
        "grade": experienceTypeToJson(grade),
        "salary": salary,
        "work_type": List<dynamic>.from(workType.map((x) => workTypeToJson(x))),
        "experience": experienceDurationToJson(exp),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "address": address?.toJson(),
        "bg_header_color": bgHeaderColor,
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
        this.bgHeaderColor,
        this.pubDate,
        this.leading,
        this.trailing,
        this.body,
      ];
}
