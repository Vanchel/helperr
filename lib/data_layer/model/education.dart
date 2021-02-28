import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'education_type.dart';
import 'util.dart';

class Education extends Equatable {
  Education({
    this.profession,
    this.university,
    this.type,
    this.startYear,
    this.endYear,
  });

  final String profession;
  final String university;
  final EducationType type;
  final DateTime startYear;
  final DateTime endYear;

  Education copyWith({
    String profession,
    String university,
    EducationType type,
    DateTime startYear,
    DateTime endYear,
  }) =>
      Education(
        profession: profession ?? this.profession,
        university: university ?? this.university,
        type: type ?? this.type,
        startYear: startYear ?? this.startYear,
        endYear: endYear ?? this.endYear,
      );

  factory Education.fromRawJson(String str) =>
      Education.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Education.fromJson(Map<String, dynamic> json) => Education(
        profession: json["profession"],
        university: json["university"],
        type: educationTypeFromJson(json["type"]),
        startYear: dateFromJson(json["start_year"]),
        endYear: dateFromJson(json["end_year"]),
      );

  Map<String, dynamic> toJson() => {
        "profession": profession,
        "university": university,
        "type": educationTypeToJson(type),
        "start_year": dateToJson(startYear),
        "end_year": dateToJson(endYear),
      };

  @override
  List<Object> get props => [
        this.profession,
        this.university,
        this.type,
        this.startYear,
        this.endYear,
      ];
}
