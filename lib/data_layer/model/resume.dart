// To parse this JSON data, do
//
//     final resume = resumeFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:helperr/data_layer/model/worker.dart';

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
  final List<String> workType;
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
    List<String> workType,
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
        // looks wierd
        salary: salary,
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
        userId: json["user_id"],
        vacancyName: json["vacancy_name"],
        industry: json["industry"],
        grade: experienceTypeFromJson(json["grade"]),
        salary: json["salary"],
        workType: List<String>.from(json["work_type"].map((x) => x)),
        tags: List<String>.from(json["tags"].map((x) => x)),
        about: json["about"],
        bgHeaderColor: json["bg_header_color"],
        pubDate: dateFromJson(json["pub_date"]),
        portfolio: List<Portfolio>.from(
            json["portfolio"].map((x) => Portfolio.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "vacancy_name": vacancyName,
        "industry": industry,
        "grade": experienceTypeToJson(grade),
        "salary": salary,
        "work_type": List<dynamic>.from(workType.map((x) => x)),
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

class Portfolio extends Equatable {
  Portfolio({
    this.imgLink,
    this.sourceLink,
  });

  final String imgLink;
  final String sourceLink;

  Portfolio copyWith({
    String imgLink,
    String sourceLink,
  }) =>
      Portfolio(
        imgLink: imgLink ?? this.imgLink,
        sourceLink: sourceLink ?? this.sourceLink,
      );

  factory Portfolio.fromRawJson(String str) =>
      Portfolio.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
        imgLink: json["img_link"],
        sourceLink: json["source_link"],
      );

  Map<String, dynamic> toJson() => {
        "img_link": imgLink,
        "source_link": sourceLink,
      };

  @override
  List<Object> get props => [
        this.imgLink,
        this.sourceLink,
      ];
}
