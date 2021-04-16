// To parse this JSON data, do
//
//     final favoriteResult = favoriteResultFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'truncated_resume.dart';

ResumeFavoriteResult resumeFavoriteResultFromJson(String str) =>
    ResumeFavoriteResult.fromJson(json.decode(str));

class ResumeFavoriteResult extends Equatable {
  ResumeFavoriteResult({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  final int count;
  final String next;
  final String previous;
  final List<TruncatedResume> results;

  ResumeFavoriteResult copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<TruncatedResume> results,
  }) =>
      ResumeFavoriteResult(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory ResumeFavoriteResult.fromJson(Map<String, dynamic> json) =>
      ResumeFavoriteResult(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<TruncatedResume>.from(
          json["results"].map((x) => TruncatedResume.fromJson(x["cv"])),
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
