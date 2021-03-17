// To parse this JSON data, do
//
//     final truncatedVacancy = truncatedVacancyFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'util.dart';
import 'work_type.dart';

TruncatedVacancy truncatedVacancyFromJson(String str) =>
    TruncatedVacancy.fromJson(json.decode(str));

String truncatedVacancyToJson(TruncatedVacancy data) =>
    json.encode(data.toJson());

class TruncatedVacancy extends Equatable {
  TruncatedVacancy({
    this.id,
    this.vacancyName,
    this.industry,
    this.salary,
    this.workTypes,
    this.pubDate,
    this.employerId,
    this.employerName,
    this.photoUrl,
  });

  final int id;
  final String vacancyName;
  final String industry;
  final int salary;
  final Set<WorkType> workTypes;
  final DateTime pubDate;
  final int employerId;
  final String employerName;
  final String photoUrl;

  TruncatedVacancy copyWith({
    int id,
    String vacancyName,
    String industry,
    int salary,
    Set<WorkType> workTypes,
    DateTime pubDate,
    int employerId,
    String employerName,
    String photoUrl,
  }) =>
      TruncatedVacancy(
        id: id ?? this.id,
        vacancyName: vacancyName ?? this.vacancyName,
        industry: industry ?? this.industry,
        salary: salary ?? this.salary,
        workTypes: workTypes ?? this.workTypes,
        pubDate: pubDate ?? this.pubDate,
        employerId: employerId ?? this.employerId,
        employerName: employerName ?? this.employerName,
        photoUrl: photoUrl ?? this.photoUrl,
      );

  factory TruncatedVacancy.fromJson(Map<String, dynamic> json) =>
      TruncatedVacancy(
        id: json["pk"],
        vacancyName: json["vacancy_name"],
        industry: json["industry"],
        salary: json["salary"],
        workTypes: Set<WorkType>.from(
            json["work_type"]?.map((x) => workTypeFromJson(x)) ?? []),
        pubDate: dateFromJson(json["pub_date"]),
        employerId: json["owner_id"],
        employerName: json["owner"],
        photoUrl: json["photo_url"],
      );

  Map<String, dynamic> toJson() => {
        "pk": id,
        "vacancy_name": vacancyName,
        "industry": industry,
        "salary": salary,
        "work_type":
            List<dynamic>.from(workTypes.map((x) => workTypeToJson(x))),
        "pub_date": dateToJson(pubDate),
        "owner_id": employerId,
        "owner": employerName,
        "photo_url": photoUrl,
      };

  @override
  List<Object> get props => [
        this.id,
        this.vacancyName,
        this.industry,
        this.salary,
        this.workTypes,
        this.pubDate,
        this.employerId,
        this.employerName,
        this.photoUrl,
      ];
}
