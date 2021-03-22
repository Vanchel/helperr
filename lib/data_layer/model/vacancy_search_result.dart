// To parse this JSON data, do
//
//     final searchResult = searchResultFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'truncated_vacancy.dart';

VacancySearchResult vacancySearchResultFromJson(String str) =>
    VacancySearchResult.fromJson(json.decode(str));

String vacancySearchResultToJson(VacancySearchResult data) =>
    json.encode(data.toJson());

class VacancySearchResult extends Equatable {
  VacancySearchResult({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  final int count;
  final String next;
  final String previous;
  final List<TruncatedVacancy> results;

  VacancySearchResult copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<TruncatedVacancy> results,
  }) =>
      VacancySearchResult(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory VacancySearchResult.fromJson(Map<String, dynamic> json) =>
      VacancySearchResult(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<TruncatedVacancy>.from(
          json["results"].map((x) => TruncatedVacancy.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [
        this.count,
        this.next,
        this.previous,
        this.results,
      ];
}
