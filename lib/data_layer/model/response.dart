// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

import 'response_state.dart';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    this.workerId,
    this.employerId,
    this.vacancyId,
    this.resumeId,
    this.message,
    this.state = ResponseState.sent,
  });

  final int workerId;
  final int employerId;
  final int vacancyId;
  final int resumeId;
  final String message;
  final ResponseState state;

  Response copyWith({
    int workerId,
    int employerId,
    int vacancyId,
    int resumeId,
    String message,
    ResponseState state,
  }) =>
      Response(
        workerId: workerId ?? this.workerId,
        employerId: employerId ?? this.employerId,
        vacancyId: vacancyId ?? this.vacancyId,
        resumeId: resumeId ?? this.resumeId,
        message: message ?? this.message,
        state: state ?? this.state,
      );

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        workerId: json["worker"],
        employerId: json["employer"],
        vacancyId: json["vacancy_response"],
        resumeId: json["worker_cv"],
        message: json["message"],
        state: responseStateFromJson(json["state"]),
      );

  Map<String, dynamic> toJson() => {
        "worker": workerId,
        "employer": employerId,
        "vacancy_response": vacancyId,
        "worker_cv": resumeId,
        "message": message,
        "state": responseStateToJson(state),
      };
}
