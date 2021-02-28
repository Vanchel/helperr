import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'experience_type.dart';
import 'util.dart';

class Exp extends Equatable {
  Exp({
    this.position,
    this.company,
    this.type,
    this.startYear,
    this.endYear,
  });

  final String position;
  final String company;
  final ExperienceType type;
  final DateTime startYear;
  final DateTime endYear;

  Exp copyWith({
    String position,
    String company,
    ExperienceType type,
    DateTime startYear,
    DateTime endYear,
  }) =>
      Exp(
        position: position ?? this.position,
        company: company ?? this.company,
        type: type ?? this.type,
        startYear: startYear ?? this.startYear,
        endYear: endYear ?? this.endYear,
      );

  factory Exp.fromRawJson(String str) => Exp.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Exp.fromJson(Map<String, dynamic> json) => Exp(
        position: json["position"],
        company: json["company"],
        type: experienceTypeFromJson(json["type"]),
        startYear: dateFromJson(json["start_year"]),
        endYear: dateFromJson(json["end_year"]),
      );

  Map<String, dynamic> toJson() => {
        "position": position,
        "company": company,
        "type": experienceTypeToJson(type),
        "start_year": dateToJson(startYear),
        "end_year": dateToJson(endYear),
      };

  @override
  List<Object> get props => [
        this.position,
        this.company,
        this.type,
        this.startYear,
        this.endYear,
      ];
}
