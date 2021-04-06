// To parse this JSON data, do
//
//     final searchResult = searchResultFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'detailed_response.dart';

DetailedResponseResult detailedResponseResultFromJson(String str) =>
    DetailedResponseResult.fromJson(json.decode(str));

String detailedResponseResultToJson(DetailedResponseResult data) =>
    json.encode(data.toJson());

class DetailedResponseResult extends Equatable {
  DetailedResponseResult({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  final int count;
  final String next;
  final String previous;
  final List<DetailedResponse> results;

  DetailedResponseResult copyWith({
    int count,
    dynamic next,
    dynamic previous,
    List<DetailedResponse> results,
  }) =>
      DetailedResponseResult(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );

  factory DetailedResponseResult.fromJson(Map<String, dynamic> json) =>
      DetailedResponseResult(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<DetailedResponse>.from(
          json["results"].map((x) => DetailedResponse.fromJson(x)),
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
