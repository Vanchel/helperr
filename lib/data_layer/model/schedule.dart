// To parse this JSON data, do
//
//     final schedule = scheduleFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'weekday.dart';

Schedule scheduleFromJson(String str) => Schedule.fromJson(json.decode(str));

String scheduleToJson(Schedule data) => json.encode(data.toJson());

class Schedule extends Equatable {
  Schedule({
    this.day,
    this.endTime,
    this.startTime,
  });

  final Weekday day;
  final String endTime;
  final String startTime;

  Schedule copyWith({
    Weekday day,
    String endTime,
    String startTime,
  }) =>
      Schedule(
        day: day ?? this.day,
        endTime: endTime ?? this.endTime,
        startTime: startTime ?? this.startTime,
      );

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        day: weekdayFromInt(json["day"]) ?? 0,
        endTime: json["end_time"] ?? "00:00",
        startTime: json["start_time"] ?? "00:00",
      );

  Map<String, dynamic> toJson() => {
        "day": weekdayToInt(day) ?? 0,
        "end_time": endTime ?? "00:00",
        "start_time": startTime ?? "00:00",
      };

  @override
  List<Object> get props => [
        this.day,
        this.endTime,
        this.startTime,
      ];
}
