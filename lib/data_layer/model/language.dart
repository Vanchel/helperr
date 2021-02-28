import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'language_proficiency.dart';

class Language extends Equatable {
  Language({
    this.language,
    this.grade,
  });

  final String language;
  final LanguageProficiency grade;

  Language copyWith({
    String language,
    LanguageProficiency grade,
  }) =>
      Language(
        language: language ?? this.language,
        grade: grade ?? this.grade,
      );

  factory Language.fromRawJson(String str) =>
      Language.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        language: json["language"],
        grade: languageProficiencyFromJson(json["grade"]),
      );

  Map<String, dynamic> toJson() => {
        "language": language,
        "grade": languageProficiencyToJson(grade),
      };

  @override
  List<Object> get props => [
        this.language,
        this.grade,
      ];
}
