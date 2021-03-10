// To parse this JSON data, do
//
//     final resume = resumeFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'util.dart';
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
        pubDate: dateFromJson(json["pub_date"]),
        portfolio: List<Portfolio>.from(
            json["portfolio"]?.map((x) => Portfolio.fromJson(x)) ?? []),
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
        "pub_date": dateToJson(pubDate),
        "portfolio": List<dynamic>.from(portfolio.map((x) => x.toJson())),
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
      ];
}
