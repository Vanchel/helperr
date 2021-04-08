// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

import 'detailed_response.dart';
import 'response_state.dart';

Response responseFromJson(String str) => Response.fromJson(json.decode(str));

String responseToJson(Response data) => json.encode(data.toJson());

class Response {
  Response({
    this.id,
    this.workerId,
    this.employerId,
    this.vacancyId,
    this.resumeId,
    this.message,
    this.state = ResponseState.sent,
  });

  final int id;
  final int workerId;
  final int employerId;
  final int vacancyId;
  final int resumeId;
  final String message;
  final ResponseState state;

  Response copyWith({
    int id,
    int workerId,
    int employerId,
    int vacancyId,
    int resumeId,
    String message,
    ResponseState state,
  }) =>
      Response(
        id: id ?? this.id,
        workerId: workerId ?? this.workerId,
        employerId: employerId ?? this.employerId,
        vacancyId: vacancyId ?? this.vacancyId,
        resumeId: resumeId ?? this.resumeId,
        message: message ?? this.message,
        state: state ?? this.state,
      );

  factory Response.fromDetailed(DetailedResponse detailed) => Response(
        id: detailed.id,
        workerId: detailed.worker,
        employerId: detailed.employer,
        vacancyId: detailed.vacancy,
        resumeId: detailed.cv,
        message: detailed.message,
        state: detailed.state,
      );

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        id: null,
        workerId: json["worker"],
        employerId: json["employer"],
        vacancyId: json["vacancy"],
        resumeId: json["cv"],
        message: json["message"],
        state: responseStateFromJson(json["state"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "worker": workerId,
        "employer": employerId,
        "vacancy": vacancyId,
        "cv": resumeId,
        "message": message,
        "state": responseStateToJson(state),
      };
}
