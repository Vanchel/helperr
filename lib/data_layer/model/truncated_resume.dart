// To parse this JSON data, do
//
//     final truncatedResume = truncatedResumeFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'util.dart';
import 'experience_type.dart';
import 'work_type.dart';

TruncatedResume truncatedResumeFromJson(String str) =>
    TruncatedResume.fromJson(json.decode(str));

String truncatedResumeToJson(TruncatedResume data) =>
    json.encode(data.toJson());

class TruncatedResume extends Equatable {
  TruncatedResume({
    this.id,
    this.vacancyName,
    this.industry,
    this.grade,
    this.salary,
    this.workTypes,
    this.about,
    this.bgHeaderColor,
    this.pubDate,
    this.workerId,
    this.workerName,
    this.photoUrl,
    this.gotResponsed,
    this.favorited,
  });

  final int id;
  final String vacancyName;
  final String industry;
  final ExperienceType grade;
  final int salary;
  final Set<WorkType> workTypes;
  final String about;
  final String bgHeaderColor;
  final DateTime pubDate;
  final int workerId;
  final String workerName;
  final String photoUrl;
  final bool gotResponsed;
  final bool favorited;

  TruncatedResume copyWith({
    int id,
    String vacancyName,
    String industry,
    ExperienceType grade,
    int salary,
    Set<WorkType> workTypes,
    String about,
    String bgHeaderColor,
    DateTime pubDate,
    int workerId,
    String workerName,
    String photoUrl,
    bool gotResponsed,
    bool favorited,
  }) =>
      TruncatedResume(
        id: id ?? this.id,
        vacancyName: vacancyName ?? this.vacancyName,
        industry: industry ?? this.industry,
        grade: grade ?? this.grade,
        salary: salary ?? this.salary,
        workTypes: workTypes ?? this.workTypes,
        about: about ?? this.about,
        bgHeaderColor: bgHeaderColor ?? this.bgHeaderColor,
        pubDate: pubDate ?? this.pubDate,
        workerId: workerId ?? this.workerId,
        workerName: workerName ?? this.workerName,
        photoUrl: photoUrl ?? this.photoUrl,
        gotResponsed: gotResponsed ?? this.gotResponsed,
        favorited: favorited ?? this.favorited,
      );

  factory TruncatedResume.fromJson(Map<String, dynamic> json) =>
      TruncatedResume(
        id: json["pk"],
        vacancyName: json["vacancy_name"],
        industry: json["industry"],
        grade: experienceTypeFromJson(json["grade"]),
        salary: json["salary"] ?? -1,
        workTypes: Set<WorkType>.from(
            json["work_type"]?.map((x) => workTypeFromJson(x)) ?? []),
        about: json["about"],
        bgHeaderColor: json["bg_header_color"],
        pubDate: dateFromJson(json["pub_date"]),
        workerId: json["owner_id"],
        workerName: json["owner"],
        photoUrl: json["photo_url"],
        gotResponsed: json["got_responsed"],
        favorited: json["favorite"],
      );

  Map<String, dynamic> toJson() => {
        "pk": id,
        "vacancy_name": vacancyName,
        "industry": industry,
        "grade": experienceTypeToJson(grade),
        "salary": salary,
        "work_type":
            List<dynamic>.from(workTypes.map((x) => workTypeToJson(x))),
        "about": about,
        "bg_header_color": bgHeaderColor,
        "pub_date": dateToJson(pubDate),
        "owner_id": workerId,
        "owner": workerName,
        "photo_url": photoUrl,
        "got_responsed": gotResponsed,
        "favorite": favorited,
      };

  @override
  List<Object> get props => [
        this.id,
        this.vacancyName,
        this.industry,
        this.grade,
        this.salary,
        this.workTypes,
        this.about,
        this.bgHeaderColor,
        this.pubDate,
        this.workerId,
        this.workerName,
        this.photoUrl,
        this.gotResponsed,
        this.favorited,
      ];
}
