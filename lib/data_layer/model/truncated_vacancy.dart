// To parse this JSON data, do
//
//     final truncatedVacancy = truncatedVacancyFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'experience_type.dart';
import 'address.dart';
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
    this.grade,
    this.salary,
    this.address,
    this.workTypes,
    this.leading,
    this.bgHeaderColor,
    this.pubDate,
    this.employerId,
    this.employerName,
    this.photoUrl,
    this.gotResponsed,
    this.favorited,
  });

  final int id;
  final String vacancyName;
  final String industry;
  final ExperienceType grade;
  final int salary;
  final Address address;
  final Set<WorkType> workTypes;
  final String leading;
  final String bgHeaderColor;
  final DateTime pubDate;
  final int employerId;
  final String employerName;
  final String photoUrl;
  final bool gotResponsed;
  final bool favorited;

  TruncatedVacancy copyWith({
    int id,
    String vacancyName,
    String industry,
    ExperienceType grade,
    int salary,
    Address address,
    Set<WorkType> workTypes,
    String leading,
    String bgHeaderColor,
    DateTime pubDate,
    int employerId,
    String employerName,
    String photoUrl,
    bool gotResponsed,
    bool favorited,
  }) =>
      TruncatedVacancy(
        id: id ?? this.id,
        vacancyName: vacancyName ?? this.vacancyName,
        industry: industry ?? this.industry,
        grade: grade ?? this.grade,
        salary: salary ?? this.salary,
        address: address ?? this.address,
        workTypes: workTypes ?? this.workTypes,
        leading: leading ?? this.leading,
        bgHeaderColor: bgHeaderColor ?? this.bgHeaderColor,
        pubDate: pubDate ?? this.pubDate,
        employerId: employerId ?? this.employerId,
        employerName: employerName ?? this.employerName,
        photoUrl: photoUrl ?? this.photoUrl,
        gotResponsed: gotResponsed ?? this.gotResponsed,
        favorited: favorited ?? this.favorited,
      );

  factory TruncatedVacancy.fromJson(Map<String, dynamic> json) =>
      TruncatedVacancy(
        id: json["pk"],
        vacancyName: json["vacancy_name"],
        industry: json["industry"],
        grade: experienceTypeFromJson(json["grade"]),
        salary: json["salary"] ?? -1,
        address: (json["address"]?.isNotEmpty ?? false)
            ? Address.fromJson(json["address"])
            : Address.empty,
        workTypes: Set<WorkType>.from(
            json["work_type"]?.map((x) => workTypeFromJson(x)) ?? []),
        leading: json["leading"],
        bgHeaderColor: json["bg_header_color"],
        pubDate: DateTime.parse(json["pub_date"]),
        employerId: json["owner_id"],
        employerName: json["owner"],
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
        "address": addressToJson(address),
        "work_type":
            List<dynamic>.from(workTypes.map((x) => workTypeToJson(x))),
        "leading": leading,
        "bg_header_color": bgHeaderColor,
        "pub_date": pubDate.toIso8601String(),
        "owner_id": employerId,
        "owner": employerName,
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
        this.address,
        this.workTypes,
        this.leading,
        this.bgHeaderColor,
        this.pubDate,
        this.employerId,
        this.employerName,
        this.photoUrl,
        this.gotResponsed,
        this.favorited,
      ];
}
