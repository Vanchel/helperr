// To parse this JSON data, do
//
//     final searchResult = searchResultFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'truncated_resume.dart';

ResumeSearchResult resumeSearchResultFromJson(String str) =>
    ResumeSearchResult.fromJson(json.decode(str));

String resumeSearchResultToJson(ResumeSearchResult data) =>
    json.encode(data.toJson());

class ResumeSearchResult extends Equatable {
  ResumeSearchResult({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  final int count;
  final String next;
  final String previous;
  final List<TruncatedResume> results;

  ResumeSearchResult copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<TruncatedResume> results,
  }) =>
      ResumeSearchResult(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory ResumeSearchResult.fromJson(Map<String, dynamic> json) =>
      ResumeSearchResult(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<TruncatedResume>.from(
          json["results"].map((x) => TruncatedResume.fromJson(x)),
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
