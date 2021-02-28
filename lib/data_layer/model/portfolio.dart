import 'dart:convert';

import 'package:equatable/equatable.dart';

class Portfolio extends Equatable {
  Portfolio({
    this.imgLink,
    this.sourceLink,
  });

  final String imgLink;
  final String sourceLink;

  Portfolio copyWith({
    String imgLink,
    String sourceLink,
  }) =>
      Portfolio(
        imgLink: imgLink ?? this.imgLink,
        sourceLink: sourceLink ?? this.sourceLink,
      );

  factory Portfolio.fromRawJson(String str) =>
      Portfolio.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Portfolio.fromJson(Map<String, dynamic> json) => Portfolio(
        imgLink: json["img_link"],
        sourceLink: json["source_link"],
      );

  Map<String, dynamic> toJson() => {
        "img_link": imgLink,
        "source_link": sourceLink,
      };

  @override
  List<Object> get props => [
        this.imgLink,
        this.sourceLink,
      ];
}
