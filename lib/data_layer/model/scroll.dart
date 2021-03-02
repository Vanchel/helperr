import 'package:equatable/equatable.dart';

class Scroll extends Equatable {
  Scroll({
    this.title,
    this.subtitle,
    this.points,
  });

  final String title;
  final String subtitle;
  final List<String> points;

  Scroll copyWith({
    String title,
    String subtitle,
    List<String> points,
  }) =>
      Scroll(
        title: title ?? this.title,
        subtitle: subtitle ?? this.subtitle,
        points: points ?? this.points,
      );

  factory Scroll.fromJson(Map<String, dynamic> json) => Scroll(
        title: json["title"],
        subtitle: json["subtitle"],
        points: List<String>.from(json["points"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
        "points": List<dynamic>.from(points.map((x) => x)),
      };

  @override
  List<Object> get props => [
        this.title,
        this.subtitle,
        this.points,
      ];
}
