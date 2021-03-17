// To parse this JSON data, do
//
//     final truncatedResume = truncatedResumeFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'util.dart';
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
    this.salary,
    this.workTypes,
    this.pubDate,
    this.workerId,
    this.workerName,
    this.photoUrl,
  });

  final int id;
  final String vacancyName;
  final String industry;
  final int salary;
  final Set<WorkType> workTypes;
  final DateTime pubDate;
  final int workerId;
  final String workerName;
  final String photoUrl;

  TruncatedResume copyWith({
    int id,
    String vacancyName,
    String industry,
    int salary,
    Set<WorkType> workTypes,
    DateTime pubDate,
    int workerId,
    String workerName,
    String photoUrl,
  }) =>
      TruncatedResume(
        id: id ?? this.id,
        vacancyName: vacancyName ?? this.vacancyName,
        industry: industry ?? this.industry,
        salary: salary ?? this.salary,
        workTypes: workTypes ?? this.workTypes,
        pubDate: pubDate ?? this.pubDate,
        workerId: workerId ?? this.workerId,
        workerName: workerName ?? this.workerName,
        photoUrl: photoUrl ?? this.photoUrl,
      );

  factory TruncatedResume.fromJson(Map<String, dynamic> json) =>
      TruncatedResume(
        id: json["pk"],
        vacancyName: json["vacancy_name"],
        industry: json["industry"],
        salary: json["salary"],
        workTypes: Set<WorkType>.from(
            json["work_type"]?.map((x) => workTypeFromJson(x)) ?? []),
        pubDate: dateFromJson(json["pub_date"]),
        workerId: json["owner_id"],
        workerName: json["owner"],
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
        "owner_id": workerId,
        "owner": workerName,
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
        this.workerId,
        this.workerName,
        this.photoUrl,
      ];
}
