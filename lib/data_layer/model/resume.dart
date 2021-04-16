// To parse this JSON data, do
//
//     final resume = resumeFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'experience_type.dart';
import 'work_type.dart';
import 'portfolio.dart';

Resume resumeFromJson(String str) => Resume.fromJson(json.decode(str));

String resumeToJson(Resume data) => json.encode(data.toJson());

class Resume extends Equatable {
  Resume({
    this.id,
    this.userId,
    this.vacancyName,
    this.industry,
    this.grade,
    this.salary,
    this.workType,
    this.tags,
    this.about,
    this.bgHeaderColor,
    this.pubDate,
    this.portfolio,
    this.gotResponsed,
    this.favorited,
  });

  final int id;
  final int userId;
  final String vacancyName;
  final String industry;
  final ExperienceType grade;
  final int salary;
  final Set<WorkType> workType;
  final List<String> tags;
  final String about;
  final String bgHeaderColor;
  final DateTime pubDate;
  final List<Portfolio> portfolio;
  final bool gotResponsed;
  final bool favorited;

  Resume copyWith({
    int id,
    int userId,
    String vacancyName,
    String industry,
    ExperienceType grade,
    int salary,
    Set<WorkType> workType,
    List<String> tags,
    String about,
    String bgHeaderColor,
    DateTime pubDate,
    List<Portfolio> portfolio,
    bool gotResponsed,
    bool favorited,
  }) =>
      Resume(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        vacancyName: vacancyName ?? this.vacancyName,
        industry: industry ?? this.industry,
        grade: grade ?? this.grade,
        salary: salary ?? this.salary,
        workType: workType ?? this.workType,
        tags: tags ?? this.tags,
        about: about ?? this.about,
        bgHeaderColor: bgHeaderColor ?? this.bgHeaderColor,
        pubDate: pubDate ?? this.pubDate,
        portfolio: portfolio ?? this.portfolio,
        gotResponsed: gotResponsed ?? this.gotResponsed,
        favorited: favorited ?? this.favorited,
      );

  factory Resume.fromRawJson(String str) => Resume.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Resume.fromJson(Map<String, dynamic> json) => Resume(
        id: json["id"],
        userId: json["user"],
        vacancyName: json["vacancy_name"],
        industry: json["industry"],
        grade: experienceTypeFromJson(json["grade"]),
        salary: json["salary"],
        workType: Set<WorkType>.from(
            json["work_type"]?.map((x) => workTypeFromJson(x)) ?? []),
        tags: List<String>.from(json["tags"]?.map((x) => x) ?? []),
        about: json["about"],
        bgHeaderColor: json["bg_header_color"],
        pubDate: DateTime.parse(json["pub_date"]),
        portfolio: List<Portfolio>.from(
            json["portfolio"]?.map((x) => Portfolio.fromJson(x)) ?? []),
        gotResponsed: json["got_responsed"],
        favorited: json["favorite"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "vacancy_name": vacancyName,
        "industry": industry,
        "grade": experienceTypeToJson(grade),
        "salary": salary,
        "work_type": List<dynamic>.from(workType.map((x) => workTypeToJson(x))),
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "about": about,
        "bg_header_color": bgHeaderColor,
        "pub_date": pubDate.toIso8601String(),
        "portfolio": List<dynamic>.from(portfolio.map((x) => x.toJson())),
        "got_responsed": gotResponsed,
        "favorite": favorited,
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
        this.tags,
        this.about,
        this.bgHeaderColor,
        this.pubDate,
        this.portfolio,
        this.gotResponsed,
        this.favorited,
      ];
}
