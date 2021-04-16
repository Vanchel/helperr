// To parse this JSON data, do
//
//     final favoriteResult = favoriteResultFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'truncated_vacancy.dart';

VacancyFavoriteResult vacancyFavoriteResultFromJson(String str) =>
    VacancyFavoriteResult.fromJson(json.decode(str));

class VacancyFavoriteResult extends Equatable {
  VacancyFavoriteResult({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  final int count;
  final String next;
  final String previous;
  final List<TruncatedVacancy> results;

  VacancyFavoriteResult copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<TruncatedVacancy> results,
  }) =>
      VacancyFavoriteResult(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory VacancyFavoriteResult.fromJson(Map<String, dynamic> json) =>
      VacancyFavoriteResult(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<TruncatedVacancy>.from(
          json["results"].map((x) => TruncatedVacancy.fromJson(x["vacancy"])),
        ),
      );

  @override
  List<Object> get props => [
        this.count,
        this.next,
        this.previous,
        this.results,
      ];
}
